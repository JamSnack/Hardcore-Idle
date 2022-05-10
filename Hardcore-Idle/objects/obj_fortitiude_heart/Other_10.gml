/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

liquid_filling += gameControl.health_points_rate;

if (liquid_filling > liquid_filling_max)
	liquid_filling = liquid_filling_max;
	
show_debug_message(string(liquid_filling));

