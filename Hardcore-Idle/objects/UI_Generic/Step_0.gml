/// @description Check for interaction

//Visibility
visible = (gameControl.menu_section == menu_section || (gameControl.menu_section != MENU.main && menu_section == MENU.not_main)) ? true : false;

if (!visible)
	exit;
