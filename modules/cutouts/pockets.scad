// ==============================================================================
// Omni-Stand - Floor And Backrest Pockets
// @file modules/cutouts/pockets.scad
// Material-saving floor cavity, front lip pocket, rear backrest pocket.
// All profiles centered at origin convention via caller transforms.
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

