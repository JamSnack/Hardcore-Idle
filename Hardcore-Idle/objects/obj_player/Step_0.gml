/// @description Step

//if we have a target, move toward it
if (x != target_x || y != target_y)
{
	image_speed = anim_speed;
	
	x = approach(x, target_x, 2);
	y = approach(y, target_y, 2);
}
else
{
	if (image_index mod 2 == 0)
	{
		image_index = 0;
		image_speed = 0;
	}
	
	//Pick our sprite
	var _facing = point_direction(x, y, mouse_x, mouse_y);
	
	if (_facing > 0 && _facing < 60) || (_facing > 315 && _facing <= 359)
	{
		//West
		sprite_index = spr_player_side;
		image_xscale = -scale;
	}
	else if (_facing >= 60 && _facing < 120)
	{
		//North
		sprite_index = spr_player_front;
	}
	else if (_facing >= 120 && _facing < 225)
	{
		//North
		sprite_index = spr_player_front;
	}
}
