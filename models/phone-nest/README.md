# Phone Nest

Clip for phones 60–90 mm wide in a case. Two #64 rubber bands close the sliding jaw, the radio rotor turns in 90° steps so the antenna stays vertical in portrait or landscape, and a 1/4-20 nut takes a tripod. One print fits both the RTL-SDR Blog V4 and the Airspy Mini.

**Print** `phone_rotor.stl` (upright, 210.5 mm tall, brim advised), `phone_body.stl`, `phone_slider.stl`, one `knob_m4_x1.stl`, two `phone_tpu_jaw_pad_x2.stl`, and optionally `phone_tpu_back_pad.stl`.

Hardware: one M4 × 20 hex bolt and M4 nut (pivot), one 1/4-20 hex nut, two #64 rubber bands. Full list in the [parts list](../../docs/bom.md).

OpenSCAD: `rtlsdr_universal_variants.scad` (shared with the Laptop Perch) and `phone_clamp_parts.scad`. Set `vpart` to `ph_rotor`, `ph_body`, `ph_slider`, `ph_jaw_pad`, `ph_back_pad` or `knob`.
