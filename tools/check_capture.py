#!/usr/bin/env python3
"""check_capture.py - for print-in-place STLs: every separate body must be mechanically captured by
the main (largest) body. Each small body is translated 3 mm along 26 directions; if it can move in
ANY straight direction without colliding with the main body it is reported as NOT captured.
Usage: check_capture.py part.stl [--step 3.0]   exit 1 if any body is free."""
import sys, argparse, itertools, numpy as np, trimesh, manifold3d as m3
def M(m): return m3.Manifold(m3.Mesh(vert_properties=np.asarray(m.vertices, np.float32), tri_verts=np.asarray(m.faces, np.uint32)))
ap = argparse.ArgumentParser(); ap.add_argument('stl'); ap.add_argument('--step', type=float, default=3.0); a = ap.parse_args()
sh = sorted(trimesh.load(a.stl, force='mesh').split(only_watertight=False), key=lambda s: -s.volume)
hub = M(sh[0]); ok = True
dirs = [np.array(d, float) for d in itertools.product([-1, 0, 1], repeat=3) if any(d)]
for k, s in enumerate(sh[1:], 1):
    b = M(s); rest = (b ^ hub).volume()
    free = []
    for d in dirs:
        v = d / np.linalg.norm(d) * a.step
        hit = max((b.translate(tuple(v * f)) ^ hub).volume() for f in (0.33, 0.66, 1.0))
        if hit <= rest + 1e-3: free.append(tuple(int(x) for x in d))
    print(f"body {k} ({s.volume/1000:.2f} cm3): at-rest overlap {rest:.3f} mm3, free straight directions: {free if free else 'none'} -> {'CAPTURED' if not free else 'NOT CAPTURED'}")
    ok &= not free
print('PASS' if ok else 'FAIL'); sys.exit(0 if ok else 1)
