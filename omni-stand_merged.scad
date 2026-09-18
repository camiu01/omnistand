// ==============================================================================
// Omni-Stand - Modular Entry Point
// @file main.scad
// Customizer variables + module wiring for PSP handheld console stand.
// Copyright (C) 2026 Camiu (https://github.com/camiu01)
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// Bodies use TABS for indentation.
// ==============================================================================

/* [Render & Tolerances] */

// Clearance offset applied to cable bores for FDM printer tolerances (mm)
print_tolerance = 0.4; // [0.1:0.05:1.2]

// Generate the console stand body
render_stand = true;

// Mesh circle and arc facet resolution count
$fn = 60; // [20:10:120]

/* [Preview Colors] */

// Stand body color in OpenSCAD preview (F5)
color_stand = "#FF8C00";

/* [1. Base Dimensions & Shape] */

// Width of the rear edge (where pillars are positioned)
base_rear_width = 125; // [50:1:200]

// Width of the front edge
base_front_width = 90; // [50:1:200]

// Overall base depth from front to rear
base_total_depth = 50; // [30:1:100]

// Outer corner fillet radius of the base
base_corner_radius = 4; // [0.1:0.5:20]

// Base floor baseplate thickness
base_floor_height = 15; // [8:1:30]

/* [2. Front Retaining Lip & Text] */

// Front retaining lip thickness
lip_wall_thickness = 12; // [6:1:30]

// Front retaining lip extra height over the floor
lip_extra_height = 8; // [2:1:20]

// Custom text engraved on the front face
engraved_text_string = "OMNI-STAND";

// Font size for the front text
engraved_text_size = 6; // [3:1:16]

// Engraving depth into the front surface
engraved_text_depth = 1.5; // [0.5:0.5:5]

/* [3. Front Lip Pocket Cutout] */

// Enable rounded pocket cut in the front lip
lip_pocket_enable = false;

// Width of the central opening in the front lip
lip_pocket_width = 40; // [10:1:150]

// Height of the solid lip bridge remaining below the cutout (measured from ground)
lip_pocket_bridge_height = 16; // [5:1:40]

// Inner corner fillet radius inside the front lip pocket
lip_pocket_corner_radius = 4; // [0.5:0.5:20]

/* [4. Rear Backrest] */

// Total height of the rear backrest pillars
backrest_total_height = 85; // [40:1:150]

// Width of each lateral backrest pillar
pillar_width = 16; // [8:1:40]

// Depth of each lateral backrest pillar
pillar_depth = 16; // [8:1:40]

/* [5. Rear Backrest Pocket Cutout] */

// Enable center cutout between rear pillars
pocket_cut_enable = true;

// Width of the rear pocket cutout (0 or negative auto-fits between pillars based on pillar_width)
rear_pocket_width = 0; // [0:1:200]

// Height of the solid bridge remaining below the rear cutout (measured from ground)
pocket_bridge_height = 27; // [10:1:60]

// Inner corner fillet radius inside the rear pocket
pocket_corner_radius = 14; // [2:1:35]

/* [6. Base Floor Cavity] */

// Enable material-saving cutout in the center floor
floor_cut_enable = true;

// Side border margin around the cavity
floor_cut_margin_sides = 18; // [5:1:40]

// Front and rear border margin around the cavity
floor_cut_margin_front_rear = 18; // [5:1:40]

// Inner corner fillet radius of the floor cavity
floor_cut_corner_radius = 6; // [0.1:0.5:15]

/* [7. Cable Routing - Shared Dimensions] */

// Master toggle for all cable channels
cable_enable = true;

// Cable hole diameter
cable_diameter = 12; // [4:1:30]

// Center height of the cable tunnel from the build plate (height == radius: flush tunnel; 0: open slot)
cable_center_height = 3; // [0:1:20]

/* [8. Cable Routing - Openings & Positions] */

// Enable rear hole
cable_rear_enable = true;

// Rear hole position (0 = left, 50 = center, 100 = right)
cable_rear_pos_percent = 50; // [0:1:100]

// Enable front hole
cable_front_enable = false;

// Front hole position (0 = left, 50 = center, 100 = right)
cable_front_pos_percent = 50; // [0:1:100]

// Enable left side hole
cable_left_enable = false;

// Left side hole position (0 = front, 50 = center, 100 = rear)
cable_left_pos_percent = 50; // [0:1:100]

// Enable right side hole
cable_right_enable = true;

