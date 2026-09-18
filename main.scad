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
include <modules/core_logic.scad>
include <modules/cutouts/cutouts.scad>
include <modules/stand_body.scad>

// ==============================================================================
// VALIDATION & TOP-LEVEL RENDER STAGE
// ==============================================================================
validate_configuration();

if (render_stand)
	color(color_stand)
		omni_stand();

