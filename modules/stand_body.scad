// ==============================================================================
// Omni-Stand - Chassis And Assembly
// @file modules/stand_body.scad
// Base extrusion, front lip, rear pillars, subtractive cutout wiring.
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

