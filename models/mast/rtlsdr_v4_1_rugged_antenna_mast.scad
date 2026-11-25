// =====================================================================
// v4.1 RUGGED FIELD stand + ANTENNA MAST for the RTL-SDR Blog V4
//  v4.1 changes vs v4.0 (rtlsdr_v4_rugged_field_stand.scad, kept unchanged):
//   * DEPLOYED LEG LOCK: 45-deg cone key on each (lengthened) cheek snaps into a
//     conical dimple in the leg side face at r = 11.4 mm from the hinge axis
//     (play ~2.5 deg instead of ~12 deg). Leaving it needs ~0.65 mm cheek flex.
//     A relief channel lets the key run free once the lock is released.
//     The groove keeps the hard stops + the STOWED detent.
//   * lanyard lugs rebuilt solid (v4.0 wrench slots split them), true 45-deg
//     undersides; lug holes take M4 bolts = mast mounting points
//   * guard rim gets a 45-deg outer chamfer = conical seat for the mast
//  ANTENNA MAST (separate print, 2x M4 bolts through the lugs):
//   SMA F-F bulkhead in the deck, short RG316 jumper (hairpin) down to the
//   dongle, collar + interchangeable TPU/PETG grip inserts around the antenna
//   base. Antenna leverage goes antenna base -> insert -> collar -> mast ->
//   guard/lugs -> column; the dongle SMA only carries the jumper.
// ---------------------------------------------------------------------
// (v4.0 notes)
//  - dongle upright, SMA up, held by a 4 mm-wall collar; raised guard cup
//    around the SMA (wrench/drain slots), strap notches to tie the dongle in,
//    lanyard lugs
//  - USB-A extension female end in a 3 mm-wall sleeve inside the hub; cable
//    drops straight down and leaves through a protected floor channel with an
//    S-tooth grip + zip-tie anchor (strain relief); no doubling back
//  - 4 solid chamfered legs on PRINT-IN-PLACE hinges that fold UP flat against
//    the column. Each hinge: double 45-degree cone pins (knuckle -> cheeks),
//    0.35 mm clearance, flexible cheeks; a cone key on each cheek runs in an
//    arc groove on the knuckle = hard stops at deployed (0 deg) and stowed
//    (90 deg) + click detents (humps) holding both positions
//  - stake / tie-down holes in the leg pads
// Creality K2 Pro, 0.4 mm nozzle, prints DEPLOYED in place, no supports
// (all overhangs <= 45 deg: cones, peaked windows, teardrop knuckles).
// Sources: RTL-SDR Blog V4 aluminium case 69 x 27 x 13 mm (rtl-sdr.com).
// =====================================================================
part = "print";   // print | hub | leg | folded | mast | insert | viz | viz_folded | viz_rh789 | section | lock_section | mast_section
ins = "na771";    // insert: "na771" | "rh789_bnc" | "srh789_sma" | "custom"
phi  = 0;         // leg fold angle for part="leg" (0 deployed .. 90 stowed)
sec_z = 9;        // section height for part="section" (9 = cone pins, 13.2 = key in groove)
fit = 0.3;        // dongle / USB fit
hc  = 0.35;       // HINGE clearance (normal) - K2 Pro 0.30..0.40
$fn = 56;

