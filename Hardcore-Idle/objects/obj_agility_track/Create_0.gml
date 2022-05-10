/// @description
event_inherited();
menu_section = MENU.skill_agility;

balls = ds_list_create();

function create_ball(speed, value)
{
	ball = { distance : 0, spd : speed, val : value };
	
	ds_list_add(balls, ball);
}
