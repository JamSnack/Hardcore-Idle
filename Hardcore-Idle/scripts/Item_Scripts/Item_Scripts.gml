function create_item(name, amt, tooltip, sprite, rarity)
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
}
