/// @description Spawn a marble
event_inherited();

if (global.game_over == false && instance_exists(obj_agility_track))
{
	with (obj_agility_track)
		create_ball(gameControl.movement_points_marble_speed + gameControl.bonus_movement_points_marble_speed, gameControl.movement_points_marble_rate + gameControl.bonus_movement_points_marble_rate);
}
