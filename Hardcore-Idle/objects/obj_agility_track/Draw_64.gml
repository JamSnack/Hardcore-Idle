/// @description
//Draw tha balls!
event_inherited();

for (var _i = 0; _i < ds_list_size(balls); _i++)
{
	var _ball = balls[| _i];
	var x_dist = dsin(360*(_ball.distance/100));
	var y_dist = dcos(360*(_ball.distance/100));
	
	draw_sprite(spr_green_marble,0, x -4 - x_dist*165, y -y_dist*100);
}
