#!/usr/bin/env python3
"""
check_connectivity.py - MANDATORY pre-export gate for every printable STL.

Catches parts that are "one body" in the mesh but come apart on the printer:
  1. mesh shells      : trimesh face-connected components (separate shells), watertight,
                        winding, non-manifold edges (edge shared by >2 faces = edge/vertex-only contact)
  2. slicer islands   : slices the part every --layer mm (default 0.2 = real layer height), erodes each
                        slice by --erode mm (default 0.6 -> any neck narrower than 1.2 mm, i.e. < 3
                        extrusion lines, counts as BROKEN), then links eroded islands of consecutive
                        layers that overlap by >= --link mm^2 (default 2.0). The number of resulting
                        "robust bodies" must equal the expected body count.
                        Every robust body that does not start on the bed is reported as FLOATING.
  3. 3-D thickness    : solid eroded by a 0.8 mm cylinder in X, Y and Z (so any join thinner than 1.6 mm
                        in ANY direction is broken; bed layers are not penalised). Every substantial
                        region (>= 30 mm3 eroded) must belong to ONE region per shell. Catches joins that
                        pass the in-plane rule only through a thin first-layer flange (v3 RTL legs: 1.2 mm
                        tall x 1.25 mm wide sliver).
  4. per-shell        : each mesh shell must itself be exactly one robust body (a shell that splits =
                        a weak join hidden inside a single shell, e.g. legs touching a column only by a
                        sliver - the v3 RTL stand failure).
Usage:
  check_connectivity.py part.stl --expect N [--erode 0.6 --link 2.0 --layer 0.2]
  check_connectivity.py --manifest manifest.json        (batch; exit code 1 if anything fails)
Exit code 0 = PASS, 1 = FAIL.
"""
import sys, json, argparse, os
import numpy as np, trimesh
from shapely.geometry import Polygon, MultiPolygon
from shapely.ops import unary_union

def _manifold(mesh):
    import manifold3d as m3
    return m3.Manifold(m3.Mesh(vert_properties=np.asarray(mesh.vertices, np.float32), tri_verts=np.asarray(mesh.faces, np.uint32)))

def _signed(r):
    x, y = r[:, 0], r[:, 1]
    return 0.5 * float(np.sum(x * np.roll(y, -1) - np.roll(x, -1) * y))

def slice_polys(man, z):
    """exact cross-section of the solid at height z (manifold3d), as shapely polygons (one per island)"""
    out = []
    for part in man.slice(z).decompose():
        rings = [np.asarray(r) for r in part.to_polygons() if len(r) >= 3]
        outers = [r for r in rings if _signed(r) > 0]; holes = [r for r in rings if _signed(r) < 0]
        g = unary_union([Polygon(r).buffer(0) for r in outers]) if outers else None
        if g is None: continue
        for h in holes: g = g.difference(Polygon(h).buffer(0))
        out += list(g.geoms) if isinstance(g, MultiPolygon) else [g]
    return out

def _slices(mesh, layer):
    z0, z1 = mesh.bounds[0][2], mesh.bounds[1][2]
    zs = np.arange(z0 + layer/2, z1, layer)
    man = _manifold(mesh)
    out = []
    for z in zs:
        raw = slice_polys(man, z)
        merged = unary_union(raw) if raw else None
        out.append([] if merged is None or merged.is_empty else (list(merged.geoms) if isinstance(merged, MultiPolygon) else [merged]))
    return zs, out

def _components(zs, layers, erode, link, layer, min_area):
    """erode every slice island by `erode`, link consecutive-layer pieces overlapping >= link mm2, union-find"""
    nodes, by_layer, weak = [], [], []
    for i, raw_parts in enumerate(layers):
        idx = []
        for rp in raw_parts:
            er = rp.buffer(-erode)
            parts = [g for g in (er.geoms if isinstance(er, MultiPolygon) else [er]) if not g.is_empty and g.area >= min_area]
            if len(parts) > 1:
                weak.append((round(float(zs[i]), 2), len(parts), [tuple(np.round(p.centroid.coords[0], 1)) for p in parts]))
            for p in parts:
                nodes.append((i, p)); idx.append(len(nodes) - 1)
        by_layer.append(idx)
    parent = list(range(len(nodes)))
    def find(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]; a = parent[a]
        return a
    for i in range(1, len(by_layer)):
        for a in by_layer[i - 1]:
            for b in by_layer[i]:
                pa, pb = nodes[a][1], nodes[b][1]
                if pa.bounds[2] < pb.bounds[0] or pb.bounds[2] < pa.bounds[0] or pa.bounds[3] < pb.bounds[1] or pb.bounds[3] < pa.bounds[1]:
                    continue
                if pa.intersection(pb).area >= link:
                    parent[find(a)] = find(b)
    comps = {}
    for n in range(len(nodes)):
        comps.setdefault(find(n), []).append(n)
    out = []
    for c, members in comps.items():
        lays = [nodes[m][0] for m in members]
        area = sum(nodes[m][1].area for m in members) * layer
        big = max(members, key=lambda m: nodes[m][1].area)
        out.append(dict(z_min=round(float(zs[min(lays)] - layer/2), 2), z_max=round(float(zs[max(lays)] + layer/2), 2),
                        vol_eroded=round(area, 1), on_bed=min(lays) == 0,
                        xy=tuple(np.round(nodes[big][1].centroid.coords[0], 1))))
    return out, weak

