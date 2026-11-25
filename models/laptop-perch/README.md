# Laptop Perch

Hook that sits over a normal laptop lid (4–9 mm thick, at least about 182 mm tall). The radio stands behind the screen, and the antenna sits clear above the lid. One print fits both the RTL-SDR Blog V4 and the Airspy Mini.

**Print** `laptop_body_print.stl`, `laptop_hook.stl`, one `knob_m4_x1.stl`, two `laptop_tpu_pad_lip_x2.stl`, `laptop_tpu_pad_bar.stl` and `laptop_tpu_screw_cap.stl`. After the body prints, swing the captive rear foot out of the stowed position to free the hinge.

Hardware: one M4 × 30 hex bolt and nut (thumbscrew), two M4 × 16 button heads and two M4 nuts (hook). Full list in the [parts list](../../docs/bom.md).

OpenSCAD: `rtlsdr_universal_variants.scad`, which includes the Field Roost column and the Phone Nest clamp parts. Set `vpart` to `la_print`, `la_hook`, `la_pad_lip`, `la_pad_bar`, `la_cap` or `knob`.
