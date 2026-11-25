// =====================================================================
// v4.3 UNIVERSAL rugged field stand: ONE stand for the Airspy Mini AND the RTL-SDR Blog V4
// (Brad, 25 Nov 2026: "single stations ... be generous with the room for the cable bend")
//  1. CROSS-SHAPED RADIO POCKET. Both radios are 27 mm wide; the Airspy (11 thick) sits
//     turned 90 deg to the RTL (13 thick). Slot A (27.6 x 13.6, along x) takes the RTL;
//     slot B (12.8 x 27.6, along y) takes the Airspy. Each radio has its own seat that the
//     other radio never touches, so both seat NATIVELY with the SMA jack face on the same
//     axis and at the same height (zj). No sleeve/adapter needed:
//       RTL    seat = x-ledges |x| 10.2..13.8 at z_rs (USB-C plug passes |x|<=10.2)
//       Airspy seat = arm ledges |y| 10.6..13.8 at z_as (USB-A female end passes |y|<=10.6)
//     Airspy is clamped in x by 0.7 mm crush ribs (gap 11.4) in the arms, outside the plug path.
//  2. CABLE BEND FIRST: the whole radio column is lifted dz = 24 mm over v4.2 and the radio
//     sits over a tall (31 mm) bay that is open on the +x side. Plug + a 20 mm-radius bend
//     (25 mm for the Airspy, 30+ for the RTL) stay inside the stand and leave over the hub
//     top between two legs. Legs lengthened so tipping is at least as good as v4.2.
//  3. Leg latch (v4.2 concept, unchanged): print-in-place spring pawl, square tooth, locked
//     deployed AND stowed; press the tab toward the column to release. Tent-stake holes kept.
//  4. Antenna interface: everything from z_top (case end) up is the v4.1 guard/lug/rim
//     geometry translated up by dz, so the printed v4.1 MAST, TPU INSERTS and M4 lugs fit
//     unchanged (the mast only ever touches the guard, z >= z_mb - 1).
// Creality K2 Pro, 0.4 mm nozzle, prints DEPLOYED in place, no supports.
// =====================================================================
part = "print";   // print | hub | leg | folded | viz | viz_folded | latch | latch_section | beam | hub_nopawl | radio | env | bend_section
device = "airspy_mini";   // GHOSTS / checks only ("rtl_v4" | "airspy_mini"); the stand is the same for both
env_c = 1.0;      // envelope clearance round the 4.5 mm cable
bend_r = 20;      // cable bend radius used by the ghosts / envelope checks
phi = 0;          // leg fold angle for part="leg" / latch views (0 deployed .. 90 stowed)
fit = 0.3;        // radio pocket fit
hc  = 0.35;       // hinge clearance (normal), K2 Pro 0.30..0.40
lc  = 0.30;       // latch clearance, horizontal (x/y)
lz  = 0.40;       // latch clearance, vertical (2 layers at 0.2 mm)
$fn = 56;

/* ---- radios: [name, case width, case thickness, case length, SMA projection, label] ---- */
dev_tab = [["rtl_v4", 27, 13, 69, 9, "RTL-SDR V4"],          // rtl-sdr.com: 69 x 27 x 13
           ["airspy_mini", 27, 11, 52, 13, "AIRSPY MINI"]];   // 52 x 27 x 11 body, 1/2" long SMA
