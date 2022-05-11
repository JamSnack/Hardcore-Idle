/// @description Init
show_debug_overlay(true);

//- init skills
movement_points_max = 1;
movement_points = movement_points_max;
movement_points_marble_rate = 0.01;
movement_points_marble_speed = 0.1;
movement_points_auto = 0;
health_points_max = 1;
health_points_rate = 0.1;
health_points_speed = 180;
health_points_liquid_max = 1;
health_points = 1;
damage_points = 1; //how much damage we doin'?

//- init levels and XP
xp = 0;
xp_max = 8;
level = 1;
skill_points = 0;


//- init inventory
global.inventory = ds_list_create();
inventory_open = false;
inventory_animation = 0; //approaches 1 or 0 when inventory is opened or shuts
selected_slot = -1;

equip_melee = -1;
equip_ranged = -1;
equip_helmet = -1;
equip_chest = -1;
equip_gloves = -1;
equip_ring = -1;
equip_shoes = -1;
equip_necklace = -1;

enum ITEM_RARITY
{
	common, //1%
	uncommon, //0.1%
	rare, //0.01%
	epic, //0.001%
	grand, //0.0001%
	resplendent, //0.00001%
	red //0%
}

enum ITEM_TYPE
{
	wep_ranged,
	wep_melee,
	helmet,
	chest,
	gloves,
	ring,
	shoes,
	necklace,
	none
}

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
	inventory,
	skill_agility,
	skill_fortitude
}

menu_section = MENU.main;
menu_section_2 = MENU.main;

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
	
	while (xp >= xp_max)
	{
		
		//add xp and level up
		xp = xp - xp_max;
		level++;
		
		//new xp_max and skill point
		xp_max = round(xp_max*(level/2 + level-1));
		skill_points += 1;
		
		//level-up effects
		create_pop_text(obj_player.x, obj_player.y, c_yellow, c_black, 1, "Level Up!");
	}
}


slot_size = sprite_get_width(spr_slot);

function draw_equip_slot(equip_struct, x, y, alpha, image_index, scale, type)
{	
	var _ct = type_to_string(type) + " Slot";; //cursor text type
	var _cd = "Empty"; //Cursor text item description
	
	//Draw the slot
	if (equip_struct != -1)
	{ 
		draw_sprite_ext(spr_slot, equip_struct.rarity, x, y, scale, scale, 0, c_white, alpha);
		draw_sprite(equip_struct.sprite, 0, x + (slot_size/2)*scale, y + (slot_size/2)*scale);
		
		_cd = equip_struct.to_string();
	}
	else
	{
		draw_sprite_ext(spr_slot, 0, x, y, scale, scale, 0, c_white, alpha);
	}
	
	//Draw the highlight
	if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + (slot_size)*scale, y + (slot_size)*scale))
	{
		draw_sprite_ext(spr_highlight, 0, x, y, scale, scale, 0, c_white, 1);
		
		cursor_text = _ct + "\n" + _cd;
	}
}

function check_equip_slot(equip_struct, x, y, scale, type)
{	
	var return_this = equip_struct;
	
	//If an item is in the slot...

	if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, x + (slot_size)*scale, y + (slot_size)*scale))
	{
		if (equip_struct != -1)
		{ 
			return_this = -1;
		}
		else if (selected_slot != -1)
		{
			var _ite = global.inventory[| selected_slot];
			
			if (_ite.type == type)
				return_this = _ite;
		}
	}
	
	delete equip_struct;
	return return_this;
}

/*function create_item(name, amt, tooltip, sprite, rarity)
{
	var _item = {
		name : name,
		amt: amt,
		tooltip : tooltip,
		sprite : sprite,
		rarity : rarity
	}
	
	return _item;
}

function find_item(item_struct)
{
	var _name = item_struct.name;
	var _list_size = ds_list_size(global.inventory);
	
	if (_list_size > 0)
	{
		for (var _index = 0; _index < _list_size; _index++)
		{
			var _it = global.inventory[| _index];
		
			if (_it.name == _name)
			{
				return _index;
			}
		
			if (_index + 1 == _list_size)
			{
				return -1;	
			}
		}
	} else return -1;
}

function add_item(item_struct)
{
	var _result = find_item(item_struct);
	//show_debug_message("result is: "+string(_result));
	
	if (_result == -1)
	{
		ds_list_add(global.inventory, item_struct);
	}
	else if (_result != -1)
	{
		global.inventory[| _result].amt += item_struct.amt;
	}
}

function drop_item(x, y, item_struct)
{
	var _item = instance_create_layer(x, y, "UI_Effects", efct_item);
	_item.item = item_struct;
}*/

//give_xp(1000);
