function create_item(name, amt, tooltip, sprite, rarity, type)
{
	var _item = {
		name : name,
		amt: amt,
		tooltip : tooltip,
		sprite : sprite,
		rarity : rarity,
		type : type,
		stats : ds_list_create(),
		
		to_string : function()
		{
			return string(name) + "\n" + type_to_string(type) + "\n" + rarity_to_string(rarity) + "\n\n" + string(tooltip);	
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
	
	//Blend it all together!
	return create_item(_name, 1, "", _sprite, _rarity, _type);
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

function clear_slot()
{
	//Properly dispose of the contents of an inventory slot. For use inside gameControl.
}
