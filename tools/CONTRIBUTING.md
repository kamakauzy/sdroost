# Contributing

Thanks for improving SDRoost. Please keep the cross pocket, the mast interface and the cable-bend envelope intact so existing printed masts and inserts still fit. The formal numbers are in [`models/field-roost/INTERFACE.md`](../models/field-roost/INTERFACE.md).

## Mesh gates (run these before you open a pull request)

A mesh can be one watertight body and still come apart on the printer. Every new or re-exported STL has to pass `check_connectivity.py`. Print-in-place parts (the Field Roost, the Laptop Perch body with its captive foot) also have to pass `check_capture.py`.

Install the Python dependencies:

```
pip install trimesh manifold3d shapely numpy
```

From the repository root:

```
# Field Roost: 5 bodies (hub + 4 legs)
python tools/check_connectivity.py models/field-roost/rtlsdr_v4_3_universal_stand_print.stl --expect 5
python tools/check_connectivity.py models/field-roost/rtlsdr_v4_3_universal_stand_folded.stl --expect 5
python tools/check_capture.py models/field-roost/rtlsdr_v4_3_universal_stand_print.stl

# Laptop Perch body: 2 bodies (body + captive foot)
python tools/check_connectivity.py models/laptop-perch/laptop_body_print.stl --expect 2
python tools/check_capture.py models/laptop-perch/laptop_body_print.stl

# Everything else is a single body
python tools/check_connectivity.py models/laptop-perch/laptop_hook.stl --expect 1
python tools/check_connectivity.py models/laptop-perch/knob_m4_x1.stl --expect 1
python tools/check_connectivity.py models/phone-nest/phone_rotor.stl --expect 1
python tools/check_connectivity.py models/phone-nest/phone_body.stl --expect 1
python tools/check_connectivity.py models/phone-nest/phone_slider.stl --expect 1
python tools/check_connectivity.py models/mast/antenna_mast.stl --expect 1
python tools/check_connectivity.py models/mast/antenna_insert_na771.stl --expect 1
python tools/check_connectivity.py models/mast/antenna_insert_rh789_bnc.stl --expect 1
python tools/check_connectivity.py models/mast/antenna_insert_srh789_sma.stl --expect 1
```

The scripts exit 0 on PASS and 1 on FAIL.

`check_connectivity.py` checks:

1. **Mesh shells.** The count must equal `--expect`, the mesh must be watertight, and there must be no non-manifold edges.
2. **Layer islands.** 0.2 mm slices, each eroded by 0.6 mm, so any in-plane neck under 1.2 mm counts as broken. Islands have to link layer to layer. A body that does not start on the bed is flagged as floating and fails.
3. **3D thickness.** Any join thinner than 1.6 mm in X, Y or Z counts as broken (first-layer beads are exempt). Every solid region must still belong to one body per part.

`check_capture.py` translates every body other than the largest by 3 mm along all 26 straight directions. Each one must collide with the main body (captured), and at rest the overlap must be 0 mm³ (not fused).

## Design rule for joins

Every join between modelled features needs a real volumetric overlap of at least 2 mm along the joined feature. If that is not possible, use a gusset or a root boss. Faces, edges or vertices that only touch do not count. If the parts are differenced, cut the cavities after the union so overlaps do not intrude into them.

## License

Models, documentation and images stay CC BY-SA 4.0. Scripts in this folder stay MIT. See the [LICENSE](../LICENSE) at the repository root.
