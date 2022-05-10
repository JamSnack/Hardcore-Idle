/// @description Insert description here
// You can write your code in this editor
with (gameControl)
	if (!inventory_open)
	{
		menu_section = MENU.main;
		menu_section_2 = MENU.main;
	}
	else
	{
		inventory_open = false;
		menu_section_2 = MENU.main;
	}

