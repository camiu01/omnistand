// ==============================================================================
// Omni-Stand - Dock Charging And Cable Management
// @file modules/cutouts/charging.scad
// USB-C dock plug slot, top strain-relief groove, under-base cable channel.
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
