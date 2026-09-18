// ==============================================================================
// Omni-Stand - Core Logic Registry
// @file modules/core_logic.scad
// Derived dimensions, configuration validation, collision audit.
// Copyright (C) 2026 Camiu (https://github.com/camiu01)
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// No top-level executable statements. Bodies use TABS for indentation.
// ==============================================================================

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

