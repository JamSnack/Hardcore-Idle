/// @description Turn Event

//First, check for death
event_user(1);

//Movement stuff
var tx = target.x;
var ty = target.y;
var _dam = damage; //local var passthrough


//Move! Go!
if (tx < x && collision_point(x-32, y, OBSTA, false, true) == noone)
	x -= 32;
else if (tx > x && collision_point(x+32, y, OBSTA, false, true) == noone)
	x += 32;
else if (ty < y && collision_point(x, y-32, OBSTA, false, true) == noone)
	y -= 32;
else if (ty > y && collision_point(x, y+32, OBSTA, false, true) == noone)
	y += 32;
else if (distance_to_object(target) < 32)
{
	show_debug_message(object_get_name(object_index)+" attacked!");
	//The target is nearby! Attack!
	with (gameControl)
		health_points -= _dam;
}
