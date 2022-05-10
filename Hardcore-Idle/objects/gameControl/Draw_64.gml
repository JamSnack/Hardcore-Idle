/// @description Insert description here
// You can write your code in this editor
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

//Draw UI
//draw_sprite(spr_game_ui, 0, 0, 0);

//Draw UI Text
draw_set_font(fnt_main);

draw_text_outlined(32, 8, c_black, c_white, "Turn: " + get_turn_name(game_turn));
draw_text_outlined(128, 8, c_black, c_white, "Time Left: " + string(floor(game_turn_time/room_speed)) );
draw_text_outlined(456, 8, c_black, c_white, "Action Points: " + string(movement_points) + "/" + string(movement_points_max) );
draw_text_outlined(750, 8, c_black, c_white, "Skill Points: " + string(skill_points) );

draw_text_outlined(32, 748, c_black, c_white, "Health: " + string(health_points) + "/" + string(health_points_max) );
draw_text_outlined(290, 748, c_black, c_white, "XP: " + string(xp) + "/" + string(xp_max));
draw_text_outlined(456, 748, c_black, c_white, "Level: " + string(level) );


//Draw menu stuff
switch (menu_section)
{
	case MENU.skill_agility:
	{
		draw_text_outlined(780, 40, c_black, c_white, "Marble Value: " + string(movement_points_marble_rate));
		draw_text_outlined(780, 57, c_black, c_white, "Marble Speed: " + string(movement_points_marble_speed));
		draw_text_outlined(780, 74, c_black, c_white, "Auto-Clickers: " + string(movement_points_auto));
		draw_text_outlined(780, 91, c_black, c_white, "Max Action Points: " + string(movement_points_max));
	}
	break;
	
	case MENU.skill_fortitude:
	{
		draw_text_outlined(780, 40, c_black, c_white, "Fill Amount: " + string(health_points_rate));
		draw_text_outlined(780, 57, c_black, c_white, "Regeneration Delay: " + string(health_points_speed));
		draw_text_outlined(780, 74, c_black, c_white, "Max Health: " + string(health_points_max));
		draw_text_outlined(780, 91, c_black, c_white, "Max Liquid: " + string(health_points_liquid_max));
	}
	break;
}

//Draw inventory
if (inventory_open)
{
	//Draw background
	draw_set_alpha(inventory_animation/1.3);
	draw_set_color(c_black);
	draw_rectangle(game_map_x1, game_map_y1, game_map_x2, game_map_y2, false);
	draw_set_alpha(inventory_animation);
	
	//Draw title
	draw_set_halign(fa_center);
	draw_text_outlined_transformed(game_map_x2/2 + game_map_x1, 30, c_black, c_white, "inventory", 3, 3, 0);
	
	//Draw contents
	var _size = ds_list_size(global.inventory);
	var slots_per_row = 18;
	
	if (_size > 0)
	{
		for (var _i = 0; _i < _size; _i++)
		{
			var space = 38;
			var _column = space*floor(_i/slots_per_row);
			var _x = (game_map_x1 + 10) + space*_i - (_column*slots_per_row);
			var _y = (game_map_y1 + 50) + _column;
			var _item = global.inventory[| _i];
			var _item_sprite = _item.sprite;
			
			draw_sprite(spr_slot, 0, _x, _y);
			draw_sprite(_item_sprite, 0, _x + 16, _y + 16);
			draw_text_outlined_transformed(_x+25, _y+22, c_black, c_white, string(_item.amt), 0.7, 0.7, 0);
			
			//Apply tooltip
			if (point_in_rectangle(mouse_x, mouse_y, _x, _y, _x + 32, _y + 32))
			{
				cursor_text = (_item.name + "\n" + _item.tooltip);
			}
		}
	}
	else draw_text_outlined(game_map_x2/2 + game_map_x1, gui_height/2, c_black, c_white, "Empty.");
	
	draw_set_halign(fa_left);
	draw_set_alpha(1);
}

//Draw tooltip
if (cursor_text != "")
{
	draw_set_halign(fa_center);
	var _w =  string_width(cursor_text)/2 + 4;
	var _h_offset = 13; //Position the tooltip under the cursor so that it's always readable.
	var _h = string_height(cursor_text) + 10 + _h_offset;
	var _w_offset = 0;
	
	//Correct spacing
	if (mouse_x - _w) < 0 
	{
		_w_offset = (_w - mouse_x);
	}
	else if (mouse_x + _w) > room_width
	{
		_w_offset = (mouse_x - _w);
	}

	draw_rectangle_color(_w_offset + mouse_x - _w, mouse_y + _h_offset, _w_offset + mouse_x + _w, mouse_y + _h, c_black, c_black, c_black, c_black, false);
	draw_rectangle_color(_w_offset + mouse_x - _w, mouse_y + _h_offset, _w_offset + mouse_x + _w, mouse_y + _h, c_white, c_white, c_white, c_white, true)
	draw_text_outlined(_w_offset + mouse_x, mouse_y + 8 + _h_offset, c_black, c_white, cursor_text);
	
	draw_set_halign(fa_left);
}
