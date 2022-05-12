function create_item(name, amt, tooltip, sprite, rarity, type, stats)
{	
	var _item = {
		name : name,
		amt: amt,
		tooltip : tooltip,
		sprite : sprite,
		rarity : rarity,
		type : type,
		stats : stats,
		
		to_string : function()
		{
			return ( string(name) + "\n" + type_to_string(type) + "\n" + rarity_to_string(rarity) + "\n\n" + stats_to_string(stats));
		}
	}
	
	return _item;
}

function generate_item()
{
	//It's build-a-item time! Let's build an item!
	
	//Pick our rarity!
	var _rarity = 0; //common
	
	var _rng = irandom_range(0, 1000000); //One decimal place for every rarity.
	
	if (_rng < 100000) //uncommon
		_rarity++;
		
	if (_rng < 10000) //rare
		_rarity++;
	
	if (_rng < 1000) //epic
		_rarity++;
		
	if (_rng < 100) //grand
		_rarity++;
		
	if (_rng < 10) //resplendent
		_rarity++;
		
	if (_rng == 0) //red
		_rarity++;
		
	show_debug_message("rng is: " + string(_rng) + ", " + rarity_to_string(_rarity) + ", actual value: " + string(_rarity));
		
	
	//Pick our item type!
	var _type = irandom(ITEM_TYPE.none - 1);

	//Sprite time!
	var _sprite = spr_green_marble;
	
	switch (_type)
	{
		case ITEM_TYPE.wep_melee: { _sprite = choose(spr_sword); } break;
		case ITEM_TYPE.ring: { _sprite = choose(spr_ring); } break;
		case ITEM_TYPE.helmet: { _sprite = choose(spr_helmet); } break;
		default: { _sprite = choose(spr_helmet); } break;
	}
	
	//Name the damn thing
	var _name = "";
	
	switch (_type)
	{
		case ITEM_TYPE.wep_melee: { _name += choose("Sword", "Blade", "Sabre"); } break;
		/*case ITEM_TYPE.wep_ranged: { _name += choose("Bow", "Gun", "Crossbow"); } break;
		case ITEM_TYPE.chest: { _name += choose("Bow", "Gun", "Crossbow") } break;
		case ITEM_TYPE.gloves: { return "Gloves"; } break;
		case ITEM_TYPE.helmet: { return "Helmet"; } break;
		case ITEM_TYPE.necklace: { return "Necklace"; } break;
		case ITEM_TYPE.ring: { return "Ring"; } break;
		case ITEM_TYPE.shoes: { return "Shoes"; } break;
		*/
		default: { _name += (choose("Drake of ", "Snake Miner's ", "Average Joe's ", "The Logarithm of ") + type_to_string(_type) ); }
	}
	
	//Stats
	var _stats = ds_map_create();
	var agil_pool = false;
	var fort_pool = false;
	var damage_pool = false;
	
	switch (_type)
	{
		case ITEM_TYPE.necklace:
		case ITEM_TYPE.ring: { fort_pool = true; agil_pool = true; } break;
		
		case ITEM_TYPE.gloves:
		case ITEM_TYPE.shoes: { agil_pool = true; } break;
		
		case ITEM_TYPE.helmet:
		case ITEM_TYPE.chest: { fort_pool = true; } break;
		
		case ITEM_TYPE.wep_ranged: //In the future, make ranged weapons do ranged damage
		case ITEM_TYPE.wep_melee: { damage_pool = true; } break;
		default: { _sprite = choose(spr_helmet); } break;
	}
	
	var _breaker = 0;
	while( ds_map_size(_stats) < (_rarity+1) || _breaker > 10)
	{	
		_breaker++;
		
		if (damage_pool) { ds_map_add(_stats, "Damage", gameControl.game_turn_amt/4 + _rarity*gameControl.game_environment_difficulty); }
		
		if (agil_pool) 
		{ 
			var _sk = irandom(2);
			
			switch (_sk)
			{
				case 0: { ds_map_add(_stats, "Max Action Points", _rarity+1); } break;
				case 1: { ds_map_add(_stats, "Marble Value", (_rarity+1)*0.01); } break;
				case 2: { ds_map_add(_stats, "Marble Speed", (_rarity+1)*0.1); } break;
			}
		};
		
		if (fort_pool) 
		{ 
			var _sk = irandom(3);

			switch (_sk)
			{
				case 0: { ds_map_add(_stats, "Max HP", _rarity+1) } break;
				case 1: { ds_map_add(_stats, "Fill Amount", (_rarity+1)*0.01) } break;
				case 2: { ds_map_add(_stats, "Regeneration Speed", (_rarity+1)*5) } break; //liquid drain speed
				case 3: { ds_map_add(_stats, "Max Liquid", (_rarity+1)*0.01) } break;
			}
		};
	}
	
	show_debug_message(string(ds_map_find_first(_stats)));
	
	//Blend it all together!
	return create_item(_name, 1, "", _sprite, _rarity, _type, _stats);
}


