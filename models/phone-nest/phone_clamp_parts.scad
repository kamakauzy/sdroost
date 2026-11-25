// =====================================================================
// v4.2 PHONE-CLIP variant - clamp parts that do not depend on the radio
// (body with fixed jaw, sliding jaw, thumb knob, TPU pads).
// Included by rtlsdr_v4_2_variants.scad.
// Frame P: X along the clamp (phone width), Y along the phone length,
// Z normal to the phone back (phone back = Z 0, body Z 0..pb_t,
// the radio rotor sits on Z = pb_t).
// Creality K2 Pro, 0.4 mm nozzle, PETG (or PLA); pads TPU 95A.
// =====================================================================
/* ---- phone range (in case) ---- */
ph_min = 60; ph_max = 90;            // phone + case width
pad_p  = 1.0;                        // TPU pad protrusion beyond the jaw face
W_min  = ph_min - 2*pad_p;           // jaw-face distance at the closed stop (58)
W_max  = ph_max + 2*pad_p + 2;       // jaw-face distance at the open stop (94)
/* ---- body ---- */
pb_w = 36;  pb_t = 14;               // body width (Y), thickness (Z) = rotor seat
fj_t = 14;                           // fixed jaw thickness (X)
jaw_d = 15; jaw_v = 6; jaw_in = 3.5; // jaw depth below the phone back, straight face, ramp lip
x_end = W_min;                       // body end = closed stop for the sliding jaw
/* ---- slide ---- */
tg_w = 20; tg_z0 = 2.3; tg_z1 = 6.3; tg_L = 62;    // tongue (from the sliding-jaw face)
sc = 0.35;                                         // slide clearance per side (Y)
tn_w = tg_w + 2*sc; tn_z0 = tg_z0 - 0.3; tn_z1 = tg_z1 + 0.3;
fg_w = 2.5; fg_s = 1.2; fg_L = 24;  // latch fingers
bump = 1.0; bump_x = 4;             // latch bump height, centre from the tongue tip
wide = bump + 0.4;                  // tunnel relief per side where the bumps run
x_led = W_max - tg_L + bump_x + 1.0 + 0.2;   // ledge = open stop (bump catch face)
sj_t = 10;                          // sliding jaw thickness (X)
/* ---- rubber band ---- */
bg_z0 = 1; bg_z1 = 5; bg_d = 1.5;
/* ---- pivot ---- */
x_p = 36;                            // pivot X (centre of a ~72 mm phone)
key = 16; key_h = 2.5; key_c = 0.3; // square index key, socket clearance
m4_hole = 4.5; m4_af = 7.0;
hs_z0 = 8.2; hs_z1 = 11.4;          // M4 hex-head slot (Z)
/* ---- tripod 1/4-20 ---- */
tp_z = -7; tp_hole = 6.8; tp_af = 11.45; tp_k = 5.9; tp_x0 = -fj_t + 3.5;

module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();  // 2D (x, z) -> X, Z over Y y0..y1
module td_y(d, l) rotate([90, 0, 0]) linear_extrude(l, center = true) circle(d = d);           // hole along Y
module td_x(d, l) rotate([0, 90, 0]) linear_extrude(l) rotate(90) hull() { circle(d = d); translate([d/2*sqrt(2) - 0.01, 0]) square(0.02, center = true); }  // hole along +X, teardrop tip +Y
module td_z(d, z0, z1) translate([0, 0, z0]) linear_extrude(z1 - z0) hull() { circle(d = d); translate([0, d/2*sqrt(2) - 0.01]) square(0.02, center = true); }  // hole along Z, tip +Y

// jaw inner profile in (x, z); inner face at x = 0, jaw body toward -x
module jaw2d(t, ztop) polygon([[-t, -jaw_d], [jaw_in - 1, -jaw_d], [jaw_in, -jaw_d + 1], [0, -jaw_v], [0, ztop], [-t, ztop]]);
module pad2d(th) polygon([[0, -0.8], [0, -jaw_v], [jaw_in - 0.4, -jaw_d + 1.6], [jaw_in - 0.4 - th*0.92, -jaw_d + 1.6 + th*0.4], [-th, -jaw_v + th*0.42], [-th, -0.8]]);
module jaw_pad_recess() xz(-(pb_w/2 - 3), pb_w/2 - 3) offset(delta = 0.01) pad2d(1.0);