/* ---- hardware ---- */
sdr_l = 69; sdr_w = 27; sdr_h = 13; sma_proj = 9;      // SMA jack projection above case end (assumed)
usbf_w = 16; usbf_h = 9; usbf_l = 35; cable_d = 6;
/* ---- column ---- */
tw = 3; cw4 = 4;                    // tube wall, collar wall
guard_h = 8;                        // guard cup height above the case end
/* ---- hub / hinge ---- */
hub_r = 34; hub_h = 13;
a = 9;                              // hinge axis height = knuckle radius
r_ax = 30;                          // hinge axis distance from the centre
kw = 12;                            // knuckle / leg width
tc = 3.5;                           // cheek thickness (flexes 0.4 mm for the detent)
slit = 0.8;                         // cheek-to-hub slit
r_root = 16;                        // cheek root (rigid block) start
cone_r = 3.5; cone_h = 3;           // 45-degree cone pins
rg = 6;                             // key / groove radius on the knuckle face
G = 1.4; gw = 1.2;                  // groove depth, flat-bottom width (45-deg flanks)
key_r = 1.25;                       // 45-degree cone key on the cheek (height = radius)
hump_r = 0.9;                       // 45-degree cone humps in the groove (detent)
th_dep = 135; fold = 90;            // key position (knuckle frame) when deployed; fold angle
/* ---- legs ---- */
Lleg = 68; h0 = 16; h1 = 10; pad_r = 10; stake_d = 5.5; chf = 1.5;
legs = [45, 135, 225, 315];
/* ---- v4.1 deployed lock (cheek key -> leg dimple) ---- */
ch_x1 = r_ax + 13;                  // cheek outer end (was r_ax + a + 0.5)
dl = [11, -3];                      // lock key position in the knuckle frame (rel. to the axis), deployed
dl_r = 1.0;                         // 45-deg cone key radius = height
dl_dr = dl_r - hc + hc*sqrt(2);     // dimple / channel cone radius at the leg face (normal clearance hc)
dl_rho = norm(dl); dl_th = atan2(dl[1], dl[0]);
dl_gap = (2*dl_dr + 1.0) / dl_rho * 180 / PI;   // dimple -> channel start (1 mm ridge = the barrier)
/* ---- v4.1 lugs ---- */
lug_out = 9; lug_h = 12; lug_hole = 4.6;      // lug sticks out 9 mm from the guard x-face, M4 hole
/* ---- mast ---- */
mc = 0.3;            // mast fit (x, seat)
mcy = 1.5;           // mast lip clearance in y (zip ties in the strap notches)
ml = 3;              // lip wall
gch = 2.5;           // guard rim 45-deg chamfer
cage = 49;           // guard top -> deck underside (RG316 hairpin needs >= ~26 mm between plugs)
deck_t = 3.5;        // deck at the bulkhead (thread grip ~2 mm under the hex pocket)
bh_hole = 6.6;       // SMA 1/4-36 bulkhead
bh_hex = 8.0;        // bulkhead flange hex AF (anti-rotation pocket); 0 = round counterbore
bh_pocket = 1.5;
col_od = 29; col_bore = 22; col_hgt = 32; col_slit = 1.5;
/* ---- inserts (bore, rib height) ---- */
// TPU grip fit (split insert, zip-tie clamped): bore = measured base + 0.30 (slides on, no tearing),
// 6 crush ribs 0.45 tall -> rib tips = measured - 0.60 (0.30 mm radial interference per rib on TPU 95A)
// measured (Brad, calipers): NA-771 base 14.70, RH789 BNC plug 14.53
ins_tab = [["na771", 14.70 + 0.30, 0.45], ["rh789_bnc", 14.53 + 0.30, 0.45], ["srh789_sma", 11.4, 0.8], ["custom", 13.0, 0.8]];
function ins_get(n) = ins_tab[search([n], ins_tab)[0]];
raise = 0.8; font = "Liberation Sans:style=Bold"; label = 6;

/* ---- derived ---- */
iw = sdr_w + 2*fit;  ih = sdr_h + 2*fit;
sw = usbf_w + 2*fit; sh = usbf_h + 2*fit;
ow = iw + 2*tw; oh = ih + 2*tw; sow = sw + 2*tw; soh = sh + 2*tw;
cowx = iw + 2*cw4; cowy = ih + 2*cw4;
slot = cable_d + 1.5;
z_ch = 4;                           // cable channel floor
z_funnel = 16; z_fe0 = 22; z_fe1 = z_fe0 + usbf_l; z_tr = z_fe1 - 6;
z_top = z_fe1 + sdr_l;              // case end (SMA end)
z_col = z_top - 18;                 // collar start
z_g = z_top + guard_h;              // guard top
z_db = z_g + cage;                  // deck underside (cone apex) = bulkhead panel face
z_dt = z_db + deck_t;               // deck top / collar floor
z_mb = z_g - lug_h;                 // mast skirt bottom (also lug top block bottom)
y_ch = 10.65;                       // leg slot half width = kw/2 + hc + tc + slit
x_free = r_ax - a - hc;             // cheeks are free beyond this (root block inside)
key_half = (key_r - hc) / rg * 180 / PI;          // key angular half-width at the knuckle face
end_m = asin((key_r - hc + hc*sqrt(2)) / rg) - key_half;   // normal clearance hc to the 45-deg key at the groove-end corner
g_hi = th_dep + key_half + end_m;                  // groove end (deployed hard stop)
g_lo = th_dep - fold - key_half - end_m;           // groove end (stowed hard stop)
hump_off = 1.6 / rg * 180 / PI;                    // hump centre offset from the key
humps = [th_dep - fold + hump_off];        // v4.1: stowed detent only (deployed = dimple lock)

