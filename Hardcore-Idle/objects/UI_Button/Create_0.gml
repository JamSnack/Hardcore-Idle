/// @description Init
menu_section = MENU.main;

click_delay = 0;

upgrade = noone;

function to_string()
{
	//Does nothing!	
	return "";
}

locked = false;
unlocked_at = 2; //What level is this unlocked at?
hold_to_click = false;
menu_section_2_button = false; //Whether or not the button is located in menu_section_2
draw_notification = false; //Whether or not to draw the exclamation mark in the top-left corner.