dv = dev_tab[search([device], dev_tab)[0]];
dev_w = dv[1]; dev_t = dv[2]; dev_l = dv[3]; sma_proj = dv[4]; dev_label = dv[5];
/* ---- FIXED v4.1 geometry (mast interface) - do not change ---- */
sdr_w = 27; sdr_h = 13; sdr_l = 69;
tw = 3; cw4 = 4; guard_h = 8;
lug_out = 9; lug_h = 12; lug_hole = 4.6;
mc = 0.3; mcy = 1.5; ml = 3; gch = 2.5; cage = 49; deck_t = 3.5; bh_hole = 6.6; bh_hex = 8.0; bh_pocket = 1.5;
col_od = 29; col_bore = 22; col_hgt = 32; col_slit = 1.5;
ins = "na771";
ins_tab = [["na771", 14.70 + 0.30, 0.45], ["rh789_bnc", 14.53 + 0.30, 0.45], ["srh789_sma", 11.4, 0.8], ["custom", 13.0, 0.8]];
function ins_get(n) = ins_tab[search([n], ins_tab)[0]];
iw = sdr_w + 2*fit; ih = sdr_h + 2*fit;            // 27.6 x 13.6 (v4.1 pocket = guard interior)
ow = iw + 2*tw; oh = ih + 2*tw;                     // 33.6 x 19.6
cowx = iw + 2*cw4; cowy = ih + 2*cw4;               // 35.6 x 21.6
z_top = 126 + 24;                   // RTL case end = v4.1 (126) + dz
zj = z_top + 9;                     // SMA jack face = v4.1 (135) + dz; same distance below the mast (RG316 jumper unchanged)
z_col = z_top - 18; z_g = z_top + guard_h; z_db = z_g + cage; z_dt = z_db + deck_t; z_mb = z_g - lug_h;
zbj = z_db - 12;                    // bulkhead lower jack face (viz)
/* ---- radio pocket (device dependent) ---- */
dz = 24;                            // v4.3 column lift (everything above the hub top goes up by dz)
/* ---- cross pocket ---- */
pA = [iw/2, ih/2];                  // slot A (RTL) half sizes 13.8 x 6.8 (= v4.1 pocket)
pB = [6.4, 13.8];                   // slot B (Airspy turned 90 deg) half sizes: 12.8 x 27.6
rib_t = 0.7;                        // Airspy crush ribs on the slot-B x faces -> 11.4 gap
cC = [6.4, 10.6];                   // Airspy USB-A female end passage (12 x 20 + clearance)
cD = [10.2, 6.8];                   // RTL USB-C plug passage (18.33 x 10 + clearance)
wB = 2.2;                           // arm wall (outer |y| 16.0 < mast skirt 16.3)
oA = [ow/2, oh/2]; oB = [pB[0] + wB, pB[1] + wB];
z_rs = z_top - 69;                  // RTL seat (case bottom)        = 81
z_as = zj - 13 - 52;                // Airspy seat (body bottom)     = 94  (SMA projection 13 assumed)
z_at = zj - 13;                     // Airspy case top              = 146
/* ---- device-dependent ghost / envelope numbers ---- */
dev_top = zj - sma_proj; z_bot = dev_top - dev_l;
pl = device == "rtl_v4" ? [18.33, 10, 25] : [12, 20, 40];   // plug body x, y, length (Airspy turned: 12 x 20)
pl_top = device == "rtl_v4" ? z_bot : z_bot - 12;          // plug top (Airspy: under the 12 mm male USB-A)
pb = pl_top - pl[2];                                        // plug bottom = cable start (RTL 56, Airspy 42)
/* ---- plug bay ---- */
z_bf = 13;                          // bay floor = hub top = cable sill
z_bt = 44 + 0*dz;                   // bay ceiling
bi = [12.5, 13]; bo = [15.5, 16];   // bay inner / outer half sizes
dia = 22.6;                         // |x|+|y| limit for the bay walls (keeps the latch pockets + tabs clear)
pk_top = 40;                        // latch pockets open up to here (finger room over the tabs)
/* ---- hub / hinge ---- */
hub_r = 34; hub_h = 13;
a = 11;                             // hinge axis height = knuckle radius
r_ax = 32;                          // hinge axis distance from the centre
kw = 16;                            // knuckle / leg width
tc = 4.5;                           // cheek thickness (rigid)
cone_r = 4.2; cone_h = 3.2;         // 45-degree cone pins
rg = 7; G = 1.4; gw = 1.2;          // stop groove radius / depth / flat width
key_r = 1.25;
th_dep = 135; fold = 90;
ch_x0 = r_ax - a + 0.2;             // cheek inner end (21.2)
ch_x1 = r_ax + 13;                  // cheek outer end
/* ---- legs ---- */
Lleg = 84; h0 = 20; h1 = 12; pad_r = 10; stake_d = 5.5; chf = 2;
legs = [45, 135, 225, 315];
// legs 135 / 315 are mirror images, so the release tabs sit only in the 90 / 270 deg gaps and the
// 0 deg gap (the cable exit) has no latch tab above the hub top
function mir(p) = (p == 135 || p == 315) ? 1 : 0;
/* ---- latch (leg frame: x radial from the centre, y tangential, z up) ---- */
dn = 1.3;                           // notch depth below the knuckle land (R = a)
t_r = a - dn + lc;                  // tooth tip radius from the axis when engaged (10.0)
t_hz = 1.4;                         // tooth half height (z), tooth = 2.8 mm
t_y = [1.0, 7.6];                   // tooth band (y)
n_y = [t_y[0] - 0.4, kw/2 + 0.5];   // notch band on the knuckle
bm_t = 2.0;                         // beam thickness (x)
bm_x1 = r_ax - a - hc;              // beam front face (20.65)
bm_x0 = bm_x1 - bm_t;               // beam back face (18.65)
bm_gap = 2.3;                       // beam back -> pocket wall = overtravel stop
pk_x0 = bm_x0 - bm_gap;             // pocket back (16.35)
pk_y = [-12, 14.0];                 // pocket span (y); beam anchored at y = -12
bm_y = [-13, 13.4];                 // beam span (1 mm into the anchor)
bm_h = hub_h;                       // beam height (z 0..13, sits on the bed / ground)
tab_y = [8.6, 13.4]; tab_top = 26;  // release tab at the free end
/* ---- stops (v4.1 formulas) ---- */
key_half = (key_r - hc) / rg * 180 / PI;
end_m = asin((key_r - hc + hc*sqrt(2)) / rg) - key_half;
stop_in = 0;                        // groove hard stops at -4.2 / +94.2 deg = backup; the TOOTH is the working stop (+-2.2 deg)
g_hi = th_dep + key_half + end_m - stop_in;
g_lo = th_dep - fold - key_half - end_m + stop_in;
raise = 0.8; font = "Liberation Sans:style=Bold";

