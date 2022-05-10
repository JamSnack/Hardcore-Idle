/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

locked = true;
unlocked_at = 2;

function to_string()
{
	
	if (locked)
		return "Fortitude\nUnlocked at Level " + string(unlocked_at) + ".";
	else return "Fortitude";	
}