// Right side hole position (0 = front, 50 = center, 100 = rear)
cable_right_pos_percent = 50; // [0:1:100]

/* [9. Dock Charging - Plug Slot & Strain Relief] */

// Enable dock plug pass-through in the front lip floor
dock_enable = false;

// USB-C plug body width (mm)
dock_plug_w = 12; // [8:0.5:25]

// USB-C plug body height (mm)
dock_plug_h = 8; // [5:0.5:20]

// Dock slot position across the front (0 = left, 50 = center, 100 = right)
dock_pos_percent = 50; // [0:1:100]

// Enable top strain-relief groove behind the lip
dock_relief_enable = true;

// Extra width around the plug for the relief groove (mm)
dock_relief_w = 10; // [4:1:30]

// Relief groove length behind the front lip (mm)
dock_relief_len = 18; // [8:1:50]

// Relief groove depth down from the floor top (mm)
dock_relief_depth = 4; // [2:0.5:10]

/* [10. Under-Base Cable Channel] */

// Enable cable channel carved under the base
under_channel_enable = false;

// Under-base channel width (mm)
under_channel_w = 14; // [6:1:40]

// Under-base channel depth up from the build plate (mm)
under_channel_depth = 5; // [2:0.5:12]

/* [11. Side Cable Clip] */

// Enable spring clip bore on the side wall
clip_enable = false;

// Clip bore diameter matching the cable jacket (mm)
clip_diameter = 6; // [3:0.5:15]

// Clip position along the side (0 = front, 50 = center, 100 = rear)
clip_pos_percent = 50; // [0:1:100]

// Side hosting the clip bore
clip_side = "right"; // [left: Left Wall, right: Right Wall, both: Both Walls]

/* [Hidden] */

// Stacked front lip height derived from floor plus extra lip rise
total_lip_height = base_floor_height + lip_extra_height;

// ==============================================================================
// MODULE WIRING
// ==============================================================================
// --- inlined: modules/core_logic.scad ---
// Derived front lip stack height is owned by main.scad Hidden section.
// This module audits proportions and emits console warnings.

module validate_configuration() {
	assert(base_rear_width > 0, "base_rear_width must be positive");
	assert(base_front_width > 0, "base_front_width must be positive");
	assert(base_total_depth > lip_wall_thickness + pillar_depth, "base_total_depth must exceed lip plus pillar depth");
	assert(base_floor_height > 0, "base_floor_height must be positive");
	assert(backrest_total_height > pocket_bridge_height, "backrest_total_height must exceed pocket_bridge_height");
	assert(total_lip_height > lip_pocket_bridge_height, "total lip height must exceed lip_pocket_bridge_height");
	assert(pillar_width * 2 < base_rear_width, "pillar_width pair must fit inside base_rear_width");
	assert(floor_cut_margin_sides * 2 < base_front_width, "floor side margins must fit inside base_front_width");
	assert(floor_cut_margin_front_rear * 2 < base_total_depth, "floor front/rear margins must fit inside base_total_depth");
	assert(cable_diameter > 0, "cable_diameter must be positive");
	assert(print_tolerance >= 0, "print_tolerance cannot be negative");
	assert(dock_plug_w > 0, "dock_plug_w must be positive");
	assert(dock_plug_h > 0, "dock_plug_h must be positive");
	assert(dock_relief_depth < base_floor_height, "dock_relief_depth must stay inside the floor thickness");
	assert(under_channel_depth < base_floor_height, "under_channel_depth must stay inside the floor thickness");
	assert(clip_diameter > 0, "clip_diameter must be positive");
	if (floor_cut_enable && (base_rear_width - floor_cut_margin_sides * 2) <= 0)
		echo("WARNING: Floor cavity side margins consume the full base width.");
	if (pocket_cut_enable && rear_pocket_width > (base_rear_width - pillar_width * 2))
		echo(str("WARNING: rear_pocket_width exceeds auto-fit span between pillars."));
	if (cable_enable && cable_diameter > pillar_depth)
		echo("WARNING: cable_diameter exceeds pillar_depth, rear bore may break walls.");
	if (dock_enable && dock_plug_h > lip_wall_thickness)
		echo("WARNING: dock_plug_h exceeds lip_wall_thickness, slot may break the front lip.");
	if (under_channel_enable && under_channel_depth > base_floor_height - 3)
		echo("WARNING: under_channel_depth leaves a thin floor skin, risk of warping.");
}

