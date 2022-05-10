/// @description Init

//- init skills
movement_points_max = 1;
movement_points = movement_points_max;
movement_points_marble_rate = 0.01;
movement_points_marble_speed = 0.1;
movement_points_auto = 0;
health_points_max = 1;
health_points = health_points_max;
damage_points = 1; //how much damage we doin'?

//- init levels and XP
xp = 0;
xp_max = 8;
level = 1;
skill_points = 0;


//- init inventory
inventory = ds_list_create();

//Game control stuff
enum TURN
{
	player,
	enemy,
	environment
}

game_turn = TURN.player;
game_turn_amt = 0;
can_move = true;

cell_size = 32;
surface_movement_grid = noone;

game_map_x1 = 33;
game_map_y1 = 33;
game_map_x2 = floor(room_width/2) - 12 + 64;
game_map_y2 = room_height - 33;

game_turn_time = room_speed*60;
game_turn_enemy_index = 0;

grid_color = c_white;
target_color = c_black;

game_environment_difficulty = 1;

//Menu init
enum MENU
{
	main,
	not_main,
	skill_agility
}

menu_section = MENU.main;

cursor_text = "";

//Functions
function get_turn_name(game_turn)
{
	switch (game_turn)
	{
		case TURN.player: { return "Player"; } break;
		case TURN.enemy: { return "Enemy"; } break;
		case TURN.environment: { return "Environment"; } break;
	}
}

function give_xp(amt)
{
	xp += amt;
	create_pop_text(obj_player.x, obj_player.y-8, c_purple, c_black, 1, "+" + string(amt));
	
	if (xp >= xp_max)
	{
		
		//add xp and level up
		xp = xp - xp_max;
		level++;
		
		//new xp_max and skill point
		xp_max = round(xp_max*(level/2 + level-1));
		skill_points += 1;
		
		//level-up effects
		create_pop_text(obj_player.x, obj_player.y-10, c_yellow, c_black, 1, "Level Up!");
	}
}
