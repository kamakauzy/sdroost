# Design notes

These figures come from the model checks that were run when the parts were exported. They are calculated, not all bench-measured. A few lengths are still assumptions; those are called out at the end.

## Why one pocket, no sleeve

The RTL-SDR Blog V4 is larger than the Airspy Mini in every direction, so a sleeve that held the Airspy at the right height would block the RTL. The pocket is a **cross** instead:

| Radio | Slot | Case (mm) | Seat (bottom of case) | How it sits |
|---|---|---|---|---|
| RTL-SDR Blog V4 | A, along the cable-exit axis (x) | 27 × 13 × 69, SMA 9 | z = 81 mm | Ledges at the ends of the case |
| Airspy Mini | B, turned 90° (along y) | 27 × 11 × 52, SMA 13 mm *assumed* | z = 94 mm | Ledges at the ends of the arms |

Both SMA faces sit at **z = 159 mm**, so the same mast works for both. The RTL never touches the Airspy seat, and the Airspy never reaches the RTL seat. Each radio has 0.2 mm side clearance and a clear top-down insertion path with the plug already attached.

The Airspy is clamped in its thin axis by 0.7 mm crush ribs (rib gap 11.4 mm).

The middle of two guard walls is opened (|x| ≤ 6.8 mm) so the turned Airspy can slide in. On those two sides the mast's rim therefore rests only on the corners. Measured on the Field Roost hub: the v4.1 mast has **0 overlap** and a **0.30 mm** gap, same as the original fit.

The formal keep-outs, plug passages and lug geometry are in [`models/field-roost/INTERFACE.md`](../models/field-roost/INTERFACE.md). Anything derived from this column should follow that file so the mast and the radios still fit.

## Cable-bend envelope

The column is 24 mm taller than the earlier v4.1 / v4.2 stands, which gives a **31 mm** tall bay, open at the front. The cable leaves between two legs.

Checks used a solid envelope: the plug body plus a 4.5 mm cable with 1 mm clearance all round (Ø 6.5 mm), bent 90° toward the exit and run straight out. Overlap was **0** in both the deployed and the folded poses for:

- RTL-SDR V4 (plug 18.33 × 10 × 25 mm): bend radius **15–35 mm**
- Airspy Mini with a full-length 40 mm USB-A female extension end (12 × 20 × 40 mm): bend radius **15–25 mm**. At 25 mm the cable sits 0.8 mm over the hub top.

The same envelopes also clear the Laptop Perch and Phone Nest bodies. On those mounts, an Airspy bend of 35 mm touches the 3 mm bay floor, so stay in the 15–25 mm range for the Airspy.

## Stability

**Field Roost** (legs out, tip edge 82.0 mm). Printed stand about 167 g PETG.

| Radio + antenna | Total mass | CoM height | Tips at | Side push at the antenna tip |
|---|---|---|---|---|
| RTL-SDR V4 + NA-771 (45 g) | 320 g | 111.5 mm | **36.3°** | 44 gf |
| RTL-SDR V4 + 108 cm / 50 g whip | 325 g | 151.2 mm | **28.5°** | 20 gf |
| Airspy Mini + NA-771 (45 g) | 311 g | 111.7 mm | **36.3°** | 43 gf |
| Airspy Mini + 108 cm / 50 g whip | 316 g | 152.5 mm | **28.3°** | 20 gf |

The legs are 18 mm longer than on the previous stand (tips at r 116 mm) so that tipping is better even with the taller column. The previous stand tipped at 33.2° with an RTL-SDR V4 and NA-771, and at 24.9° with the 108 cm whip.

Stake a long telescopic whip if you use it outdoors. The pad holes take ≤ 5 mm pegs. On hard ground, use them for a sandbag tie-down, or guy from the mast windows.

**Laptop Perch**, with NA-771 and RTL-SDR V4, total about **279 g** (274 g with the Airspy Mini and a USB-A female end):

- Centre of mass is 26 mm behind the lid mid-plane and about 12 mm above the lid top edge.
- Lip / foot couple: 0.44 N over 161 mm, stable without screw preload.
- Assumed 1.4 kg laptop with a 210 mm lid: tip margin **4.0× at 100°**, **2.4× at 110°**, **1.7× at 120°**. Extra torque on the lid hinge: 0.17–0.37 N·m.
- The foot screw meets the lid 167 mm below its top edge, so the display lid must be at least about **182 mm** tall.

**Phone Nest:** about 295 g without the phone (131 g printed) with an RTL-SDR V4; about 290 g with the Airspy Mini and a USB-A female end.

