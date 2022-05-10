/// @description Check for interaction

//Visibility
visible = (gameControl.menu_section == menu_section || (gameControl.menu_section != MENU.main && menu_section == MENU.not_main)) ? true : false;

if (!visible || click_delay > 0)
{
	click_delay--;
	exit;
}

var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

if (point_in_rectangle(mouse_gui_x, mouse_gui_y, x, y, x+sprite_width, y+sprite_height))
{
	image_index = 1; //Highlighted frame
	
	window_set_cursor(cr_drag);
	
	if (mouse_check_button(mb_left))
	{
		image_index = 2; //Pressed frame
	}
	else if (mouse_check_button_released(mb_left))
	{
		//Execute the on_interaction event.
		event_user(0);
	}
}
else image_index = 0; //Normal frame
