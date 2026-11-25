# v4.3 universal radio interface (reuse this for derived stands)

## Coordinates and constants
- Units are mm. z = 0 is the bed or ground. The origin is the column axis.
- +x is the cable-exit side.
- Source: `rtlsdr_v4_3_universal_stand.scad`.
- Constants: `dz = 24` (column lift over v4.1/v4.2), `zj = 159` (SMA jack face, both radios).

## 1. Antenna interface: do not change
- Everything at z ≥ `z_top` = 150 (guard, rim chamfer, M4 lugs and holes) is the v4.1 geometry translated by +24 mm.
- The printed v4.1 `antenna_mast.stl` sits at `z_mb` = 146. Measured on the v4.3 hub: 0 overlap and a 0.30 mm gap.
- Keep-out for the mast skirt: nothing at z ≥ 145 outside |x| ≤ 18.1 / |y| ≤ 16.3, apart from the lugs.
- The one change from v4.1 is a pass-through opening in the guard y-walls for the turned Airspy: |x| ≤ 6.8, z 149.5 to the top.
- The RG316 jumper is unchanged, because the distance from the SMA face to the mast deck is the same as v4.1.

## 2. Radio pocket: cross-shaped, both radios native, no sleeve
| | slot | half size x × y | seat (bottom of case) | seat ledges | case top |
|---|---|---|---|---|---|
| RTL-SDR V4 (27 × 13 × 69, SMA 9) | A (along x) | 13.8 × 6.8 | `z_rs` = 81 | x-ends, \|x\| 10.2..13.8 | 150 |
| Airspy Mini (27 × 11 × 52, SMA 13*, turned 90°) | B (along y) | 6.4 × 13.8 | `z_as` = 94 | arm ends, \|y\| 10.6..13.8 | 146 |

\* The 13 mm Airspy SMA projection is an assumption. Change it in `z_as` / `z_at`.

- **Airspy clamping:** in x by 0.7 mm crush ribs on the slot-B x-faces, |y| 10.8..13.8, z_as+3..z_at−3. The gap at the ribs is 11.4.
- **Seat separation:** the RTL never touches the Airspy seat, and the Airspy never reaches the RTL seat.
- **Insertion:** both radios go in from the top with the cable already plugged on. The straight-up sweep has 0 overlap.
- **Plug passages, from the seats down to the bay:**
  - D (RTL USB-C): |x| ≤ 10.2, |y| ≤ 6.8, down to z 44.
  - C (Airspy USB-A female end): |x| ≤ 6.4, |y| ≤ 10.6, down to z 44.
  - Both have 45° transitions at z 44..51.
- **Column outer, above z 54:**
  - Slot A tube: |x| ≤ 16.8, |y| ≤ 9.8 (= v4.1 tube).
  - Slot B arms: |x| ≤ 8.6, |y| ≤ 16.0.

## 3. Plug bay and cable envelope
- **Bay:** z 13 (hub top = cable sill) to 44. Octagon inner |x| ≤ 12.5, |y| ≤ 13, |x|+|y| ≤ 18.4. Walls 3 mm.
- **Opening:** the +x side is open, |y| ≤ 6.5 up to z 48, with a peaked top up to z 54.5.
- **Plug ghosts:**

| radio | plug body (x × y × length) | bottom at z |
|---|---|---|
| RTL | 18.33 × 10 × 25 | 56 |
| Airspy | male USB-A 4.5 × 12 × 12 on the radio, then a female extension end 12 × 20 × 40 | 42 |

- **Cable envelope:**
  - The cable is a 4.5 mm cable plus 1 mm all round (Ø 6.5).
  - It starts at the plug bottom and bends through 90° toward +x at radius r in the y = 0 plane.
  - It then runs straight to x = r + 60.
- **Verified clear of the stand (deployed and folded):**
  - RTL: r 15–35.
  - Airspy: r 15–25. At r 25 the cable sits 0.8 mm over the hub top.
- **Keep the 0° gap (+x, between legs 45° and 315°) free:** legs 135° and 315° are mirrored, so no latch tab stands above the hub top there. The tabs sit in the 90° and 270° gaps.

## 4. Latch and hinge keep-outs
- Below z 40, any column or bay material must stay inside |x|+|y| ≤ 22.6. The latch pockets (x′ 16.35..21.2 in each leg frame) are cut up to z 40, which gives finger room over the tabs.
- Folded legs need the column inside |x|+|y| ≤ 29 (leg-frame x′ ≤ 20.5).
- **Hinge and latch parameters:**
  - Hinge axis r 32, z 11. Hinge clearance hc 0.35.
  - Latch clearances: lc 0.30 horizontal, lz 0.40 vertical.
  - Legs: Lleg 84, tips at r 116. Tent-stake hole Ø 5.5.