**Antenna facts used for the inserts and the mass model:**

| Antenna | Spec | Base |
|---|---|---|
| Nagoya NA-771 | 384 ± 1 mm, 45 ± 2 g (datasheet; resellers say 39–39.6 cm and 40–53 g). 45 g is the conservative figure used here. | 14.70 mm, calipers |
| Diamond RH789 | 19.5–80.5 cm, 6 sections, 35 g, BNC-P only, 180° tilt hinge | BNC plug 14.53 mm, calipers |
| Diamond SRH789 | SMA-male, 20–80.5 cm, 29 g, base tube Ø 8 mm | Insert is still an estimate (bore 11.4 mm, rib tips 9.8 mm) |

A "22–108 cm" whip does not match the RH789. The 108 cm / 50 g figures above are a worst-case clone used for tipping. If your bases measure differently, set `ins = "custom"` in the mast OpenSCAD and edit the `custom` row of `ins_tab`.

Insert fit (measured bases): bore = measured diameter + 0.30 mm, so a split TPU insert slides on without tearing. Six crush ribs 0.45 mm tall leave rib tips at measured − 0.60 mm, i.e. 0.30 mm radial interference per rib. Closing the 1.2 mm split with the collar zip ties adds about 0.35 mm more on diameter.

## Mast interface, and heights

Everything from the guard rim up is the earlier mast geometry, translated up by 24 mm with the taller column. The distance from the SMA face to the mast deck is unchanged, so the same 10 cm RG316 jumper still works.

On the earlier, shorter column the desk heights were: radio jack face 135 mm, deck 183 / 186.5 mm, collar top 218.5 mm, top with an NA-771 about 572 mm, top with an RH789 at full length about 1005 mm. Add 24 mm to each of those for the current column (the jack face at 159 mm matches that translation).

Mast details that did not change: cage 49 mm tall (guard top to deck) with peaked windows; deck 3.5 mm thick, Ø 6.6 mm hole and an 8.3 mm AF hex pocket (about 2 mm of panel for the thread); collar Ø 29 mm OD, Ø 22 mm bore, 32 mm tall, with a vertical slit and two zip-tie grooves.

## Leg latch (Field Roost)

Print-in-place spring pawl, square (flat) tooth, locked deployed and stowed. Hinge axis at r 32 mm, z 11 mm. Clearances: hinge 0.35 mm, latch 0.30 mm horizontal and 0.40 mm vertical. Sweep: the hinge gap stays 0.35 mm over 0–90°; the latch is free within ±2° of 0° and 90°, and needs 0.9–1.0 mm of flex everywhere else so the tooth blocks it.

## Assumptions and things to measure

Please check these with calipers if you can, and open an issue if yours differ.

- **Airspy Mini SMA projection: 13 mm.** This sets the Airspy seat height. If your SMA is shorter or longer, the jack will not line up with the RTL, and the mast jumper may be tight or loose. Change `z_as` / `z_at` in the Field Roost OpenSCAD.
- **RTL-SDR V4 USB-C plug thickness: 10 mm.** Width is 18.33 mm, measured. If your plug is thicker than 10 mm, say so — the passage may need to grow.
- **Airspy USB-A female extension end: 12 × 20 × 40 mm.** A shorter end still fits; a longer or fatter one may not take the 15–25 mm bend.
- **Laptop lids:** 4–9 mm thick, and at least about 182 mm tall. Tip margins assume a 1.4 kg laptop with a 210 mm lid.
- **Masses in the models:** NA-771 45 g with its centre of mass 35 % up its length; mast 39.1 g; TPU insert 7.3 g; RTL-SDR V4 30 g; Airspy Mini 21 g; USB-A female end about 12 g on the mounts (10 g in the earlier mast mass file); PETG 1.27, PLA 1.24, TPU 1.21 g/cm³; printed parts at 0.65 effective fill.
- **SRH789 insert** bore 11.4 mm and rib tips 9.8 mm are estimates.
- **Right-angle SMA plugs** are taken as about 5–6 mm from the jack face to the cable axis. Bulkhead about 12 mm below the panel, 8 mm AF hex flange.

The Field Roost, Laptop Perch and Phone Nest STLs in this release passed a connectivity gate (watertight, expected shell counts, no weak layer necks) and, for the print-in-place Field Roost and laptop foot, a capture gate (parts are trapped but not fused). See [Contributing](../tools/CONTRIBUTING.md).
