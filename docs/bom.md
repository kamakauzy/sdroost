# Parts list

Print settings and gram estimates assume 0.2 mm layers, 4 walls and 30 % gyroid, at about 0.65 effective fill, using 1.27 g/cm³ for PETG, 1.24 g/cm³ for PLA and 1.21 g/cm³ for TPU. Your slicer will vary a little.

## Field Roost

**Print**

| Item | Notes |
|---|---|
| `rtlsdr_v4_3_universal_stand_print.stl` | One print, about **167 g PETG** or **163 g PLA** |

**Hardware**

| Item | Qty | Notes |
|---|---|---|
| Tent pegs, ≤ 5 mm | 4 | Optional, through the Ø 5.5 mm pad holes. Recommended outdoors with a long whip. |

The mast hardware below is what actually holds the antenna. The stand itself has no other fasteners.

## Laptop Perch

**Print** (PETG / PLA grams)

| Item | Qty | PETG | PLA |
|---|---|---|---|
| `laptop_body_print.stl` | 1 | 95.7 g | 93.5 g |
| `laptop_hook.stl` | 1 | 7.8 g | 7.6 g |
| `knob_m4_x1.stl` | 1 | 3.7 g | 3.6 g |
| `laptop_tpu_pad_lip_x2.stl` | 2 | 1.2 g each | — (TPU 95A) |
| `laptop_tpu_pad_bar.stl` | 1 | 1.1 g | — (TPU 95A) |
| `laptop_tpu_screw_cap.stl` | 1 | 0.4 g | — (TPU 95A) |

**Hardware**

| Item | Qty | Notes |
|---|---|---|
| M4 × 30 hex bolt | 1 | Thumbscrew, with the printed knob and the TPU cap |
| M4 nut | 1 | Captive in the rear foot, for the thumbscrew |
| M4 × 16 button-head screw | 2 | Hook to spine |
| M4 nut | 2 | Hook nut slots, open to the sides |

Fits lids **4–9 mm** thick. The display lid must be at least about **182 mm** tall, because the foot screw meets the lid 167 mm below its top edge. That is fine for most 13–16" laptops.

## Phone Nest

**Print** (PETG / PLA grams)

| Item | Qty | PETG | PLA |
|---|---|---|---|
| `phone_rotor.stl` | 1 | 87.8 g | 85.8 g |
| `phone_body.stl` | 1 | 28.8 g | 28.1 g |
| `phone_slider.stl` | 1 | 10.3 g | 10.0 g |
| `knob_m4_x1.stl` | 1 | 3.7 g | 3.6 g |
| `phone_tpu_jaw_pad_x2.stl` | 2 | 0.8 g each | — (TPU 95A) |
| `phone_tpu_back_pad.stl` | 1 | 2.3 g | — (TPU 95A, optional stick-on) |

Printed parts come to about **131 g**. The complete rig without the phone is about **295 g** with an RTL-SDR V4, or about **290 g** with an Airspy Mini and a USB-A female extension end.

**Hardware**

| Item | Qty | Notes |
|---|---|---|
| M4 × 20 hex bolt | 1 | Rotor pivot, captive in the body slot |
| M4 nut | 1 | In the printed thumb knob |
| 1/4-20 hex nut | 1 | Trap in the fixed jaw, for a tripod |
| #64 rubber bands | 2 | Close the sliding jaw. A printed spring would creep and lose force. |
| VHB or similar adhesive | as needed | Optional, for the TPU back pad |

Fits phones **60–90 mm** wide in a case.

## Mast and inserts (every model)

**Print**

| Item | Qty | Notes |
|---|---|---|
| `antenna_mast.stl` | 1 | About **39 g** PETG (36.18 cm³, about 39.1 g in the mass model) |
| One insert: `antenna_insert_na771.stl`, `antenna_insert_rh789_bnc.stl`, or `antenna_insert_srh789_sma.stl` | 1 | About **7–10 g** TPU 95A (NA-771 insert about 7.3 g) |

**Hardware**

| Item | Qty | Spec |
|---|---|---|
| SMA female–female bulkhead (panel) adapter | 1 | 1/4″-36 thread, hex flange 8 mm AF (5/16″), nut and lock washer. About 12 mm below the panel. Panel range must include 2 mm. Goes into the hex pocket from the top; nut from below with an 8 mm nut driver through the open skirt. |
| Coax jumper | 1 | **RG316** (or RG174), SMA-male right-angle to SMA-male right-angle, **10 cm** (8–15 cm works; longer just makes a bigger loop). Alternative: an SMA-female bulkhead pigtail with an SMA-male right-angle plug, RG316, 10 cm. |
| M4 × 30 bolt + M4 nyloc nut | 2 | Mast ears to the column lugs. Ø4 clevis pins plus R-clips work if you want it tool-free. |
| Zip ties (≤ 4 mm wide) or a velcro strap | 2 | Clamp the mast collar around the insert. |
| SMA-male → BNC-female straight adapter | 1, if needed | About 20–25 mm. For the RH789 (BNC) or an NA-771-BNC. Screw it onto the bulkhead. |
| SMA-male ↔ SMA-male barrel | 1, if needed | For the NA-771 SMA-female (Baofeng "SMAJ") version. The SMA-male NA-771-SMAP and the SRH789 screw straight onto the bulkhead. |

Masses used in the stability model for the hardware: SMA bulkhead + nut 6 g, RG316 jumper 6 g, two M4 × 30 + nyloc 8 g.

## USB cables

Plug the cable onto the radio **before** you drop the radio into the pocket.

- **RTL-SDR Blog V4:** a USB-C plug. The design uses an 18.33 × 10 × 25 mm plug body (18.33 mm was measured; 10 mm thickness is an assumption). Verified cable-bend radii: **15–35 mm**.
- **Airspy Mini:** the radio has a male USB-A plug, so it needs a USB-A extension (or a 90° USB-A adapter). The bay is sized for a full-size female extension end **12 × 20 × 40 mm**. Verified bend radii: **15–25 mm**. At 25 mm the cable sits 0.8 mm over the hub top. A short female end, or a 90° adapter, is the more comfortable fit if your extension is bulky.
- Cable envelope used in the checks: a 4.5 mm cable plus 1 mm all round (Ø 6.5 mm).
- **Phone Nest:** a short USB-C or OTG cable is the practical choice. There are tie slots in the rotor tail.
- **Laptop Perch:** the cable leaves the bay and runs down the back of the lid. There are two zip-tie slots in the rear hinge block.

## Radios and antennas (not printed)

These are what the pockets and inserts were sized for. They are not included.

| Item | Notes |
|---|---|
| RTL-SDR Blog V4 | Case 27 × 13 × 69 mm, SMA projection 9 mm, about 30 g |
| Airspy Mini | Case 27 × 11 × 52 mm, SMA projection assumed 13 mm, about 21 g |
| Nagoya NA-771 | 384 ± 1 mm, 45 ± 2 g (datasheet). Base diameter 14.70 mm (calipers). |
| Diamond RH789 | 19.5–80.5 cm, 35 g, BNC-P only. BNC plug 14.53 mm (calipers). |
| Diamond SRH789 | SMA-male version, 20–80.5 cm, 29 g. Insert bore is still an estimate. |