// --- inlined: modules/cutouts/cutouts.scad ---
// --- inlined: base/helpers.scad ---
// 2D trapezoidal footprint with rounded outer corners.
module trapezoid_profile(w_rear, w_front, depth, radius) {
	clamped_radius = max(0.1, radius);
	hull() {
		translate([clamped_radius, depth - clamped_radius])
			circle(r = clamped_radius);
		translate([w_rear - clamped_radius, depth - clamped_radius])
			circle(r = clamped_radius);
		translate([(w_rear - w_front) / 2 + clamped_radius, clamped_radius])
			circle(r = clamped_radius);
		translate([w_rear - (w_rear - w_front) / 2 - clamped_radius, clamped_radius])
			circle(r = clamped_radius);
	}
}

// 2D pocket profile with rounded bottom corners and straight open top.
module rounded_box_2d(w, h, r) {
	cr = min(r, min(w / 2, h));
	hull() {
		translate([cr, cr]) circle(r = cr);
		translate([w - cr, cr]) circle(r = cr);
		translate([0, h - 0.1]) square([w, 0.1]);
	}
}

// --- inlined: pockets.scad ---
module floor_cavity() {
	if (floor_cut_enable) {
		cutout_rear_width = base_rear_width - (floor_cut_margin_sides * 2);
		cutout_front_width = base_front_width - (floor_cut_margin_sides * 2);
		cutout_depth = base_total_depth - (floor_cut_margin_front_rear * 2);
		translate([floor_cut_margin_sides, floor_cut_margin_front_rear, -5])
			linear_extrude(base_floor_height + 20)
				trapezoid_profile(cutout_rear_width, cutout_front_width, cutout_depth, floor_cut_corner_radius);
	}
}

module lip_pocket_cut() {
	if (lip_pocket_enable) {
		cut_h = (total_lip_height - lip_pocket_bridge_height) + 5;
		cut_x = (base_rear_width - lip_pocket_width) / 2;
		translate([cut_x, lip_wall_thickness + 2, lip_pocket_bridge_height])
			rotate([90, 0, 0])
			linear_extrude(lip_wall_thickness + 4)
				rounded_box_2d(lip_pocket_width, cut_h, lip_pocket_corner_radius);
	}
}

module rear_pocket_cut() {
	if (pocket_cut_enable) {
		actual_rear_pocket_width = (rear_pocket_width <= 0) ? (base_rear_width - (pillar_width * 2)) : rear_pocket_width;
		pocket_height = backrest_total_height - pocket_bridge_height + 5;
		pocket_x = (base_rear_width - actual_rear_pocket_width) / 2;
		translate([pocket_x, base_total_depth + 1, pocket_bridge_height])
			rotate([90, 0, 0])
			linear_extrude(pillar_depth + 2)
				rounded_box_2d(actual_rear_pocket_width, pocket_height, pocket_corner_radius);
	}
}

// --- inlined: cable_channels.scad ---
module cable_channels() {
	if (cable_enable) {
		cable_d = cable_diameter + print_tolerance;
		usable_span_rear = base_rear_width - (pillar_width * 2) - cable_d;
		pos_x_rear = pillar_width + (cable_d / 2) + (usable_span_rear * (cable_rear_pos_percent / 100));
		front_x_start = (base_rear_width - base_front_width) / 2;
		usable_span_front = base_front_width - cable_d;
		pos_x_front = front_x_start + (cable_d / 2) + (usable_span_front * (cable_front_pos_percent / 100));
		usable_span_sides = base_total_depth - (floor_cut_margin_front_rear * 2) - cable_d;
		pos_y_left = floor_cut_margin_front_rear + (cable_d / 2) + (usable_span_sides * (cable_left_pos_percent / 100));
		pos_y_right = floor_cut_margin_front_rear + (cable_d / 2) + (usable_span_sides * (cable_right_pos_percent / 100));
		if (cable_rear_enable) {
			translate([pos_x_rear, base_total_depth, cable_center_height])
				rotate([-90, 0, 0])
				cylinder(h = base_total_depth, d = cable_d, center = true);
		}
		if (cable_front_enable) {
			translate([pos_x_front, 0, cable_center_height])
				rotate([-90, 0, 0])
				cylinder(h = base_total_depth, d = cable_d, center = true);
		}
		if (cable_left_enable) {
			intersection() {
				translate([-10, floor_cut_margin_front_rear, -1])
					cube([floor_cut_margin_sides + 20, base_total_depth - (floor_cut_margin_front_rear * 2), base_floor_height + 2]);
				translate([-10, pos_y_left, cable_center_height])
					rotate([0, 90, 0])
					cylinder(h = floor_cut_margin_sides + 30, d = cable_d);
			}
		}
		if (cable_right_enable) {
			intersection() {
				translate([base_rear_width - floor_cut_margin_sides - 10, floor_cut_margin_front_rear, -1])
					cube([floor_cut_margin_sides + 20, base_total_depth - (floor_cut_margin_front_rear * 2), base_floor_height + 2]);
				translate([base_rear_width - floor_cut_margin_sides - 10, pos_y_right, cable_center_height])
					rotate([0, 90, 0])
					cylinder(h = floor_cut_margin_sides + 30, d = cable_d);
			}
		}
	}
}

