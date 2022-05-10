/// @description Approach balls
event_inherited();

for (var _i = 0; _i < ds_list_size(balls); _i++)
{
	var _ball = balls[| _i];	
	_ball.distance += _ball.spd;
	
	if (_ball.distance >= 99)
	{
		//This ball completed the track!
		ds_list_delete(balls, _i);
		
		gameControl.movement_points += _ball.val;
		
		if (visible == true)
			create_pop_text(x - sprite_width/2 + irandom(sprite_width), y - sprite_height/2 + irandom(sprite_height), c_green, c_black, 1, "+" + string(_ball.val));
	}
}
