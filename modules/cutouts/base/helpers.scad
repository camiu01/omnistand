// ==============================================================================
// Omni-Stand - Cutout Base Helpers
// @file modules/cutouts/base/helpers.scad
// Shared 2D primitives for base extrusion and pocket cutouts.
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