def _thick_layers(zs, layers, r, layer):
    """3-D erosion by a cylinder (radius r, half-height r): material that is >= 2r thick in X, Y AND Z.
    window is clamped at the bed (the bed supports the first layers) but not elsewhere."""
    k = max(1, int(round(r / layer)))
    out = []
    for i in range(len(layers)):
        lo, hi = max(0, i - k), min(len(layers) - 1, i + k)
        g = None
        for j in range(lo, hi + 1):
            u = unary_union(layers[j]) if layers[j] else None
            if u is None or u.is_empty: g = None; break
            g = u if g is None else g.intersection(u)
            if g.is_empty: break
        if g is None or g.is_empty: out.append([]); continue
        g = g.buffer(0)
        out.append(list(g.geoms) if hasattr(g, 'geoms') else [g])
    return out

def robust_bodies(mesh, erode=0.6, link=2.0, layer=0.2, min_area=0.5, thick=0.8, thick_vol=30.0):
    """returns (robust bodies, weak layers, thick regions)
    robust: per-layer erosion 0.6 (in-plane necks < 1.2 mm broken); crumbs < 2 mm3 ignored.
    thick : 3-D erosion 0.8 (any join thinner than 1.6 mm in X, Y or Z is broken, e.g. a leg that only
            touches its column through a 1.2 mm first-layer flange). Regions >= thick_vol mm3 (eroded) count;
            all of them must be ONE region per shell."""
    zs, layers = _slices(mesh, layer)
    rb, weak = _components(zs, layers, erode, link, layer, min_area)
    rb = [o for o in rb if o['vol_eroded'] >= 2.0]
    tl = _thick_layers(zs, layers, thick, layer)
    st, _ = _components(zs, tl, thick, 1.0, layer, 0.2)
    st = [o for o in st if o['vol_eroded'] >= thick_vol]
    return rb, weak, st

def check(path, expect, erode=0.6, link=2.0, layer=0.2, verbose=True):
    m = trimesh.load(path, force='mesh')
    shells = m.split(only_watertight=False)
    edges = m.edges_sorted
    uniq, cnt = np.unique(edges, axis=0, return_counts=True)
    nonmanifold = int((cnt > 2).sum())
    res = dict(file=path, watertight=bool(m.is_watertight), winding=bool(m.is_winding_consistent),
               nonmanifold_edges=nonmanifold, shells=len(shells), expect=expect, problems=[])
    if not m.is_watertight: res['problems'].append('not watertight')
    if nonmanifold: res['problems'].append(f'{nonmanifold} non-manifold edges (edge/vertex-only contact)')
    if len(shells) != expect: res['problems'].append(f'{len(shells)} mesh shells, expected {expect}')
    per = []
    for k, s in enumerate(shells):
        rb, weak, sh = robust_bodies(s, erode, link, layer)
        floating = [b for b in rb if not b['on_bed'] and b['z_min'] > s.bounds[0][2] + layer]
        bed_ok = abs(s.bounds[0][2] - m.bounds[0][2]) < 0.05
        per.append(dict(shell=k, vol=round(s.volume/1000, 2), robust=len(rb), bodies=rb, weak_layers=weak[:6], n_weak_layers=len(weak), strict=len(sh), strict_regions=sh))
        if len(rb) != 1:
            res['problems'].append(f'shell {k} ({s.volume/1000:.2f} cm3) splits into {len(rb)} robust bodies under {2*erode:.1f} mm neck / {link} mm2 layer-link rule -> weak or floating join; e.g. weak layers {weak[:3]}')
        if len(sh) > 1:
            res['problems'].append(f'shell {k}: solid regions joined only through material < 1.6 mm thick in X/Y/Z (3-D thickness pass: {len(sh)} regions) -> weak join, add overlap/gusset: ' + '; '.join(f"z {r['z_min']}-{r['z_max']} near {r['xy']}" for r in sh[:6]))
        if not bed_ok:
            res['problems'].append(f'shell {k} does not touch the bed (z_min {s.bounds[0][2]:.2f})')
        for b in floating:
            res['problems'].append(f'shell {k}: island starting at z {b["z_min"]} near {b["xy"]} is FLOATING (no support below)')
    res['per_shell'] = per
    res['pass'] = not res['problems']
    if verbose:
        print(f"{'PASS' if res['pass'] else 'FAIL'}  {os.path.relpath(path)}  shells {len(shells)}/{expect}  watertight {res['watertight']}  nonmanifold {nonmanifold}")
        for p in per:
            print(f"      shell {p['shell']}: {p['vol']} cm3 -> {p['robust']} robust body(ies) [1.2 mm neck rule], {p['strict']} solid region(s) [1.6 mm 3-D thickness rule], {p['n_weak_layers']} layers with <1.2 mm necks")
        for p in res['problems']: print('      !', p)
    return res

if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument('stl', nargs='?'); ap.add_argument('--expect', type=int, default=1)
    ap.add_argument('--manifest'); ap.add_argument('--erode', type=float, default=0.6)
    ap.add_argument('--link', type=float, default=2.0); ap.add_argument('--layer', type=float, default=0.2)
    ap.add_argument('--json')
    a = ap.parse_args()
    results = []
    if a.manifest:
        man = json.load(open(a.manifest)); base = os.path.dirname(os.path.abspath(a.manifest))
        for e in man:
            p = e['file'] if os.path.isabs(e['file']) else os.path.join(base, e['file'])
            r = check(p, e['expect'], e.get('erode', a.erode), e.get('link', a.link), a.layer); r['note'] = e.get('note', ''); results.append(r)
    else:
        results.append(check(a.stl, a.expect, a.erode, a.link, a.layer))
    if a.json: json.dump(results, open(a.json, 'w'), indent=1, default=str)
    sys.exit(0 if all(r['pass'] for r in results) else 1)