module P_body() difference() {
  union() {
    xz(-pb_w/2, pb_w/2) jaw2d(fj_t, pb_t);
    translate([-fj_t + 1, -pb_w/2, 0]) cube([x_end + fj_t - 1, pb_w, pb_t]);
    // square index key
    translate([x_p, 0, pb_t - 0.01]) hull() { linear_extrude(key_h - 0.6) square(key, center = true); linear_extrude(key_h + 0.01) square(key - 1.2, center = true); }
  }
  jaw_pad_recess();
  // slide tunnel (open both ends) + bump relief on the -x part (ends at the ledge)
  translate([-fj_t - 1, -tn_w/2, tn_z0]) cube([x_end + fj_t + 2, tn_w, tn_z1 - tn_z0]);
  translate([-fj_t - 1, -tn_w/2 - wide, tn_z0]) cube([x_led + fj_t + 1, tn_w + 2*wide, tn_z1 - tn_z0]);
  // band groove: fixed-jaw outer face + both Y faces
  translate([-fj_t - 1, -pb_w/2 - 1, bg_z0]) cube([bg_d + 1, pb_w + 2, bg_z1 - bg_z0]);
  for (s = [-1, 1]) translate([-fj_t - 1, s > 0 ? pb_w/2 - 1 : -pb_w/2 - 1, bg_z0]) cube([x_end + fj_t + 2, 2, bg_z1 - bg_z0]);
  // pivot: M4 hex-head slot (open to +Y), bolt hole up through the key
  translate([x_p - (m4_af + 0.4)/2, -(m4_af + 0.4)/2*1.16, hs_z0]) cube([m4_af + 0.4, pb_w, hs_z1 - hs_z0]);
  translate([x_p, 0, 0]) td_z(m4_hole, hs_z1 - 0.01, pb_t + key_h + 1);
  // tripod 1/4-20: hole from the outer face, nut pocket (flats +-Y), drop-in slot from the jaw bottom
  translate([-fj_t - 1, 0, tp_z]) td_x(tp_hole, fj_t - 1);
  translate([tp_x0, 0, tp_z]) rotate([0, 90, 0]) rotate(0) linear_extrude(tp_k) circle(d = tp_af/cos(30), $fn = 6);
  translate([tp_x0, -tp_af/2, -jaw_d - 1]) cube([tp_k, tp_af, tp_z + jaw_d + 1]);
}

// ---------------- sliding jaw (local: jaw face at x = 0, jaw toward +x) ----------------
module P_slider() difference() {
  union() {
    xz(-pb_w/2, pb_w/2) mirror([1, 0]) jaw2d(sj_t, tg_z1);
    // tongue
    translate([-tg_L, -tg_w/2, tg_z0]) cube([tg_L + 5, tg_w, tg_z1 - tg_z0]);
    // latch bumps (45-deg lead-in toward the tip, square catch toward the jaw)
    for (s = [-1, 1]) mirror([0, s < 0 ? 1 : 0, 0]) translate([0, tg_w/2 - 0.01, tg_z0]) linear_extrude(tg_z1 - tg_z0)
      polygon([[-tg_L + bump_x - 1 - bump - 0.5, 0], [-tg_L + bump_x - 1 - 0.5, bump], [-tg_L + bump_x + 1, bump], [-tg_L + bump_x + 1, 0]]);
  }
  jaw_pad_recess_s();
  // finger slits (fingers free at the tip)
  for (s = [-1, 1]) translate([-tg_L - 1, s > 0 ? tg_w/2 - fg_w - fg_s : -tg_w/2 + fg_w, tg_z0 - 1]) cube([fg_L + 1, fg_s, tg_z1 - tg_z0 + 2]);
  // band groove: outer face + Y faces
  translate([sj_t - bg_d, -pb_w/2 - 1, bg_z0]) cube([bg_d + 1, pb_w + 2, bg_z1 - bg_z0]);
  for (s = [-1, 1]) translate([-0.01, s > 0 ? pb_w/2 - 1 : -pb_w/2 - 1, bg_z0]) cube([sj_t + 1, 2, bg_z1 - bg_z0]);
}
module jaw_pad_recess_s() mirror([1, 0, 0]) jaw_pad_recess();

// ---------------- thumb knob: M4 nut (phone pivot) or M4 hex head (laptop foot) ----------------
kn_d = 22; kn_h = 14;
module knob() difference() {
  union() {
    cylinder(d = kn_d - 2, h = kn_h, $fn = 64);
    for (k = [0 : 11]) rotate(k*30) translate([kn_d/2 - 1.6, 0, 0]) cylinder(d = 3.2, h = kn_h - 1, $fn = 20);
    translate([0, 0, kn_h - 1.01]) cylinder(d1 = kn_d, d2 = kn_d - 2, h = 1.01, $fn = 64);
  }
  translate([0, 0, -0.01]) cylinder(d = (m4_af + 0.25)/cos(30), h = 3.4, $fn = 6);   // nut / head pocket
  translate([0, 0, -0.01]) cylinder(d1 = (m4_af + 0.25)/cos(30) + 1, d2 = (m4_af + 0.25)/cos(30), h = 0.5, $fn = 6);
  cylinder(d = m4_hole, h = kn_h - 2.4);                                                // blind bore (bolt tip hidden)
}
// ---------------- TPU pads ----------------
module P_jaw_pad() xz(-(pb_w/2 - 3.2), pb_w/2 - 3.2) translate([pad_p, 0]) pad2d(1.0 + pad_p);   // 2.0 thick: 1.0 in the recess, 1.0 proud
module P_back_pad() linear_extrude(1.5) offset(r = 2) square([W_min - 10 - 4, pb_w - 10 - 4], center = true);   // stick-on (VHB) on the phone face
