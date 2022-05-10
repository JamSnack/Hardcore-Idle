/// @description Upgrade something
event_inherited();

with (gameControl)
{
	switch (other.upgrade)
	{
		case "marble_rate": { movement_points_marble_rate += 0.01; } break;
		case "marble_speed": { movement_points_marble_speed += 0.1; } break;
		case "marble_clickers": { movement_points_auto += 1; } break;
		case "movement_points_max": { movement_points_max += 1; } break;
	}
	
	skill_points -= 1;
}

