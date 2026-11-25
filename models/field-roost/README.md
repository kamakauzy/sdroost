# Field Roost

Universal folding stand for the RTL-SDR Blog V4 and the Airspy Mini. Print-in-place locking legs, tent-stake holes, and the shared mast mount.

**Print** `rtlsdr_v4_3_universal_stand_print.stl` — legs deployed, flat on the bed, no supports. Do not print `rtlsdr_v4_3_universal_stand_folded.stl`; that file is a reference pose only.

See the [print guide](../../docs/print-guide.md), [parts list](../../docs/bom.md) and [assembly](../../docs/assembly.md) (including how to release the leg latches). The [interface spec](INTERFACE.md) is the geometry contract for derived mounts.

OpenSCAD source: `rtlsdr_v4_3_universal_stand.scad`. Set `part = "print"`. `device` only changes the ghosts and checks; the printed stand is the same for both radios.
