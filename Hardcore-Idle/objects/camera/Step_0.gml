/// @description Insert description here
if (instance_exists(follow_this))
{
	var follow_x = follow_this.x;
	var follow_y = follow_this.y;
	
	if (distance_to_object(follow_this) <= 0.5)
	{
		x = follow_x;
		y = follow_y;
	}
	else
	{
		var _spd = 3;
		
		if ((x - follow_x) >= 0)
		{
			x -= _spd;	
		}
		else x += _spd;
		
		if ((y - follow_y) >= 0)
		{
			y -= _spd;	
		}
		else y += _spd;
	}
}


//Update view
camera_set_view_pos(current_cam, round(x - view_wport[0]/2), round(y - view_hport[0]/2));