module rsq(x, y) translate([-x/2, -y/2]) square([x, y]);
module slab(x, y, z0, z1) translate([0, 0, z0]) linear_extrude(z1 - z0) rsq(x, y);
module frustum(x0, y0, x1, y1, z0, z1) hull() { slab(x0, y0, z0, z0 + 0.01); slab(x1, y1, z1 - 0.01, z1); }
module cslab(x, y, z0, z1, c) translate([0, 0, z0]) linear_extrude(z1 - z0) offset(delta = c, chamfer = true) rsq(x - 2*c, y - 2*c);
module peak(wd, ht) polygon([[-wd/2,0],[wd/2,0],[wd/2,ht],[0,ht+wd/2],[-wd/2,ht]]);
module teardrop(d) hull() { circle(d = d); translate([0, d/2*sqrt(2) - 0.01]) square(0.02, center = true); }
module box(x0, x1, y0, y1, z0, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
function kp(th, rho) = [r_ax + rho*cos(th), a + rho*sin(th)];

// ================= LEG (local frame) =================
module knuckle_profile() hull() { translate([r_ax, a]) circle(r = a); translate([r_ax - a*(sqrt(2) - 1), 0]) square([2*a*(sqrt(2) - 1), 0.01]); }
module groove_cut() translate([r_ax, kw/2 + 0.01, a]) rotate([90, 0, 0]) rotate([0, 0, g_lo])
  rotate_extrude(angle = g_hi - g_lo, $fn = 120)
    polygon([[rg - gw/2 - G - 0.02, -0.02], [rg + gw/2 + G + 0.02, -0.02], [rg + gw/2, G + 0.01], [rg - gw/2, G + 0.01]]);
module knuckle_side() translate([r_ax, kw/2 - 0.01, a]) rotate([-90, 0, 0]) cylinder(r1 = cone_r, r2 = cone_r - cone_h, h = cone_h + 0.01);
// latch notches: D (deployed) on the inner face at axis height, S (stowed) on the top of the knuckle
module notch_D() box(r_ax - a - 2, r_ax - (t_r - lc), n_y[0], n_y[1], a - t_hz - lz, a + t_hz + lz);
module notch_S() box(r_ax - t_hz - lc, r_ax + t_hz + lc, n_y[0], n_y[1], a + t_r - lz, 2*a + 2);
module leg_body() {
  difference() {
    union() {
      rotate([90, 0, 0]) translate([0, 0, -kw/2]) linear_extrude(kw) knuckle_profile();
      hull() for (x = [r_ax, r_ax + Lleg]) translate([x, 0, 0]) rotate([90, 0, 90]) linear_extrude(0.01)
        polygon([[-kw/2, 0], [kw/2, 0], [kw/2, (x == r_ax ? h0 : h1) - chf], [kw/2 - chf, x == r_ax ? h0 : h1],
                 [-kw/2 + chf, x == r_ax ? h0 : h1], [-kw/2, (x == r_ax ? h0 : h1) - chf]]);
      translate([r_ax + Lleg, 0, 0]) { cylinder(r = pad_r, h = h1 - chf); translate([0, 0, h1 - chf - 0.01]) cylinder(r1 = pad_r, r2 = pad_r - chf, h = chf + 0.01); }
    }
    for (m = [0, 1]) mirror([0, m, 0]) groove_cut();
    notch_D(); notch_S();
    translate([r_ax + Lleg, 0, -1]) cylinder(d = stake_d, h = 30);                       // tent-stake hole (kept)
    translate([r_ax + Lleg, 0, -0.01]) cylinder(d1 = stake_d + 1.6, d2 = stake_d, h = 0.8);
  }
  for (m = [0, 1]) mirror([0, m, 0]) knuckle_side();
}
module folded_leg(f) translate([r_ax, 0, a]) rotate([0, -f, 0]) translate([-r_ax, 0, -a]) leg_body();

// ================= HINGE (hub side) =================
module cheek_pair() for (m = [0, 1]) mirror([0, m, 0]) {
  y0 = kw/2 + hc;
  difference() {
    union() {
      intersection() {
        translate([ch_x0, y0, 0]) cube([ch_x1 - ch_x0, tc, 2*a]);
        rotate([-90, 0, 0]) translate([0, 0, -50]) linear_extrude(100)
          polygon([[0, 0], [ch_x1, 0], [ch_x1, -a], [ch_x1 - a, -2*a], [0, -2*a]]);
      }
      p = kp(th_dep, rg);   // stop key (runs in the knuckle groove = hard stops at 0 and 90 deg)
      translate([p[0], y0 + 0.01, p[1]]) rotate([90, 0, 0]) cylinder(r1 = key_r, r2 = 0, h = key_r, $fn = 24);
    }
    pin_socket();
  }
}
// cone-pin socket (45 deg, normal clearance hc) - also cut from the hub plate under the cheeks
module pin_socket() translate([r_ax, kw/2, a]) rotate([-90, 0, 0]) {
  cylinder(r1 = cone_r + hc*sqrt(2), r2 = cone_r - cone_h, h = cone_h + hc*sqrt(2));   // 45 deg, runs past the pin tip
  cylinder(r = 1.2, h = 20);
}
// spring pawl: beam (anchored at y = bm_y[0]) + square tooth + release tab
module pawl() {
  box(bm_x0, bm_x1, bm_y[0], bm_y[1], 0, bm_h);
  box(bm_x1 - 0.01, r_ax - t_r, t_y[0], t_y[1], a - t_hz, a + t_hz);           // tooth (square faces)
  hull() { box(bm_x0, bm_x1, tab_y[0], tab_y[1], bm_h - 0.01, bm_h);
           box(bm_x0 - 2.6, bm_x1, tab_y[0], tab_y[1], bm_h + 2.6, tab_top - 1); }
  hull() { box(bm_x0 - 2.6, bm_x1, tab_y[0], tab_y[1], tab_top - 1.01, tab_top - 1); box(bm_x0 - 1.6, bm_x1, tab_y[0], tab_y[1], tab_top - 0.01, tab_top); }
}
module pawl_pocket() box(pk_x0, ch_x0, pk_y[0], pk_y[1], -1, pk_top);
module leg_slot() box(r_ax - a - hc, 80, -(kw/2 + hc), kw/2 + hc, -1, 60);

// ================= HUB PLATE =================
module hub_plate() { cylinder(r = hub_r, h = hub_h - 2); translate([0, 0, hub_h - 2 - 0.01]) cylinder(r1 = hub_r, r2 = hub_r - 2, h = 2.01); }

// ================= COLUMN (v4.3) =================
module oct(hx, hy, d) intersection() { rsq(2*hx, 2*hy); rotate(45) square(d*sqrt(2), center = true); }
module sxy(h, z0, z1) translate([0, 0, z0]) linear_extrude(z1 - z0) rsq(2*h[0], 2*h[1]);
module lay(z) translate([0, 0, z]) linear_extrude(0.01) children();
module column() difference() {
  union() {
    linear_extrude(z_bt + 7) oct(bo[0], bo[1], dia);                                    // bay walls (+ around the transitions)
    for (o = [oA, oB]) hull() { lay(z_bt + 6.99) oct(bo[0], bo[1], dia); lay(z_bt + 10) rsq(2*o[0], 2*o[1]); }
    sxy(oA, z_bt + 10, z_col - 2);                                                      // slot-A tube (= v4.1 tube 33.6 x 19.6)
    sxy(oB, z_bt + 10, z_top);                                                          // slot-B arms (outer |y| 16.0, inside the mast skirt 16.3)
    // ---- v4.1 top, unchanged (translated by dz) ----
    frustum(ow, oh, cowx, cowy, z_col - 2, z_col);
    cslab(cowx, cowy, z_col, z_top, 2.5);
    hull() { cslab(cowx, cowy, z_top - 0.01, z_top, 2.5); cslab(cowx, cowy + 8, z_top + 4, z_top + 4.01, 2.5); }
    hull() { cslab(cowx, cowy + 8, z_top + 4, z_g - gch, 2.5); cslab(cowx - 2*gch, cowy + 8 - 2*gch, z_g - 0.01, z_g, 1.5); }
    for (s = [-1, 1]) hull() {
      translate([s*(cowx/2 - 1), 0, z_mb - (lug_out + 1)]) cube([0.01, 12, 0.01], center = true);
      translate([s*(cowx/2 - 1 + (lug_out + 1)/2), 0, z_g - lug_h/2]) cube([lug_out + 1, 12, lug_h], center = true);
    }
  }
  // bay (open +x front), 45-deg transitions to the two plug passages, passages, cross pocket
  translate([0, 0, z_bf]) linear_extrude(z_bt - z_bf) oct(bi[0], bi[1], dia - 3*sqrt(2));
  translate([4, 0, z_bf]) rotate([90, 0, 90]) linear_extrude(30) peak(13, z_bt + 4 - z_bf);   // open front, peaked top at z_bt + 10.5
  for (c = [cC, cD]) hull() { lay(z_bt - 0.01) oct(bi[0], bi[1], dia - 3*sqrt(2)); lay(z_bt + 7) rsq(2*c[0], 2*c[1]); }
  sxy(cC, z_bt, z_as + 0.01);                       // Airspy USB-A female end passage
  sxy(cD, z_bt, z_rs + 0.01);                       // RTL USB-C plug passage
  sxy(pA, z_rs, z_top + 0.01);                      // slot A: RTL (seat = x ledges at z_rs)
  sxy(pB, z_as, z_top + 0.01);                      // slot B: Airspy (seat = arm ledges at z_as)
  // Airspy insertion path (it goes in turned 90 deg, 27 mm along y): open the centre of the guard y-walls,
  // |x| <= 6.8, merging with the v4.1 wrench/strap slots (|x| 6.75..11.25). Lugs, x-walls, rim corners unchanged.
  box(-6.8, 6.8, -30, 30, z_top - 0.5, z_g + 1);
  hull() { slab(iw, ih, z_top, z_top + 0.01); slab(iw, ih + 8, z_top + 4, z_top + 4.01); }   // = v4.1
  slab(iw, ih + 8, z_top + 4, z_g + 1);
  // vents: +-x faces (slot A) and arm ends (slot B)
  for (z = [z_rs + 8, z_rs + 32]) translate([oA[0] - tw - 1, 0, z]) rotate([90, 0, 90]) linear_extrude(tw + 4) peak(7, 9);
  for (z = [z_rs + 8, z_rs + 32]) translate([-oA[0] - 3, 0, z]) rotate([90, 0, 90]) linear_extrude(tw + 4) peak(7, 9);
  for (z = [z_as + 8, z_as + 28]) translate([0, 0, z]) rotate([90, 0, 0]) linear_extrude(40, center = true) peak(6, 9);
  // guard: wrench / drain slots + strap notches, lug holes (v4.1)
  for (s = [-1, 1]) for (x = [-9, 9]) translate([x - 2.25, s > 0 ? 0 : -50, z_top - 0.5]) cube([4.5, 50, 20]);
  for (s = [-1, 1]) translate([s*(cowx/2 + lug_out/2), 0, z_g - lug_h/2]) rotate([90, 0, 0]) linear_extrude(20, center = true) teardrop(lug_hole);
}
module label3d() translate([-bo[0] + 0.01, 0, z_bf + 2]) rotate([0, -90, 0])
  linear_extrude(raise + 0.01) offset(r = 0.15) translate([0, -2]) text("V4.3", size = 4, font = font);

module hub() {
  difference() {
    union() { hub_plate(); column(); label3d(); }
    for (p = legs) rotate(p) mirror([0, mir(p), 0]) { leg_slot(); pawl_pocket(); for (m = [0, 1]) mirror([0, m, 0]) pin_socket(); }
  }
  // Airspy crush ribs on the slot-B x faces, |y| 10.8..13.8 (outside the plug passage)
  for (sx = [-1, 1], sy = [-1, 1])
    box(sx > 0 ? pB[0] - rib_t : -pB[0] - 0.05, sx > 0 ? pB[0] + 0.05 : -pB[0] + rib_t,
        sy > 0 ? 10.8 : -pB[1] - 0.05, sy > 0 ? pB[1] + 0.05 : -10.8, z_as + 3, z_at - 3);
  for (p = legs) rotate(p) mirror([0, mir(p), 0]) { cheek_pair(); pawl(); }
}
module legs_at(f) for (p = legs) rotate(p) mirror([0, mir(p), 0]) folded_leg(f);

// ================= ANTENNA MAST (separate print, prints upright, no supports) =================
gx = cowx/2; gy = (cowy + 8)/2;            // guard outer half sizes (17.8 x 14.8)
lx = gx + mc + ml; ly = gy + mcy + ml;      // skirt outer half sizes
ex = gx + lug_out + mc + 3.2;               // fork ear outer x
zs = z_g - gch + gch*sqrt(2)*0 + mc*sqrt(2); // seat line: guard chamfer shifted up by mc*sqrt(2) (normal clearance mc)
module mast_cavity() {
  // skirt + 45-deg conical seat on the guard rim chamfer, then the tower interior
  intersection() {
    hull() { translate([0, 0, z_mb - 1]) linear_extrude(0.01) rsq(2*(gx + mc), 400);
             translate([0, 0, zs - mc]) linear_extrude(0.01) rsq(2*(gx + mc), 400);
             translate([0, 0, zs + gx - iw/2]) linear_extrude(0.01) rsq(iw, 400); }
    hull() { translate([0, 0, z_mb - 1]) linear_extrude(0.01) rsq(400, 2*(gy + mcy));
             translate([0, 0, zs - mcy]) linear_extrude(0.01) rsq(400, 2*(gy + mcy));
             translate([0, 0, zs + gy - (ih/2 + 4)]) linear_extrude(0.01) rsq(400, ih + 8); }
  }
  // tower interior (= guard interior) up to the 45-degree roof cone
  intersection() {
    slab(iw, ih + 8, zs, z_db);
    hull() { slab(iw, ih + 8, zs, z_db - (iw/2 - 4.8)); translate([0, 0, z_db - 0.01]) cylinder(d = 9.6, h = 0.01); }
  }
}
module mast_body() {
  // skirt
  cslab(2*lx, 2*ly, z_mb, z_g, 2);
  // fork ears (straddle the lugs)
  for (sx = [-1, 1]) for (sy = [-1, 1]) translate([sx > 0 ? gx : -ex, sy > 0 ? 6 + mc : -(6 + mc + 4), z_mb]) cube([ex - gx, 4, lug_h + 2]);
  // skirt -> tower 45-degree transition, tower, deck
  hull() { cslab(2*lx, 2*ly, z_g - 0.01, z_g, 2); cslab(2*gx, 2*gy, z_g + (ly - gy), z_g + (ly - gy) + 0.01, 2.5); }
  cslab(2*gx, 2*gy, z_g + (ly - gy), z_dt, 2.5);
  // collar
  translate([0, 0, z_dt - 0.01]) cylinder(d = col_od, h = col_hgt + 0.01, $fn = 96);
}
module strap_groove(z) translate([0, 0, z]) rotate_extrude($fn = 96)
  polygon([[col_od/2 - 1.2, 0], [col_od/2 + 1, -2.2], [col_od/2 + 1, 6.2], [col_od/2 - 1.2, 4]]);
module mast() difference() {
  mast_body();
  mast_cavity();
  // lug notches (peaked top) through skirt + ears
  for (sx = [-1, 1]) translate([sx > 0 ? gx - 1.3 : -ex - 1, 0, 0]) rotate([90, 0, 90]) linear_extrude(ex - gx + 2.3)
    translate([0, z_mb - 1]) polygon([[-(6 + mc), 0], [6 + mc, 0], [6 + mc, z_g + mc - z_mb + 1], [0, z_g + mc - z_mb + 1 + 6 + mc], [-(6 + mc), z_g + mc - z_mb + 1]]);
  // M4 bolt holes (teardrop) through the ears, coaxial with the lug holes
  for (sx = [-1, 1]) translate([sx*(gx + lug_out/2), 0, z_g - lug_h/2]) rotate([90, 0, 0]) linear_extrude(40, center = true) teardrop(lug_hole);
  // jumper-loop windows (+-x) and access windows (+-y), peaked
  for (sx = [-1, 1]) translate([sx*(gx - tw - 0.5) - (sx < 0 ? tw + 1 : 0), 0, z_g + 3]) rotate([90, 0, 90]) linear_extrude(tw + 1.01) peak(14, 33);
  for (sy = [-1, 1]) translate([0, sy*(gy - 2) , z_g + 7]) rotate([90, 0, 0]) linear_extrude(6, center = true) peak(16, 26);
  // bulkhead hole + anti-rotation hex pocket (or round counterbore)
  translate([0, 0, z_db - 1]) cylinder(d = bh_hole, h = 20);
  translate([0, 0, z_dt - bh_pocket]) if (bh_hex > 0) cylinder(d = (bh_hex + 0.3)/cos(30), h = 10, $fn = 6); else cylinder(d = 11, h = 10);
  // collar bore, top chamfer, slit, zip-tie grooves
  translate([0, 0, z_dt]) cylinder(d = col_bore, h = col_hgt + 1, $fn = 96);
  translate([0, 0, z_dt + col_hgt - 1]) cylinder(d1 = col_bore, d2 = col_bore + 2.2, h = 1.11, $fn = 96);
  translate([-col_slit/2, 0, z_dt + 3]) cube([col_slit, col_od, col_hgt]);
  for (z = [z_dt + 7, z_dt + col_hgt - 9]) strap_groove(z);
}
// ================= GRIP INSERT (TPU via CFS, or PETG) =================
// slides into the collar; split so a TPU insert wraps round the antenna (PETG: slide it down from the tip)
module insert(n = ins) { e = ins_get(n); b = e[1]; rh = e[2]; h = col_hgt - 0.5;
  difference() {
    union() {
      cylinder(d = col_bore - 0.4, h = h, $fn = 96);
      translate([0, 0, h - 0.01]) cylinder(d = col_bore + 3, h = 1.6, $fn = 96);     // pull flange (sits on the collar)
    }
    difference() {
      translate([0, 0, -1]) cylinder(d = b, h = h + 4, $fn = 72);
      for (k = [0 : 5]) rotate(30 + k*60) translate([b/2, 0, -2]) linear_extrude(h + 6) polygon([[0.3, -rh], [0.3, rh], [-rh, 0]]);   // crush ribs
    }
    translate([-0.6, 0, -1]) cube([1.2, col_bore, h + 4]);                                  // split
    translate([0, 0, -0.01]) cylinder(d1 = b + 1.6, d2 = b, h = 0.8, $fn = 72);              // lead-in
    translate([0, 0, h - 0.4]) cylinder(d1 = b, d2 = b + 2.4, h = 2.01, $fn = 72);
  }
}
module ghost_feed() {
  gold = [0.85,0.7,0.2]; blk = [0.12,0.12,0.12];
  // bulkhead: lower jack + nut, flange hex, upper jack
  color(gold) { translate([0, 0, zbj]) cylinder(d = 6.3, h = z_dt - zbj + 9);
    translate([0, 0, z_db - 2.5]) cylinder(d = 9.2, h = 2.5, $fn = 6);
    translate([0, 0, z_dt - bh_pocket]) cylinder(d = 9.2, h = 2.5, $fn = 6); }
  // RG316 jumper, right-angle plugs both ends, hairpin loop out of the +x window
  r = (zbj - 5 - (zj + 5))/2;
  color(gold) { translate([0, 0, zj - 8]) cylinder(d = 8, h = 13); translate([0, 0, zbj - 9]) cylinder(d = 8, h = 9); }
  color(gold) { translate([0, 0, zj + 5]) rotate([0, 90, 0]) cylinder(d = 6, h = 14); translate([0, 0, zbj - 5]) rotate([0, 90, 0]) cylinder(d = 6, h = 14); }
  color(blk) { translate([14, 0, zj + 5]) rotate([0, 90, 0]) cylinder(d = 2.6, h = 14); translate([14, 0, zbj - 5]) rotate([0, 90, 0]) cylinder(d = 2.6, h = 14);
    translate([28, 0, zj + 5 + r]) rotate([90, 0, 0]) rotate([0, 0, -90]) rotate_extrude(angle = 180, $fn = 48) translate([r, 0]) circle(d = 2.6, $fn = 12);
  }
}
module ghost_na771() color([0.1,0.1,0.1]) translate([0, 0, z_dt + 1]) {
  cylinder(d = 14, h = 34); translate([0, 0, 34]) cylinder(d1 = 14, d2 = 6, h = 12); translate([0, 0, 46]) cylinder(d1 = 6, d2 = 4, h = 338); }
module ghost_rh789(ext = 805) translate([0, 0, z_dt + 1]) {
  color([0.85,0.7,0.2]) cylinder(d = 10, h = 20);                       // SMA-M -> BNC-F adapter
  color([0.6,0.6,0.62]) translate([0, 0, 12]) cylinder(d = 14.5, h = 20);    // BNC plug sleeve
  color([0.1,0.1,0.1]) translate([0, 0, 32]) cylinder(d = 12, h = 16);       // hinge block
  color([0.75,0.75,0.78]) translate([0, 0, 48]) for (k = [0:5]) translate([0, 0, k*(ext - 60)/6]) cylinder(d = 8 - k, h = (ext - 60)/6 + 8); }

// ================= ghosts =================
module radio_body() {   // case + SMA + male USB-A (Airspy) in its seat
  if (device == "rtl_v4") { translate([-13.5, -6.5, z_rs]) cube([27, 13, 69]); }
  else { translate([-5.5, -13.5, z_as]) cube([11, 27, 52]); translate([-2.25, -6, z_as - 12]) cube([4.5, 12, 12.01]); }
  translate([0, 0, dev_top - 0.01]) cylinder(d = 6.3, h = sma_proj);
}
module plug_body() translate([-pl[0]/2, -pl[1]/2, pb]) cube([pl[0], pl[1], pl[2]]);
// cable: from the plug bottom, bend radius r through 90 deg toward +x, then straight out past the rim
module cable(r = bend_r, d = 4.5) {
  translate([r, 0, pb]) rotate([90, 0, 0]) rotate([0, 0, 180]) rotate_extrude(angle = 90, $fn = 64) translate([r, 0]) circle(d = d, $fn = 20);
  translate([r - 0.01, 0, pb - r]) rotate([0, 90, 0]) cylinder(d = d, h = 60, $fn = 20);
  translate([0, 0, pb - 0.01]) cylinder(d = d, h = 0.6, $fn = 20);   // joins the plug
}
module ghost_radio() {
  color([0.7,0.7,0.75]) radio_body();
  color([0.55,0.57,0.6]) plug_body();
  color([0.12,0.12,0.12]) cable();
}
module viz_all(f = 0) {
  color([0.25,0.27,0.3]) hub(); color([0.35,0.37,0.42]) legs_at(f); ghost_radio();
  color([0.3,0.45,0.6]) mast(); color([0.9,0.45,0.1]) translate([0, 0, z_dt]) insert(); ghost_feed();
  color([0.6,0.6,0.6]) for (sx = [-1, 1]) translate([sx*(gx + lug_out/2), 0, z_g - lug_h/2]) rotate([90, 0, 0]) cylinder(d = 4, h = 28, center = true);
}
echo(str("v4.3: RTL seat ", z_rs, " top ", z_top, " | Airspy seat ", z_as, " top ", z_at, " | SMA face ", zj, " (v4.1 135 + dz ", dz, ") | ghost ", device, " plug bottom ", pb, " bend r ", bend_r));
echo(str("groove ", g_lo, "..", g_hi, " deg; tooth tip x ", r_ax - t_r, " beam ", bm_x0, "..", bm_x1, " pocket back ", pk_x0));

if (part == "print") { hub(); legs_at(0); }
else if (part == "hub") hub();
else if (part == "leg") rotate(45) folded_leg(phi);
else if (part == "folded") { hub(); legs_at(fold); }
else if (part == "viz") { viz_all(0); ghost_na771(); }
else if (part == "viz_folded") { color([0.25,0.27,0.3]) hub(); color([0.35,0.37,0.42]) legs_at(fold); ghost_radio(); }
else if (part == "latch") { color([0.25,0.27,0.3]) hub(); color([0.85,0.55,0.15]) rotate(45) folded_leg(phi); }
else if (part == "latch_section") intersection() {
  rotate(-45) union() { color([0.25,0.27,0.3]) hub(); color([0.85,0.55,0.15]) rotate(45) folded_leg(phi); }
  box(8, 50, 1.0, 7.6, -1, 40); }
else if (part == "beam") rotate(45) pawl();
else if (part == "hub_nopawl") difference() { hub(); for (p = legs) rotate(p) mirror([0, mir(p), 0]) pawl(); }
else if (part == "radio") radio_body();                       // device-fit check
else if (part == "plug") plug_body();
else if (part == "env") { plug_body(); cable(bend_r, 4.5 + 2*env_c); }   // cable-bend envelope (cable + env_c all round)
else if (part == "bend_section") {                            // half section at y = 0, seen from -y
  color([0.25,0.27,0.3]) difference() { hub(); box(-100, 100, -100, 0, -5, 300); }
  color([0.35,0.37,0.42]) difference() { legs_at(0); box(-200, 200, -200, 0, -5, 300); }
  ghost_radio(); color([0.9,0.2,0.2,0.35]) cable(bend_r, 4.5 + 2*env_c); }
else if (part == "pocket_section") {                          // cut at z 120, seen from above: both radios in the cross pocket
  color([0.25,0.27,0.3]) difference() { hub(); box(-100, 100, -100, 100, 120, 300); }
  color([0.85,0.55,0.15, 0.8]) translate([-13.5, -6.5, z_rs]) cube([27, 13, 120 - z_rs - 1]);
  color([0.3,0.6,0.9, 0.8]) translate([-5.5, -13.5, z_as]) cube([11, 27, 120 - z_as - 0.5]); }

