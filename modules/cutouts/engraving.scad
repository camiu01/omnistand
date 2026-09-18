// ==============================================================================
// Omni-Stand - Front Engraving
// @file modules/cutouts/engraving.scad
// Recessed front face text. Requires globals from main.scad.
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

module front_engraving() {
	translate([base_rear_width / 2, engraved_text_depth, (base_floor_height / 2) + 3])
		rotate([90, 0, 0])
		linear_extrude(engraved_text_depth + 0.05)
			text(engraved_text_string, size = engraved_text_size, font = "Arial:style=Bold", halign = "center", valign = "center");
}

