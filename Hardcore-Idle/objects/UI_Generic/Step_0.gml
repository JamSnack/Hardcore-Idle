/// @description Check for interaction

//Visibility
visible = (gameControl.menu_section == menu_section || (gameControl.menu_section != MENU.main && menu_section == MENU.not_main) || (gameControl.inventory_open && menu_section == MENU.inventory)) ? true : false;

if (!visible)
	exit;
