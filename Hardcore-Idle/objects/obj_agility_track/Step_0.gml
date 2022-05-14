/// @description Approach balls
event_inherited();

var _s = ds_list_size(balls);

if (_s > 0)
{
	for (var _i = 0; _i < _s; _i++)
	{
		var _ball = balls[| _i];	
		_ball.distance += _ball.spd;
	
		if (_ball.distance >= 99)
		{
			//This ball completed the track!
			ds_list_delete(balls, _i);
			_s--; //this makes it work b/c ds_list_size needs to be dynamic but we only want to call the function once
		
			if (global.game_over == false)
			{
				gameControl.movement_points += _ball.val;
		
				if (visible == true)
					create_pop_text(x - sprite_width/2 + irandom(sprite_width), y - sprite_height/2 + irandom(sprite_height), c_green, c_black, 1, "+" + string(_ball.val));
			}
			
			delete _ball;
		}
	}
}
