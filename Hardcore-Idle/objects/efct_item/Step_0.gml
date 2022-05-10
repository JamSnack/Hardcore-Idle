/// @description Insert description here
// You can write your code in this editor
//fly_speed += 0.01;
var t_dir = point_direction(x, y, obj_button_inventory.x, obj_button_inventory.y);

if (dir+speed < t_dir)
{
	dir += speed;
}
else if (dir-speed > t_dir)
{
	dir -= speed;
}

if (speed > 10)
{
	speed = 10;
	dir = t_dir
}

motion_add(dir, fly_speed);

//Add item
if (distance_to_object(obj_button_inventory) <= 32)
{
	//add
	add_item(item);
	
	//effects
	
	//destroy
	instance_destroy();
}
