// =====================================================================
// UNIVERSAL VARIANTS of the v4.3 rugged stand column (Airspy Mini AND RTL-SDR Blog V4)
//   A = LAPTOP-SCREEN MOUNT (hangs behind an open lid, webcam-mount style)
//   B = PHONE CLIP (spring-band clamp, 90-degree indexed radio rotor, 1/4-20)
// ONE STL per mount for both radios: the radio column is the v4.3 column() (cross pocket:
// slot A = RTL V4 on its x-ledges, slot B = Airspy Mini turned 90 deg on its arm ledges, both
// SMA faces at the same zj; tall 31 mm bay open on +x for a 20 mm-radius cable bend with the
// RTL USB-C plug or a full-size USB-A female extension end 20 x 12 x 40). No sleeve needed.
// Used UNCHANGED via include (+ the v4.3 Airspy crush ribs, which v4.3 adds in hub()), so the
// printed v4.1 antenna mast + TPU inserts bolt on exactly as on the v4.1/v4.2/v4.3 stands.
// The only change to the column: the solid hub-plate zone below the bay floor is trimmed to a
// 3 mm floor (column bottom z_cb = z_bf - 3 = 10) - nothing above z_bf is touched.
// Creality K2 Pro, 0.4 mm nozzle, PETG (or PLA), pads TPU 95A.
// =====================================================================
include <../field-roost/rtlsdr_v4_3_universal_stand.scad>
include <../phone-nest/phone_clamp_parts.scad>
part = "none";              // silence the v4.3 stand dispatcher
vpart = "la_print";         // see dispatcher at the bottom
device = "airspy_mini";     // GHOST radio only ("rtl_v4" | "airspy_mini"); every STL is the same for both
lphi = 0;                   // laptop foot angle for views (0 deployed .. 90 stowed)
sW = 80; rrot = 0;
lid_t = 7;                  // lid thickness for the "mounted" views
$fn = 56;

z_cb = z_bf - 3;            // column bottom (3 mm bay floor; the v4.3 hub plate is not used)
module v43_ribs() for (sx = [-1, 1], sy = [-1, 1])      // = v4.3 hub() crush ribs, verbatim
  box(sx > 0 ? pB[0] - rib_t : -pB[0] - 0.05, sx > 0 ? pB[0] + 0.05 : -pB[0] + rib_t,
      sy > 0 ? 10.8 : -pB[1] - 0.05, sy > 0 ? pB[1] + 0.05 : -10.8, z_as + 3, z_at - 3);
module col() { intersection() { column(); translate([-100, -100, z_cb]) cube([200, 200, 400]); } label3d(); v43_ribs(); }
// keep-out for everything added to the column on its -y face: never enter the arm (slot B) or the
// bay / passages. Additions may reach y = cy_b (2 mm into the 2.2 mm arm wall / bay wall) and, beside
// the arms (|x| >= oB[0]) above the bay transitions, y = -7.8 (2 mm into the slot-A tube / collar).
cy_b = -oB[1] + 2;          // -14.0
z_fill = z_bt + 10;         // tube / arms start (54)
module keepout() { c_slab(-oB[0], oB[0], cy_b, 60, -100, 500); c_slab(-60, 60, cy_b, 60, -100, z_fill); c_slab(-60, 60, -7.8, 60, -100, 500); }
// ===================== A: LAPTOP MOUNT (column frame, z up) =====================
// lid on the -y side of the column, screen facing -y
la_yb  = -7.8;                       // spine back beside the arms (2 mm into the tube / collar wall)
la_tc  = 3.2;                        // front cheek (flex tongue) thickness
la_fy1 = -oB[1] - 0.6;               // tongue inner face (-16.6): 0.6 slit to the bay wall
la_fy0 = la_fy1 - la_tc;             // tongue outer face (-19.8)
la_ys  = la_fy0;                     // spine front (below the thick top)
la_yt  = la_ys - 3;                  // spine front at the top block (rear pad seat, -22.8)
la_sw  = 20;                         // spine half width
la_ww  = 28.5;                       // wing half width (hook bolts)
la_zt  = z_mb - 3 - 5;               // spine top = bar underside (138)
la_bt  = 5;                          // bar thickness (bar top 3 mm under the mast skirt)
la_zw  = la_zt - 22;                 // wings / thick top start (116)
la_pr  = 1.0;                        // TPU pad protrusion (2 mm pad in a 1 mm recess)
la_gap = 9.5;                        // pad-to-pad lid slot (lids 4..9 mm, TPU takes the rest)
la_yrp = la_yt - la_pr;              // rear pad surface (-23.8)
la_ylp = la_yrp - la_gap;            // lip pad surface (-33.3)
la_yL  = la_ylp - la_pr;             // lip structural face (-34.3)
la_lt  = 4;                          // lip thickness
la_lip = 13.5;                       // lip depth below the bar underside
la_bx  = 23.5; la_by = -14.7;        // hook bolts (vertical)
la_nz  = la_zt - 6;                  // hook nut slot centre
la_root = z_cb + 14;                 // tongue root (spine full section starts here, 24)
// hinge (axis along y)
la_zh  = z_cb - 10;                  // axis height (0)
la_kr  = 9;                          // knuckle radius
la_ky0 = la_fy1 + hc; la_kw = 12;    // knuckle y span (-16.25 .. -4.25)
la_ry0 = la_ky0 + la_kw + hc;        // rear block inner face (-3.9)
la_zb  = la_zh - 8;                  // print bed (foot printed stowed)

