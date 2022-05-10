/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
if (gameControl.skill_points > 0)
	visible = true;
else 
{
	visible = false;
	exit;
}

event_inherited();
