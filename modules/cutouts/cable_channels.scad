// ==============================================================================
// Omni-Stand - Cable Routing Channels
// @file modules/cutouts/cable_channels.scad
// Configurable rear, front, left and right cable pass-throughs.
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