// --- inlined: charging.scad ---
module dock_plug_slot() {
	if (dock_enable) {
		dock_w = dock_plug_w + print_tolerance;
		dock_h = dock_plug_h + print_tolerance;
		front_x_start = (base_rear_width - base_front_width) / 2;
		dock_x = front_x_start + (base_front_width - dock_w) * (dock_pos_percent / 100);
		translate([dock_x, (lip_wall_thickness - dock_h) / 2, -1])
			cube([dock_w, dock_h, base_floor_height + 2]);
	}
}

module dock_strain_relief() {
	if (dock_enable && dock_relief_enable) {
		relief_w = dock_plug_w + print_tolerance + dock_relief_w;
		front_x_start = (base_rear_width - base_front_width) / 2;
		relief_x = front_x_start + (base_front_width - relief_w) * (dock_pos_percent / 100);
		relief_y0 = lip_wall_thickness + 1;
		translate([relief_x, relief_y0, base_floor_height - dock_relief_depth])
			cube([relief_w, dock_relief_len, dock_relief_depth + 1]);
	}
}

module under_base_channel() {
	if (under_channel_enable) {
		ch_w = under_channel_w + print_tolerance;
		ch_x = (base_rear_width - ch_w) / 2;
		translate([ch_x, -1, -1])
			cube([ch_w, base_total_depth + 2, under_channel_depth + 1]);
	}
}

module side_cable_clip_cut() {
	if (clip_enable) {
		clip_d = clip_diameter + print_tolerance;
		clip_y = floor_cut_margin_front_rear + (base_total_depth - floor_cut_margin_front_rear * 2) * (clip_pos_percent / 100);
		if (clip_side == "left" || clip_side == "both") {
			translate([-1, clip_y, cable_center_height])
				rotate([0, 90, 0])
				cylinder(h = floor_cut_margin_sides + 12, d = clip_d);
		}
		if (clip_side == "right" || clip_side == "both") {
			translate([base_rear_width - floor_cut_margin_sides - 11, clip_y, cable_center_height])
				rotate([0, 90, 0])
				cylinder(h = floor_cut_margin_sides + 12, d = clip_d);
		}
	}
}
// --- inlined: engraving.scad ---
module front_engraving() {
	translate([base_rear_width / 2, engraved_text_depth, (base_floor_height / 2) + 3])
		rotate([90, 0, 0])
		linear_extrude(engraved_text_depth + 0.05)
			text(engraved_text_string, size = engraved_text_size, font = "Arial:style=Bold", halign = "center", valign = "center");
}


// --- inlined: modules/stand_body.scad ---
module stand_solid() {
	union() {
		linear_extrude(base_floor_height)
			trapezoid_profile(base_rear_width, base_front_width, base_total_depth, base_corner_radius);
		linear_extrude(total_lip_height)
			intersection() {
				trapezoid_profile(base_rear_width, base_front_width, base_total_depth, base_corner_radius);
				translate([0, 0]) square([base_rear_width, lip_wall_thickness]);
			}
		linear_extrude(backrest_total_height)
			intersection() {
				trapezoid_profile(base_rear_width, base_front_width, base_total_depth, base_corner_radius);
				translate([0, base_total_depth - pillar_depth]) square([base_rear_width, pillar_depth]);
			}
	}
}

module omni_stand() {
	difference() {
		stand_solid();
		floor_cavity();
		lip_pocket_cut();
		rear_pocket_cut();
		cable_channels();
		dock_plug_slot();
		dock_strain_relief();
		under_base_channel();
		side_cable_clip_cut();
		front_engraving();
	}
}


// ==============================================================================
// VALIDATION & TOP-LEVEL RENDER STAGE
// ==============================================================================
validate_configuration();

if (render_stand)
	color(color_stand)
		omni_stand();