module rsq(x, y) translate([-x/2, -y/2]) square([x, y]);
module slab(x, y, z0, z1) translate([0, 0, z0]) linear_extrude(z1 - z0) rsq(x, y);
module frustum(x0, y0, x1, y1, z0, z1) hull() { slab(x0, y0, z0, z0 + 0.01); slab(x1, y1, z1 - 0.01, z1); }
module cslab(x, y, z0, z1, c) translate([0, 0, z0]) linear_extrude(z1 - z0) offset(delta = c, chamfer = true) rsq(x - 2*c, y - 2*c);
module peak(wd, ht) polygon([[-wd/2,0],[wd/2,0],[wd/2,ht],[0,ht+wd/2],[-wd/2,ht]]);
// map a point in the knuckle frame (angle th from +x toward +z, radius rho) to local x,z
function kp(th, rho) = [r_ax + rho*cos(th), a + rho*sin(th)];
// place children on a knuckle side face plane (y = +y0), Z = outward normal (+y)
module on_face(y0) translate([0, y0, 0]) rotate([-90, 0, 0]) children();

// ================= LEG (local frame: x radial, y tangential) =================
module knuckle_profile() hull() { translate([r_ax, a]) circle(r = a); translate([r_ax - a*(sqrt(2) - 1), 0]) square([2*a*(sqrt(2) - 1), 0.01]); }
module groove_cut() translate([r_ax, kw/2 + 0.01, a]) rotate([90, 0, 0]) rotate([0, 0, g_lo])
  rotate_extrude(angle = g_hi - g_lo, $fn = 120)
    polygon([[rg - gw/2 - G - 0.02, -0.02], [rg + gw/2 + G + 0.02, -0.02], [rg + gw/2, G + 0.01], [rg - gw/2, G + 0.01]]);
module humps_add() for (t = humps) { p = kp(t, rg);
  translate([p[0], kw/2 - G - 0.01, p[1]]) rotate([-90, 0, 0]) cylinder(r1 = hump_r, r2 = 0, h = hump_r, $fn = 24); }
module knuckle_side() {  // one side (+y); mirrored for -y
  translate([r_ax, kw/2 - 0.01, a]) rotate([-90, 0, 0]) cylinder(r1 = cone_r, r2 = cone_r - cone_h, h = cone_h + 0.01);
}
module leg_body() {
  difference() {
    union() {
      rotate([90, 0, 0]) translate([0, 0, -kw/2]) linear_extrude(kw) knuckle_profile();
      hull() for (x = [r_ax, r_ax + Lleg]) translate([x, 0, 0]) rotate([90, 0, 90]) linear_extrude(0.01)
        polygon([[-kw/2, 0], [kw/2, 0], [kw/2, (x == r_ax ? h0 : h1) - chf], [kw/2 - chf, x == r_ax ? h0 : h1],
                 [-kw/2 + chf, x == r_ax ? h0 : h1], [-kw/2, (x == r_ax ? h0 : h1) - chf]]);
      translate([r_ax + Lleg, 0, 0]) { cylinder(r = pad_r, h = h1 - chf); translate([0, 0, h1 - chf - 0.01]) cylinder(r1 = pad_r, r2 = pad_r - chf, h = chf + 0.01); }
    }
    for (m = [0, 1]) mirror([0, m, 0]) { groove_cut(); dlock_cut(); }
    translate([r_ax + Lleg, 0, -1]) cylinder(d = stake_d, h = 30);                       // stake / tie-down hole
    translate([r_ax + Lleg, 0, -0.01]) cylinder(d1 = stake_d + 1.6, d2 = stake_d, h = 0.8);  // bed-side chamfer
  }
  for (m = [0, 1]) mirror([0, m, 0]) { knuckle_side(); humps_add(); }
}
// v4.1 deployed lock: conical dimple at the key position + relief channel along the
// key path (fold direction = decreasing angle in the knuckle frame) after a 1 mm ridge
module dl_cone(th) { p = kp(th, dl_rho);
  translate([p[0], kw/2 + 0.3, p[1]]) rotate([90, 0, 0]) cylinder(r1 = dl_dr + 0.3, r2 = 0, h = dl_dr + 0.3, $fn = 24); }
