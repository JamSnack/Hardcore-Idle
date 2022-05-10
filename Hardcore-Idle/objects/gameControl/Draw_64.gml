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
}

//Draw tooltip
if (cursor_text != "")
{
	draw_set_halign(fa_center);
	var _w =  string_width(cursor_text)/2 + 4;
	var _h_offset = 13; //Position the tooltip under the cursor so that it's always readable.
	var _h = string_height(cursor_text) + 10 + _h_offset;

	draw_rectangle_color(mouse_x - _w, mouse_y + _h_offset, mouse_x + _w, mouse_y + _h, c_black, c_black, c_black, c_black, false);
	draw_rectangle_color(mouse_x - _w, mouse_y + _h_offset, mouse_x + _w, mouse_y + _h, c_white, c_white, c_white, c_white, true)
	draw_text_outlined(mouse_x, mouse_y + 8 + _h_offset, c_black, c_white, cursor_text);
	
	draw_set_halign(fa_left);
}
