/// @description Spawn a marble
event_inherited();

if (instance_exists(obj_agility_track))
{
	with (obj_agility_track)
		create_ball(gameControl.movement_points_marble_speed, gameControl.movement_points_marble_rate);
}