module dlock_cut() {
  dl_cone(dl_th);
  for (t = [dl_th - dl_gap : -3 : dl_th - 75]) hull() { dl_cone(t); dl_cone(t - 3); }
}
// fold about the hinge axis (tip goes up toward the column)
module folded_leg(f) translate([r_ax, 0, a]) rotate([0, -f, 0]) translate([-r_ax, 0, -a]) leg_body();

// ================= HUB =================
module cheek_pair() for (m = [0, 1]) mirror([0, m, 0]) {
  y0 = kw/2 + hc;
  difference() {
    union() {
      // cheek plate, outer end rounded about the hinge axis, top-outer chamfer
      intersection() {
        translate([r_root, y0, 0]) cube([ch_x1 - r_root, tc, 2*a]);
        rotate([-90, 0, 0]) translate([0, 0, -50]) linear_extrude(100)
          polygon([[0, 0], [ch_x1, 0], [ch_x1, -a], [ch_x1 - a, -2*a], [0, -2*a]]);
      }
      // key: 45-degree cone from the cheek face toward the knuckle groove
      p = kp(th_dep, rg);
      translate([p[0], y0 + 0.01, p[1]]) rotate([90, 0, 0]) cylinder(r1 = key_r, r2 = 0, h = key_r, $fn = 24);
      // v4.1 deployed-lock key
      q = kp(dl_th, dl_rho);
      translate([q[0], y0 + 0.01, q[1]]) rotate([90, 0, 0]) cylinder(r1 = dl_r, r2 = 0, h = dl_r, $fn = 24);
    }
    // cone-pin socket (45-degree, normal clearance hc) + through hole
    translate([r_ax, kw/2, a]) rotate([-90, 0, 0]) {
      cylinder(r1 = cone_r + hc*sqrt(2), r2 = cone_r - cone_h + hc*sqrt(2), h = cone_h);
      cylinder(r = 1.2, h = 20);
    }
  }
}
module root_block() translate([r_root, -(kw/2 + hc + tc), 0]) cube([x_free - r_root, kw + 2*hc + 2*tc, 2*a]);

module hub_plate() difference() {
  union() {
    cylinder(r = hub_r, h = hub_h - 2); translate([0, 0, hub_h - 2 - 0.01]) cylinder(r1 = hub_r, r2 = hub_r - 2, h = 2.01);
  }
  for (p = legs) rotate(p) translate([x_free, -y_ch, -1]) cube([60, 2*y_ch, 60]);           // leg slots
  for (p = [90, 180, 270]) rotate(p) translate([22, -5, 3]) cube([8.5, 10, 20]);            // lightening pockets
  for (s = [-1, 1]) rotate(s*22) translate([24, -3.5, 3]) cube([7, 7, 20]);                // (beside the channel)
}
// cable channel with S-teeth grip and zip-tie anchor (strain relief)
module channel_cut() {
  translate([0, -slot/2, z_ch]) cube([60, slot, 30]);
  translate([hub_r - 3, -slot/2, z_ch]) linear_extrude(30) polygon([[0,0],[4,-3],[4, slot + 3],[0, slot]]);   // bell mouth
  // zip-tie anchor: two slots + under-floor tunnel (4.4 mm bridge)
  for (s = [-1, 1]) translate([27, s*(slot/2 + 1.6) - 1, -1]) cube([4.4, 2, 30]);
  translate([27, -(slot/2 + 2.6), -0.01]) cube([4.4, slot + 5.2, 2]);
}
module channel_teeth() for (t = [[15, 1], [21, -1]]) translate([t[0], t[1]*slot/2, z_ch])
  linear_extrude(hub_h - z_ch - 0.5) polygon([[-2.2, 0], [2.2, 0], [0, -t[1]*1.6]]);