la_cr  = 3.5; la_ch = 1.6;           // cone pins front (r, h)
la_cr2 = 4.0; la_ch2 = 3.0;          // cone pin rear
la_L   = 36; la_fw = 16;             // foot leg length (from axis), width
la_sz  = -30;                        // screw position on the foot (rel. axis)
la_dr  = 6;                          // detent radius
la_kh  = 1.0;                        // detent key (45-deg cone, r = h)
la_ddr = la_kh - hc + hc*sqrt(2);    // dimple cone radius at the face
la_ridge = 1.0;

module c_slab(x0, x1, y0, y1, z0, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
module ychamf(x0, x1, y0, y1, z0, z1, c) hull() {      // box with 45-deg chamfered vertical edges
  c_slab(x0 + c, x1 - c, y0, y1, z0, z1); c_slab(x0, x1, y0 + c, y1 - c, z0, z1); }

// detent dimples / channel on the knuckle front face (foot frame, deployed reference)
function la_kp(th) = [la_dr*cos(th), la_dr*sin(th)];       // (x, z) rel. axis
module la_dcone(th, extra = 0) { p = la_kp(th);
  translate([p[0], la_ky0 - 0.3, p[1]]) rotate([-90, 0, 0]) cylinder(r1 = la_ddr + 0.3 + extra, r2 = 0, h = la_ddr + 0.3 + extra, $fn = 24); }
module la_detent_cut() {
  la_dcone(90); la_dcone(180);
  g = (2*la_ddr + la_ridge) / la_dr * 180 / PI;
  for (t = [90 + g : 3 : 180 - g - 3]) hull() { la_dcone(t); la_dcone(min(t + 3, 180 - g)); }
}
// FOOT, deployed reference frame, origin on the hinge axis
module la_foot() difference() {
  union() {
    intersection() {
      translate([0, la_ky0, 0]) rotate([-90, 0, 0]) cylinder(r = la_kr, h = la_kw, $fn = 72);
      c_slab(-20, la_fw/2, la_ky0 - 1, la_ky0 + la_kw + 1, -20, 20);        // flat = bed face when stowed
    }
    hull() { c_slab(-la_fw/2, la_fw/2, la_ky0, la_ky0 + la_kw, -la_L + 1.5, 0);
             c_slab(-la_fw/2 + 1.5, la_fw/2, la_ky0, la_ky0 + la_kw, -la_L, -la_L + 1.5); }
    // cone pins
    translate([0, la_ky0 + 0.01, 0]) rotate([90, 0, 0]) cylinder(r1 = la_cr, r2 = la_cr - la_ch, h = la_ch + 0.01);
    translate([0, la_ky0 + la_kw - 0.01, 0]) rotate([-90, 0, 0]) cylinder(r1 = la_cr2, r2 = la_cr2 - la_ch2, h = la_ch2 + 0.01);
  }
  la_detent_cut();
  // thumbscrew: M4 through hole (teardrop, tip up when printed stowed = -x here) + nut pocket from the +y face
  translate([0, 0, la_sz]) rotate([90, 0, 0]) linear_extrude(40, center = true) rotate(90) teardrop(m4_hole);
  translate([0, la_ky0 + la_kw - 3.4, la_sz]) rotate([-90, 0, 0]) rotate(0) cylinder(d = (m4_af + 0.3)/cos(30), h = 5, $fn = 6);
}
module la_foot_at(f) translate([0, 0, la_zh]) rotate([0, f, 0]) la_foot();

// body: column + spine + wings + hinge cheeks
la_wb = -6.6;                        // wing back (lugs start at y = -6)
module la_spine() difference() {
  union() {
    c_slab(-la_sw, la_sw, la_ys, la_yb, la_root, la_zt);
    hull() { c_slab(-la_sw, la_sw, la_ys, la_yb, la_zw - (la_ys - la_yt), la_zw - (la_ys - la_yt) + 0.01);
             c_slab(-la_sw, la_sw, la_yt, la_yb, la_zw, la_zt); }
    hull() { c_slab(-la_sw, la_sw, la_yt, la_yb, la_zw - (la_ww - la_sw), la_zw - (la_ww - la_sw) + 0.01);
             c_slab(-la_ww, la_ww, la_yt, la_yb, la_zw, la_zt); }
    for (s = [-1, 1]) hull() { c_slab(s > 0 ? la_sw - 0.01 : -la_sw - 0.01, s > 0 ? la_sw : -la_sw, la_yt, la_wb, la_zw - (la_ww - la_sw), la_zw);
      c_slab(s > 0 ? la_sw - 0.01 : -la_ww, s > 0 ? la_ww : -la_sw + 0.01, la_yt, la_wb, la_zw, la_zt); }
  }
  difference() { keepout(); for (s = [-1, 1]) c_slab(s > 0 ? la_sw : -la_ww - 1, s > 0 ? la_ww + 1 : -la_sw, -20, la_wb, la_zw - 10, la_zt + 1); }
}
module la_tongue() {     // front cheek = flexible tongue hanging from the spine (root la_root .. +2)
  intersection() {
    c_slab(-11, 11, la_fy0, la_fy1, la_zb, la_root + 2);
    union() { translate([0, 0, la_zh]) rotate([90, 0, 0]) cylinder(r = 11, h = 50, center = true, $fn = 72);
              c_slab(-11, 11, -50, 50, la_zh, la_root + 4); }
  }
  translate([0, la_fy1 - 0.01, la_zh + la_dr]) rotate([-90, 0, 0]) cylinder(r1 = la_kh, r2 = 0, h = la_kh, $fn = 24);
}
module la_rear_block() ychamf(-14, 14, la_ry0, bo[1] - 1.5, la_zb, z_cb + 2, 1.5);
module la_body() difference() {
  union() { col(); la_spine(); la_tongue(); la_rear_block(); }
  translate([0, la_fy1 + 0.01, la_zh]) rotate([90, 0, 0]) cylinder(r1 = la_cr + hc*sqrt(2), r2 = la_cr - la_ch + hc*sqrt(2), h = la_ch);
  translate([0, la_ry0 - 0.01, la_zh]) rotate([-90, 0, 0]) { cylinder(r1 = la_cr2 + hc*sqrt(2), r2 = la_cr2 - la_ch2 + hc*sqrt(2), h = la_ch2); cylinder(r = 1.0, h = 20); }
  c_slab(-19, 19, la_yt - 0.01, la_yt + 1, la_zw + 8, la_zt - 2);                     // rear pad recess
  for (s = [-1, 1]) {                                                                  // hook bolts: M4 + nut slots open to the wing sides
    translate([s*la_bx, la_by, la_zt - 16]) cylinder(d = m4_hole, h = 20);
    translate([s > 0 ? la_bx - (m4_af + 0.4)/2*1.16 : -la_ww - 1, la_by - (m4_af + 0.4)/2, la_nz - 1.7]) cube([la_ww - la_bx + (m4_af + 0.4)/2*1.16 + 1, m4_af + 0.4, 3.4]);
  }
  for (z = [la_zb + 3, la_zb + 11]) c_slab(9, 13.4, la_ry0 - 1, bo[1], z, z + 2.2);  // cable zip-tie slots
}
module la_print() { la_body(); la_foot_at(90); }

// hook (bar + lip), separate part, prints bar-top down
module la_hook() difference() {
  union() {
    difference() {
      ychamf(-la_ww, la_ww, la_yL - la_lt, la_yb, la_zt, la_zt + la_bt, 1.5);
      c_slab(-(cowx/2 + 0.3), cowx/2 + 0.3, -(cowy/2 + 0.3), 50, la_zt - 1, la_zt + la_bt + 1);   // clear the collar
      c_slab(-(oB[0] + 0.3), oB[0] + 0.3, -(oB[1] + 0.3), 50, la_zt - 1, la_zt + la_bt + 1);     // clear the slot-B arms
    }
    hull() { c_slab(-la_ww, la_ww, la_yL - la_lt, la_yL, la_zt - la_lip + 1.5, la_zt + 1);
             c_slab(-la_ww, la_ww, la_yL - la_lt + 1.5, la_yL, la_zt - la_lip, la_zt - la_lip + 1.5); }
  }
  translate([0, la_yL, la_zt - la_lip]) rotate([0, 90, 0]) linear_extrude(2*la_ww + 2, center = true) polygon([[1, 0.01], [-0.01, 0.01], [1, -1.6]]);
  c_slab(-26, 26, la_yL - 1, la_yL + 0.01, la_zt - la_lip + 2.5, la_zt - 1.5);
  c_slab(-26, 26, la_yL + 1.0, la_yt - 1.0, la_zt - 0.01, la_zt + 1);
  for (s = [-1, 1]) translate([s*la_bx, la_by, 0]) { translate([0, 0, la_zt - 1]) cylinder(d = m4_hole, h = 10); translate([0, 0, la_zt + la_bt - 1]) cylinder(d = 8.4, h = 2); }
}
// TPU parts
module la_pad_lip() c_slab(0, 51.4, 0, 9.4, 0, 2);     // lip and rear pads (2 off), 51.4 x 9.4 (rear 51.4 x 9.4)
module la_pad_bar() c_slab(0, 51.4, 0, 8.9, 0, 2);
module la_cap() difference() { cylinder(d = 9, h = 5.5, $fn = 40); translate([0, 0, 2]) cylinder(d = 3.5, h = 4, $fn = 24); }   // TPU tip for the M4 thumbscrew

// mounted pose: lid (thickness lid_t) between lip and rear pad, back face at y = la_ylp + lid_t
module la_lid(t = lid_t) color([0.2, 0.22, 0.25, 0.55]) c_slab(-170, 170, la_ylp, la_ylp + t, -110, la_zt - la_pr);
module la_screw(f = 0) let(ext = (la_ky0) - (la_ylp + lid_t) - 2.5)
  translate([0, 0, la_zh]) rotate([0, f, 0]) { color([0.7,0.7,0.72]) translate([0, la_ky0 - ext, la_sz]) rotate([-90, 0, 0]) cylinder(d = 4, h = 30);
    color([0.9,0.45,0.1]) translate([0, la_ky0 - ext - 2.5, la_sz]) rotate([-90, 0, 0]) cylinder(d = 9, h = 5.5);
    color([0.2,0.2,0.2]) translate([0, la_ky0 + la_kw + 0.5, la_sz]) rotate([-90, 0, 0]) cylinder(d = kn_d, h = kn_h); }
module la_viz(f = 0, with_lid = true, hook_lift = 0) {
  color([0.25,0.27,0.3]) la_body(); color([0.85,0.55,0.15]) la_foot_at(f);
  color([0.35,0.5,0.65]) translate([0, -hook_lift*0.6, hook_lift]) la_hook(); ghost_radio();
  color([0.3,0.45,0.6]) mast(); color([0.9,0.45,0.1]) translate([0, 0, z_dt]) insert(); ghost_feed(); ghost_na771();
  if (with_lid) { la_lid(); la_screw(f); }
}

// ===================== B: PHONE CLIP =====================
// rotor = column lying on the clamp; built in the column frame, -y face toward the phone
ro_py  = cy_b - 4;                   // rotor seat plane (on the clamp body top), -18
ro_pt  = 7;                          // pad thickness at the pivot
ro_w   = pb_w/2;                     // pad half width
ro_zw  = z_cb - (bo[1] - (ro_py + ro_pt));   // 45-deg wedge start under the column bottom (-17)
ro_zp  = ro_zw - 12.5;               // pivot (knob r 11 + 1.5 clear of the wedge)
ro_z0  = ro_zp - 23;                 // pad tail end
module ro_body() difference() {
  union() {
    col();
    difference() { union() {
      c_slab(-ro_w, ro_w, ro_py, la_yb, z_cb, z_mb - 3);                  // seat plate under the column
      c_slab(-ro_w, ro_w, ro_py, ro_py + ro_pt, ro_z0, z_cb + 0.5);       // pivot pad
      c_slab(-ro_w, ro_w, ro_py + ro_pt - 0.01, 5, ro_z0, ro_z0 + 6);     // bed flare / thumb tab
    } difference() { keepout(); c_slab(-60, 60, -60, 60, -100, z_cb + 0.5); } }
    hull() { lay(z_cb) oct(bo[0], bo[1], dia);                            // 45-deg wedge under the column bottom
             c_slab(-bo[0], bo[0], ro_py, ro_py + ro_pt, ro_zw, ro_zw + 0.01); }
  }
  translate([0, ro_py - 0.01, ro_zp]) rotate([-90, 0, 0]) {               // square index socket + bolt hole
    linear_extrude(key_h + key_c) square(key + 2*key_c, center = true);
    linear_extrude(0.5) offset(delta = 0.5) square(key + 2*key_c, center = true);
  }
  translate([0, ro_py - 1, ro_zp]) rotate([-90, 0, 0]) linear_extrude(ro_pt + 2) teardrop(m4_hole + 0.1);
  for (z = [ro_z0 + 9, ro_z0 + 17]) c_slab(11, 15.4, ro_py - 1, ro_py + ro_pt + 1, z, z + 2.2);   // cable-tie slots (+x = bay exit side)
}
// pose the rotor in the phone frame P: column z -> +Y (portrait, antenna up), column -y -> -Z, pivot on (x_p, 0)
module ro_place(rot = 0) translate([x_p, 0, pb_t]) rotate([0, 0, rot]) rotate([0, 0, 180]) rotate([90, 0, 0]) translate([0, 0, -ro_zp]) translate([0, -ro_py, 0]) children();
ph_off = 50;                         // clamp sits on the lower part of the phone (portrait)
module ph_viz(W = 80, rot = 0, phone = true, lift = 0) {
  color([0.25,0.27,0.3]) P_body();
  color([0.35,0.37,0.42]) translate([W, 0, 0]) P_slider();
  translate([0, 0, lift]) ro_place(rot) { color([0.3,0.33,0.38]) ro_body(); ghost_radio(); color([0.3,0.45,0.6]) mast(); color([0.9,0.45,0.1]) translate([0, 0, z_dt]) insert(); ghost_feed(); ghost_na771(); }
  color([0.15,0.15,0.15]) translate([x_p, 0, pb_t + ro_pt + 1.6*lift]) knob();
  if (lift > 0) color([0.7,0.7,0.72]) translate([x_p, 0, hs_z0 + 0.2]) { cylinder(d = 8, h = 2.8, $fn = 6); cylinder(d = 4, h = 20); }
  if (phone) color([0.12,0.12,0.14,0.55]) translate([pad_p, -78 + ph_off, -11]) cube([W - 2*pad_p, 156, 11]);
}
echo(str("variants: laptop bar underside ", la_zt, " tongue ", la_fy0, "..", la_fy1, " knuckle y ", la_ky0, "..", la_ky0 + la_kw, " lip pad ", la_ylp, " rear pad ", la_yrp,
         " | rotor seat ", ro_py, " wedge ", ro_zw, " pivot ", ro_zp, " tail ", ro_z0));

// ===================== dispatcher =====================
if (vpart == "la_print") translate([0, 0, -la_zb]) la_print();
else if (vpart == "la_body") la_body();
else if (vpart == "la_foot") la_foot_at(lphi);
else if (vpart == "la_hook") translate([0, 0, la_zt + la_bt]) rotate([180, 0, 0]) la_hook();
else if (vpart == "la_pad_lip") la_pad_lip();
else if (vpart == "la_pad_bar") la_pad_bar();
else if (vpart == "la_cap") la_cap();
else if (vpart == "la_viz") la_viz(lphi);
else if (vpart == "la_viz_open") { la_viz(90, false, 45); }
else if (vpart == "ph_body") translate([0, 0, pb_w/2]) rotate([90, 0, 0]) P_body();          // prints on its -Y side face
else if (vpart == "ph_slider") rotate([180, 0, 0]) translate([0, 0, -tg_z1]) P_slider();   // top face down
else if (vpart == "ph_rotor") translate([0, 0, -ro_z0]) ro_body();   // upright, pad tail on the bed
else if (vpart == "knob") knob();
else if (vpart == "ph_jaw_pad") translate([0, 0, pb_w/2 - 3.2]) rotate([90, 0, 0]) P_jaw_pad();
else if (vpart == "ph_back_pad") P_back_pad();
else if (vpart == "ph_viz") ph_viz(80, 0);
else if (vpart == "ph_viz_land") ph_viz(80, 90);
else if (vpart == "ph_viz_open") ph_viz(W_max, 0, false, 30);
else if (vpart == "ph_up") rotate([90, 0, 0]) ph_viz(80, 0);
else if (vpart == "ph_up_land") rotate([90, 0, 0]) rotate([0, 0, -90]) translate([-x_p, -ph_off + 0, 0]) ph_viz(80, 90);
else if (vpart == "la_explode") { la_viz(90, false); }
else if (vpart == "ph_latch_section") intersection() { union() { color([0.25,0.27,0.3]) P_body(); color([0.85,0.55,0.15]) translate([sW, 0, 0]) P_slider(); } c_slab(-20, 120, -30, 30, -20, (tg_z0 + tg_z1)/2); }
else if (vpart == "la_hinge_section") intersection() { union() { color([0.25,0.27,0.3]) la_body(); color([0.85,0.55,0.15]) la_foot_at(lphi); } c_slab(-60, 60, -30, 30, -60, la_zh); }
else if (vpart == "la_section") intersection() { la_viz(lphi); c_slab(-1, 60, -200, 200, -200, 500); }
else if (vpart == "la_section_b") intersection() { la_viz(lphi); c_slab(-60, 1, -200, 200, -200, 500); }
else if (vpart == "la_hook_m") la_hook();
else if (vpart == "la_lid") la_lid();
else if (vpart == "ph_body_m") P_body();
else if (vpart == "ph_slider_m") translate([sW, 0, 0]) P_slider();
else if (vpart == "ph_rotor_m") ro_place(rrot) ro_body();
else if (vpart == "ph_mast_m") ro_place(rrot) mast();
else if (vpart == "ph_knob_m") translate([x_p, 0, pb_t + ro_pt]) knob();
else if (vpart == "ph_phone_m") translate([pad_p, -78, -11]) cube([sW - 2*pad_p, 156, 11]);
else if (vpart == "ro_body_raw") ro_body();
else if (vpart == "mast_m") mast();
else if (vpart == "insert_m") translate([0, 0, z_dt]) insert();
