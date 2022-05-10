/// @description Upgrade something
event_inherited();

with (gameControl)
{
	if (skill_points > 0)
	{
		switch (other.upgrade)
		{
			//Agility upgrades
			case "marble_rate": { movement_points_marble_rate += 0.01; } break;
			case "marble_speed": { movement_points_marble_speed += 0.1; } break;
			case "marble_clickers": { movement_points_auto += 1; } break;
			case "movement_points_max": { movement_points_max += 1; } break;
		
			//Fortitude upgrades
			case "liquid_amt": { health_points_rate += 0.1; } break;
			case "liquid_speed": { health_points_speed -= 10; } break;
			case "max_health": { health_points_max += 1; } break;
			case "max_liquid": { health_points_liquid_max += 0.1; } break;
		}
	
		skill_points -= 1;
	}
}