// ================= COLUMN =================
module column() difference() {
  union() {
    cslab(sow, soh, 0, z_tr, 1.5);
    frustum(sow, soh, ow, oh, z_tr, z_fe1);
    cslab(ow, oh, z_fe1, z_col - 2, 2);
    frustum(ow, oh, cowx, cowy, z_col - 2, z_col);
    cslab(cowx, cowy, z_col, z_top, 2.5);
    // guard cup: outer widens 45 deg in y (protects SMA + antenna base)
    hull() { cslab(cowx, cowy, z_top - 0.01, z_top, 2.5); cslab(cowx, cowy + 8, z_top + 4, z_top + 4.01, 2.5); }
    hull() { cslab(cowx, cowy + 8, z_top + 4, z_g - gch, 2.5); cslab(cowx - 2*gch, cowy + 8 - 2*gch, z_g - 0.01, z_g, 1.5); }  // 45-deg rim chamfer = mast seat
    // lugs (+-x): lanyard + mast bolts, solid, 45-degree undersides
    for (s = [-1, 1]) hull() {
      translate([s*(cowx/2 - 1), 0, z_mb - (lug_out + 1)]) cube([0.01, 12, 0.01], center = true);
      translate([s*(cowx/2 - 1 + (lug_out + 1)/2), 0, z_g - lug_h/2]) cube([lug_out + 1, 12, lug_h], center = true);
    }
  }
  // cavities
  slab(sw, sh, z_fe0, z_tr + 0.01);
  frustum(sw, sh, iw, ih, z_tr, z_fe1 + 0.01);
  slab(iw, ih, z_fe1, z_top + 0.01);
  hull() { slab(iw, ih, z_top, z_top + 0.01); slab(iw, ih + 8, z_top + 4, z_top + 4.01); }
  slab(iw, ih + 8, z_top + 4, z_g + 1);
  frustum(slot, slot, sw, sh, z_funnel, z_fe0 + 0.01);
  slab(slot, slot, z_ch, z_funnel + 0.01);
  translate([0, -slot/2, z_ch]) cube([sow, slot, z_fe0 - 2 - z_ch]);                 // cable slot (+x) to the channel
  // vents (peaked, small - rugged)
  for (z = [z_fe1 + 5, z_fe1 + 27]) for (x = [-6.5, 6.5]) translate([x, 0, z]) rotate([90, 0, 0]) linear_extrude(60, center = true) peak(7, 9);
  for (z = [z_fe1 + 5, z_fe1 + 27]) translate([ow/2 - tw - 1, 0, z]) rotate([90, 0, 90]) linear_extrude(tw + 4) peak(7, 9);
  // guard: wrench / drain slots (x faces), strap notches (y faces, beside the SMA)
  for (s = [-1, 1]) for (x = [-9, 9]) translate([x - 2.25, s > 0 ? 0 : -50, z_top - 0.5]) cube([4.5, 50, 20]);
  // lanyard holes (teardrop, point up) through the lugs
  for (s = [-1, 1]) translate([s*(cowx/2 + lug_out/2), 0, z_g - lug_h/2]) rotate([90, 0, 0]) linear_extrude(20, center = true) teardrop(lug_hole);
}
module teardrop(d) hull() { circle(d = d); translate([0, d/2*sqrt(2) - 0.01]) square(0.02, center = true); }
module label3d() translate([-ow/2 + 0.01, 0, z_fe1 + 0.6]) rotate([0, -90, 0])
  linear_extrude(raise + 0.01) offset(r = 0.15) translate([0, -label/2]) text("RTL-SDR V4", size = label, font = font);

