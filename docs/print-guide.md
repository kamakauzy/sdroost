# Print guide

Designed around a **Creality K2 Pro** with a 0.4 mm nozzle, but any FDM printer that can hold the footprint will do. No supports anywhere. Print every STL in the orientation it was exported.

PETG is preferred for the rigid parts (PLA is fine indoors). Print the grip inserts and the mount pads in TPU 95A when you can.

## Shared settings (rigid parts)

| Setting | Value |
|---|---|
| Layer height | 0.2 mm |
| Walls | 4 |
| Top / bottom layers | 5 (Laptop Perch and Phone Nest; use at least this on the Field Roost too) |
| Infill | 30 % gyroid (Field Roost, Laptop Perch, Phone Nest, and the mast) |
| Nozzle / bed, PETG | 240 °C / 80 °C |
| Nozzle / bed, PLA | 215 °C / 60 °C |
| Supports | none |

The Field Roost, Laptop Perch body (with its captive foot), Phone Nest rotor, and mast are all print-in-place or tall parts. After they come off the bed, work the moving joints free by hand before you assemble anything.

**Brim and hinges.** Several parts ask for a 5 mm brim. A brim must not weld a 0.35 mm hinge or latch gap shut. If your slicer wants to bridge those gaps, use a paint-on brim or mouse ears on the pads / skirt only.

## Field Roost

Print **`rtlsdr_v4_3_universal_stand_print.stl`**, not the `_folded.stl` file. The folded file is a reference pose only.

- **Orientation:** flat on the bed, legs deployed, as exported.
- **Footprint / height:** 184 × 184 mm bed, 158 mm tall.
- **Brim:** 5 mm, without bridging the hinge or latch gaps.
- **Volume:** 201.7 cm³ (hub 97.1 cm³, legs 4 × 26.2 cm³).
- **As printed (about 0.65 effective fill):** about 167 g PETG, or about 163 g PLA. Solid would be about 256 g PETG / 250 g PLA.
- **After printing:** flex each latch tab a few times, then swing each leg through both the deployed and folded positions to free the hinges. Start gently; the first pass can need a firm push past the tooth.

The four legs are captured in the hub (print-in-place). Do not try to snap them off the plate as separate parts.

## Laptop Perch

| STL | Orientation (as exported) | Volume | PETG / PLA at 0.65 fill |
|---|---|---|---|
| `laptop_body_print.stl` | Upright, foot printed in place stowed | 116.0 cm³ | 95.7 / 93.5 g |
| `laptop_hook.stl` | Bar top down | 9.4 cm³ | 7.8 / 7.6 g |
| `knob_m4_x1.stl` | Flat (print one for this mount) | 4.5 cm³ | 3.7 / 3.6 g |
| `laptop_tpu_pad_lip_x2.stl` | Flat, TPU 95A (print 2) | 0.97 cm³ | 1.2 g |
| `laptop_tpu_pad_bar.stl` | Flat, TPU 95A | 0.91 cm³ | 1.1 g |
| `laptop_tpu_screw_cap.stl` | Flat, TPU 95A | 0.32 cm³ | 0.4 g |

After the body prints, swing the rear foot out of the stowed position to break the hinge free. It is captured, like the Field Roost legs: 2 shells in the STL, body plus foot.

## Phone Nest

| STL | Orientation (as exported) | Volume | PETG / PLA at 0.65 fill |
|---|---|---|---|
| `phone_rotor.stl` | Upright, tail on the bed (210.5 mm tall; 5 mm brim advised) | 106.4 cm³ | 87.8 / 85.8 g |
| `phone_body.stl` | On its −Y side face | 34.8 cm³ | 28.8 / 28.1 g |
| `phone_slider.stl` | Top face down | 12.4 cm³ | 10.3 / 10.0 g |
| `knob_m4_x1.stl` | Flat (print one for this mount) | 4.5 cm³ | 3.7 / 3.6 g |
| `phone_tpu_jaw_pad_x2.stl` | Flat, TPU 95A (print 2) | 0.63 cm³ | 0.8 g |
| `phone_tpu_back_pad.stl` | Flat, TPU 95A | 1.87 cm³ | 2.3 g |

The rotor is tall. Make sure it is well brimed and that the first layers have good adhesion.

## Mast and inserts

- **Mast** (`antenna_mast.stl`): PETG or ASA, printed upright with the skirt on the bed, no supports. 4 walls, 30 % gyroid. A **5 mm brim is recommended** because the part is tall on a 3 mm skirt. All main overhangs are 45° or less (seat chamfer, cone roof, peaked windows, lug notches, teardrop bolt holes). The only flat overhang is the 1.5 mm ring around the bulkhead hole. Size 60.6 × 38.6 × 96.5 mm, volume 36.18 cm³, about 39 g as printed.
- **Inserts:** TPU 95A, flange down on the bed, 3 walls, 30 % infill. PETG works but grips less. A TPU insert can be wrapped around the whip; a PETG insert has to slide down from the antenna tip. Volume 6.66 / 6.05 / 8.75 cm³ depending on the insert; about 7–10 g TPU (the NA-771 insert is about 7.3 g in the mass model).

If you are editing the mast OpenSCAD, set `part = "mast"` or `part = "insert"` (and `ins = "na771"`, `"rh789_bnc"`, `"srh789_sma"`, or `"custom"`). Do not export or print the stand from that file. That stand is the older, shorter column. Use the Field Roost.

## OpenSCAD (optional)

You only need this if you are changing the models. OpenSCAD 2021.01 was used to export these STLs.

- Field Roost: `part = "print"` (or `"folded"` for the reference pose). `device` and `bend_r` only change the ghosts and checks, not the printed stand.
- Laptop Perch / Phone Nest: open `rtlsdr_universal_variants.scad` and set `vpart` to the part (`la_print`, `la_hook`, `la_pad_lip`, `la_pad_bar`, `la_cap`, `knob`, `ph_body`, `ph_slider`, `ph_rotor`, `ph_jaw_pad`, `ph_back_pad`, …).
- If a hinge prints tight, raise `hc` from 0.35 to 0.40 in the stand source and re-export.
