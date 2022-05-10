/// @description Game Turn Calculation

var x_mouse = floor(mouse_x/cell_size)*cell_size + 16;
var y_mouse = floor(mouse_y/cell_size)*cell_size + 16;

var gui_x_mouse = device_mouse_x_to_gui(0);
var gui_y_mouse = device_mouse_y_to_gui(0);

var mouse_in_game_map = (point_in_rectangle(gui_x_mouse, gui_y_mouse, game_map_x1, game_map_y1, game_map_x2, game_map_y2) == true ) ? true : false;

//----------Turn controller-------

switch (game_turn)
{
	case TURN.player:
	{
		//It's the player's turn!
		game_turn_amt++;
		target_color = c_black;
		
		//- can we move?
		var _d = point_distance(obj_player.x, obj_player.y, x_mouse, y_mouse);
		var _col = collision_point(x_mouse, y_mouse, OBSTA, false, true);
		
		if (movement_points >= 1 && _d <= cell_size && _d > 1 && point_in_rectangle(x_mouse, y_mouse, game_map_x1, game_map_y1, game_map_x2, game_map_y2) && _col == noone)
		{
			can_move = true;
		}
		else can_move = false;
		
		
		//Mouse actions
		if (movement_points >= 1 && mouse_check_button_released(mb_left))
		{
			//- attack an enemy if we can
			if (_col != noone && _col.object_index != obj_player && _d <= 33)
			{
				movement_points -= 1;
			
				with (_col)
				{
					hp -= other.damage_points;
					event_user(1); //check for death event
				}
			}
		
			//- move if can.
			else if (can_move)
			{
				movement_points -= 1;
			
				obj_player.x = x_mouse;
				obj_player.y = y_mouse;
				
				give_xp(4);
			}
		}
		
		//Timer stuff
		if (game_turn_time <= 0 || keyboard_check_released(vk_space))
		{
			game_turn = TURN.enemy;
			enemy_turn_timer = 45;
			game_turn_time = 0;
		}
	}
	break;
	
	case TURN.enemy:
	{
		target_color = c_red;
		
		if (enemy_turn_timer <= 0)
		{
			if (game_turn_enemy_index == instance_number(ENEMY))
			{
				game_turn = TURN.environment;
			}
			else if (game_turn_enemy_index < instance_number(ENEMY))
			{
				with (instance_find(ENEMY, game_turn_enemy_index))
					event_user(0);
					
				game_turn_enemy_index++;
			}
			
			enemy_turn_timer = round(30/instance_number(ENEMY));
		}
		
		enemy_turn_timer--;
	}
	break;
	
	case TURN.environment:
	{
		if (instance_number(ENEMY) < game_turn_amt)//(instance_number(ENEMY) < game_environment_difficulty)
		{
			instance_create_layer(choose(0, game_map_x2)+16, choose(0, game_map_y2)+16, "Instances", obj_enemy);	
		}
		
		//We've gone through all the enemies, next turn!
		game_turn = TURN.player;
		game_turn_enemy_index = 0;
		game_turn_time = 20*room_speed;
	}
	break;
}


//Change grid color
if (grid_color != target_color)
{
	surface_free(surface_movement_grid);
	var _r = approach(color_get_red(grid_color), color_get_red(target_color), 8);
	var _g = approach(color_get_green(grid_color), color_get_green(target_color), 8);
	var _b = approach(color_get_blue(grid_color), color_get_blue(target_color), 8);
	
	grid_color = make_color_rgb(_r, _g, _b);
	
	surface_free(surface_movement_grid);
}

//Decrement timer.... sad little timer ;(
if (game_turn == TURN.player)
	game_turn_time -= 1;


//-----Cursor stuff-----
if (window_get_cursor() == cr_drag)
{
	var _reset = true;
	
	with (UI_Button)
	{
		if (visible == true && point_in_rectangle(gui_x_mouse, gui_y_mouse, x, y, x + sprite_width, y + sprite_height))
		{
			_reset = false;
			break;
		}
	}
	
	if (_reset)
		window_set_cursor(cr_default);
}

//- Cursor Text
if (instance_exists(OBSTA) && mouse_in_game_map)
{
	var c_col = collision_point(mouse_x, mouse_y, OBSTA, false, true);
	
	if (c_col != noone)
	{
		cursor_text = c_col.to_string();
	}
	else cursor_text = "";
}
else if (instance_exists(UI_Button))
{
	var c_list = ds_list_create();
	var c_col = collision_point_list(mouse_x, mouse_y, UI_Button, false, true, c_list, false);
	
	if (c_col > 0)
	{
		for (var _c = 0; _c < c_col; _c++)
		{
			var _button = c_list[| _c];
			
			if (_button.visible == true)
			{
				cursor_text = _button.to_string();
				break;
			}
			
			if (_c+1 == c_col)
				cursor_text = "";
		}
	}
	else cursor_text = "";
}


	
//------IDLE STUFF-------
// - movement points
if (movement_points > movement_points_max) { movement_points = movement_points_max; }

var is_tick = (game_turn == TURN.player && game_turn_time mod 60 == 0) ? true : false;

if (game_turn == TURN.player && game_turn_time mod floor(60/movement_points_auto) == 0)
{
	with (obj_button_agility_clicker)
		event_user(0);
}