module hub() difference() {
  union() {
    hub_plate(); column(); label3d(); channel_teeth();
    for (p = legs) rotate(p) { cheek_pair(); root_block(); }
  }
  channel_cut();
  // keep the column cavities clear through the hub
  slab(slot, slot, z_ch, z_funnel + 0.01); slab(sw, sh, z_fe0, z_tr);
}
module legs_at(f) for (p = legs) rotate(p) folded_leg(f);

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
// ================= hardware ghosts =================
module ghost(f = 0) {
  color([0.7,0.7,0.75]) translate([-sdr_w/2, -sdr_h/2, z_fe1 + 0.5]) cube([sdr_w, sdr_h, sdr_l]);
  color([0.85,0.7,0.2]) translate([0, 0, z_top + 0.5]) cylinder(d = 6.3, h = sma_proj);
  color([0.2,0.2,0.2]) translate([-usbf_w/2, -usbf_h/2, z_fe0]) cube([usbf_w, usbf_h, usbf_l]);
  color([0.15,0.15,0.15]) { translate([0, 0, z_ch + cable_d/2]) rotate([0, 90, 0]) cylinder(d = cable_d - 0.5, h = 70);
    translate([0, 0, z_ch + cable_d/2]) cylinder(d = cable_d - 0.5, h = z_fe0 - z_ch - cable_d/2); }
}
zj = z_top + sma_proj;            // dongle SMA jack face
zbj = z_db - 12;                  // bulkhead lower jack face (assumed 12 mm below the panel)
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
module viz_all(f = 0) {
  color([0.25,0.27,0.3]) hub(); color([0.35,0.37,0.42]) legs_at(f); ghost();
  color([0.3,0.45,0.6]) mast(); color([0.9,0.45,0.1]) translate([0, 0, z_dt]) insert(); ghost_feed();
  color([0.6,0.6,0.6]) for (sx = [-1, 1]) translate([sx*(gx + lug_out/2), 0, z_g - lug_h/2]) rotate([90, 0, 0]) cylinder(d = 4, h = 28, center = true);
}
echo(str("groove ", g_lo, "..", g_hi, " deg, humps ", humps, ", key half ", key_half, " deg"));
echo(str("dlock rho ", dl_rho, " th ", dl_th, " dimple r ", dl_dr, " gap ", dl_gap, " deg; play ", hc*sqrt(2)/dl_rho*180/PI, " deg"));
echo(str("heights: case top ", z_top, " guard ", z_g, " dongle jack ", zj, " deck ", z_db, "/", z_dt, " collar top ", z_dt + col_hgt, " hairpin r ", (zbj - 5 - (zj + 5))/2));

if (part == "print") { hub(); legs_at(0); }
else if (part == "hub") hub();
else if (part == "leg") rotate(45) folded_leg(phi);
else if (part == "folded") { hub(); legs_at(fold); }
else if (part == "mast") translate([0, 0, -z_mb]) mast();
else if (part == "insert") rotate([180, 0, 0]) translate([0, 0, -(col_hgt - 0.5 + 1.6)]) insert();   // flange down on the bed
else if (part == "viz") { viz_all(0); ghost_na771(); }
else if (part == "viz_rh789") { viz_all(0); ghost_rh789(); }
else if (part == "viz_folded") { color([0.25,0.27,0.3]) hub(); color([0.35,0.37,0.42]) legs_at(fold); ghost(); }
else if (part == "section") intersection() {
  rotate(-45) union() { color([0.25,0.27,0.3]) hub(); color([0.85,0.55,0.15]) legs_at(0); }
  translate([12, -16, -1]) cube([34, 32, sec_z + 1]); }
else if (part == "lock_section") intersection() {   // horizontal cut through the lock keys (z = key height), view from the top
  rotate(-45) union() { color([0.25,0.27,0.3]) hub(); color([0.85,0.55,0.15]) legs_at(phi); }
  translate([30, -14, -1]) cube([18, 28, a + dl[1] + 1]); }
else if (part == "leg_flat") color([0.85,0.55,0.15]) folded_leg(0);
else if (part == "inserts_all") for (k = [0 : 2]) translate([k*32, 0, 0]) color([0.9,0.45,0.1]) insert(ins_tab[k][0]);
else if (part == "pack") { color([0.25,0.27,0.3]) hub(); color([0.35,0.37,0.42]) legs_at(fold);
  translate([75, 0, 0]) color([0.3,0.45,0.6]) translate([0, 0, -z_mb]) mast();
  for (k = [0 : 2]) translate([130, -35 + k*32, 0]) color([0.9,0.45,0.1]) insert(ins_tab[k][0]); }
else if (part == "mast_section") intersection() {
  union() { color([0.25,0.27,0.3]) hub(); color([0.3,0.45,0.6]) mast(); color([0.9,0.45,0.1]) translate([0, 0, z_dt]) insert(); ghost(); ghost_feed(); ghost_na771(); }
  translate([-60, 0, 90]) cube([120, 60, 150]); }
