# Assembly

Do the post-print flex first: work every hinge, latch and sliding jaw by hand until it moves freely. Then gather the hardware from the [parts list](bom.md).

The mast assembly is the same on the Field Roost, the Laptop Perch and the Phone Nest. Build the mount first, then add the mast.

## Field Roost

### Leg latches

Each leg has a springy tab with a flat tooth. The tooth snaps into a notch at **deployed** (legs out, 0°) and at **folded** (legs up, 90°). The tooth is flat, so pressing on a leg cannot lever it out of the lock.

**To release a leg:** press the tab **toward the column**, then swing the leg. It snaps in again at the other end.

The latch is free within about ±2° of 0° and of 90°. Anywhere in between it needs 0.9–1.0 mm of flex, which is the tooth blocking the leg. Two of the legs are mirrored so that no latch tab sits in the cable-exit gap (the opening between the +x legs).

Tent-stake holes in the pads take pegs ≤ 5 mm (Ø 5.5 mm holes). Stake all four pads if you use a long telescopic whip outdoors.

### Radio

1. Plug the USB cable onto the radio first.
2. Lower the radio into the cross pocket from the top:
   - **RTL-SDR Blog V4:** aligned with the slot that points toward the cable exit, resting on the ledges at its ends.
   - **Airspy Mini:** turned 90°, resting on its own ledges. You should feel a little squeeze from the crush ribs.
3. The cable runs down through the open bay and out the front, between two legs. Both the deployed and folded poses leave room for this.

### Mast (after the stand is on its feet)

The load path is: antenna base → grip insert → collar → mast → conical seat on the guard rim + two M4 bolts through the lugs → column → hub. The radio's SMA only carries a short coax jumper.

1. Fit the SMA female–female bulkhead into the mast deck from the top. The 8.3 mm AF hex pocket stops the flange turning. Put the nut on from below with an 8 mm nut driver through the open skirt.
2. Screw the jumper's lower right-angle plug onto the radio, with the mast still off.
3. Lower the mast onto the guard cup, feeding the upper plug up inside the cage, and let the loop out of the +x window. The 45° conical seat is self-centring.
4. Fit the two M4 × 30 bolts (and nyloc nuts) through the mast ears and the column lugs. The lug holes also work as lanyard points.
5. Reach through the cage windows to tighten the upper plug onto the bulkhead. Route the jumper as a hairpin out of the +x window. The design bend radius is 13 mm (about 5× the cable OD).
6. Screw the antenna onto the bulkhead, or add the adapter first (BNC or SMA barrel — see the [parts list](bom.md)).
7. Slide the matching TPU insert in, flange on top, and zip-tie (or velcro) the collar shut.

To pack the Field Roost, undo the two mast bolts, fold the legs (press each tab toward the column, then swing), and bag the mast and insert beside the stand.

## Laptop Perch

The column stands vertically **behind** the open lid, with the antenna clear above it. The USB cable runs down the back of the lid.

1. Stick or press the TPU pads into place: one on the front lip (from `laptop_tpu_pad_lip_x2.stl`), one on the underside of the hook bar, and one on the rear pad seat of the spine (the other lip pad). The pad-to-pad slot is 9.5 mm, which takes lids 4–9 mm thick.
2. Bolt the hook to the spine wings with the two M4 × 16 button-head screws and the two M4 nuts. The nut slots open to the sides. The hook is notched around the collar and the slot-B arms; its top sits 3 mm under the mast skirt.
3. Build the thumbscrew: M4 × 30 hex bolt through the printed knob, with the TPU cap on the tip. The M4 nut is captive in the rear foot.
4. Click the rear foot down (it has a flex-tongue detent at deployed, 0°, and stowed, 90°). Past about 96° it hits a hard stop, so do not force it further.
5. Hook the front lip over the top edge of the open lid and tighten the thumbscrew so the TPU tip braces against the back of the lid. You should not need a lot of preload: with an NA-771 and an RTL-SDR V4 the lip/foot couple is 0.44 N over 161 mm, which is stable without screw preload.
6. Install the radio and the mast the same way as on the Field Roost.
7. Optionally zip-tie the USB cable to the two slots in the rear hinge block.

The lid needs to be at least about 182 mm tall. Tip checks for a 1.4 kg laptop with a 210 mm lid gave a 4.0× margin at 100° open, 2.4× at 110°, and 1.7× at 120°, with 0.17–0.37 N·m of extra torque on the laptop's own lid hinge.

## Phone Nest

1. Press the TPU jaw pads into the recesses on the fixed jaw and the sliding jaw. The back pad is optional; stick it on with VHB if you want it.
2. Drop the 1/4-20 hex nut into the trap in the fixed jaw.
3. Slide the sliding jaw into the body's closed tunnel until the snap-in latch fingers catch. The stops are at 58 mm and 94 mm, which covers phones 60–90 mm wide in a case.
4. Stretch the two #64 rubber bands around the perimeter groove so they pull the sliding jaw closed.
5. Seat the rotor on the clamp: the radio column lies flat on the back of the clamp, on its seat plate. A 16 mm square key indexes it in 90° steps. Drop the M4 × 20 hex bolt through the body slot, and tighten the printed knob (with its M4 nut) to hold it.
6. Install the radio and the mast the same way as on the Field Roost. A short USB-C or OTG cable leaves the bay on the +x side; use the tie slots in the rotor tail if you like.
7. Clamp the nest onto the phone. To turn the radio when you go from portrait to landscape, loosen the knob slightly, **lift and turn** the rotor 90° so the antenna stays vertical, then retighten.
8. Optional: thread the 1/4-20 nut onto a tripod.

The complete rig without the phone is about 295 g with an RTL-SDR V4 (131 g of that is printed).
