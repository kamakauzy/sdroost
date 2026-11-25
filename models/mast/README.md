# Mast and inserts

Bolt-on antenna support used by the Field Roost, the Laptop Perch and the Phone Nest. The mast sits on the column's guard cup, and a TPU insert grips the antenna so the radio's SMA jack only carries a short jumper.

**Print** `antenna_mast.stl` upright, skirt on the bed, no supports, 5 mm brim recommended, plus **one** insert:

- `antenna_insert_na771.stl` — Nagoya NA-771 (measured base Ø 14.70 mm)
- `antenna_insert_rh789_bnc.stl` — Diamond RH789 BNC (measured plug Ø 14.53 mm)
- `antenna_insert_srh789_sma.stl` — Diamond SRH789 / slim SMA whip (estimated)

Hardware: SMA female–female bulkhead, 10 cm RG316 right-angle jumper, two M4 × 30 bolts with nyloc nuts, and two zip ties. See the [parts list](../../docs/bom.md) and [assembly](../../docs/assembly.md).

OpenSCAD: `rtlsdr_v4_1_rugged_antenna_mast.scad`. Set `part = "mast"` or `part = "insert"`, and `ins` to `na771`, `rh789_bnc`, `srh789_sma` or `custom`.

**Do not print the stand from this file.** That stand is the older, shorter column. Print the [Field Roost](../field-roost/) instead. The mast and inserts themselves are unchanged and fit the current column.