function find_item(item_struct)
{
	if (is_struct(item_struct))
	{
		var _name = item_struct.name;
		var _list_size = ds_list_size(global.inventory);
	
		if (_list_size > 0)
		{
			for (var _index = 0; _index < _list_size; _index++)
			{
				var _it = global.inventory[| _index];
		
				if (_it.name == _name && _it.type == item_struct.type && _it.rarity == item_struct.rarity)
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
	
	//notify the player
	obj_button_inventory.draw_notification = true;
}

function remove_item(item_struct, amt)
{
	/*
	var _result = find_item(item_struct);
	
	//If we find it, remove it
	if (_result != -1)
	{
		global.inventory[| _result].amt -= amt;
				
		if (global.inventory[| _result].amt <= 0)
			clear_slot(_result);	
	}
	*/
}

function drop_item(x, y, item_struct)
{
	var _item = instance_create_layer(x, y, "UI_Effects", efct_item);
	_item.item = item_struct;
}

function rarity_to_string(rarity)
{
	switch (rarity)
	{
		case ITEM_RARITY.common: { return "Common"; } break;
		case ITEM_RARITY.uncommon: { return "Uncommon"; } break;
		case ITEM_RARITY.rare: { return "Rare"; } break;
		case ITEM_RARITY.epic: { return "Epic"; } break;
		case ITEM_RARITY.grand: { return "Grand"; } break;
		case ITEM_RARITY.resplendent: { return "Resplendent"; } break;
		case ITEM_RARITY.red: { return "Red"; } break;
		default: { return "Cursed"; } break;
	}
}

function type_to_string(type)
{
	switch (type)
	{
		case ITEM_TYPE.wep_melee: { return "Melee"; } break;
		case ITEM_TYPE.wep_ranged: { return "Ranged"; } break;
		case ITEM_TYPE.chest: { return "Chestplate"; } break;
		case ITEM_TYPE.gloves: { return "Gloves"; } break;
		case ITEM_TYPE.helmet: { return "Helmet"; } break;
		case ITEM_TYPE.necklace: { return "Necklace"; } break;
		case ITEM_TYPE.ring: { return "Ring"; } break;
		case ITEM_TYPE.shoes: { return "Shoes"; } break;
	}	
}

function stats_to_string(stats)
{
	if (ds_exists(stats, ds_type_map))
	{
		//show_debug_message(string(ds_map_find_first(stats)));
		var _keys = ds_map_keys_to_array(stats);
		var _str = "";
		
		for (var _z = 0; _z < array_length(_keys); _z++)
		{
			var _key = _keys[_z];
			_str += string(_key) + " +" + string(stats[? _key]) + "\n";
		}
		
		return _str;
	}
	else return "Empty!";
}

function apply_stats()
{
	with (gameControl)
	{
		//Reset the bonuses
		reset_bonuses();
			
		//Add to the bonuses
		//for every equipped item, for every bonus, add their stats to the appropriate variables.
		for (var _x = 0; _x < 8; _x++)
		{
			var current_equipment = -1;
				
			//select proper equipment
			switch (_x)
			{
				case 0: { current_equipment = equip_melee; }; break;
				case 1: { current_equipment = equip_chest; }; break;
				case 2: { current_equipment = equip_gloves; }; break;
				case 3: { current_equipment = equip_helmet; }; break;
				case 4: { current_equipment = equip_necklace; }; break;
				case 5: { current_equipment = equip_ranged; }; break;
				case 6: { current_equipment = equip_ring; }; break;
				case 7: { current_equipment = equip_shoes; }; break;
			}
				
			//add its bonuses
			if (current_equipment != -1)
			{
				var stats = current_equipment.stats;
	
				if (ds_exists(stats, ds_type_map))
				{
					
					var _keys = ds_map_keys_to_array(stats);
					
					for (var _z = 0; _z < array_length(_keys); _z++)
					{
						var key = _keys[_z];
			
						switch (key)
						{
							//Agility
							case "Max Action Points": { bonus_movement_points_max += stats[? key]; } break;
							case "Marble Value": { bonus_movement_points_marble_rate += stats[? key]; } break;
							case "Marble Speed": { bonus_movement_points_marble_speed += stats[? key]; } break;
							
							//Fortitude
							case "Max HP": { bonus_health_points_max += stats[? key]; } break;
							case "Fill Amount": { bonus_health_points_rate += stats[? key]; } break;
							case "Regeneration Speed": { bonus_health_points_speed += stats[? key]; } break;
							case "Max Liquid": { bonus_health_points_liquid_max += stats[? key]; } break;
						}
					}
				}
			}
		}
	}
}

function clear_slot(slot)
{
	//Properly dispose of the contents of an inventory slot. For use inside gameControl.
	delete global.inventory[| slot]; //delete item struct
	ds_list_delete(global.inventory, slot); //remove index
}
