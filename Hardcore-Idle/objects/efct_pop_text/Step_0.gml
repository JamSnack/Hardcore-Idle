/// @description Insert description here
// You can write your code in this editor

//make it all wobbly and what-not
time++;

scale += scale_rate;	

if (scale+scale_rate > scale_target)
{
	scale_rate -= scale_rate_rate;
}
else if (scale-scale_rate < scale_target)
{
	scale_rate += scale_rate_rate;
}

if (time >= room_speed)
{
	scale_rate = 0;
	scale = scale_target;
}

if (scale == scale_target)
{
	image_alpha -= 0.01;	
	
	if (image_alpha == 0)
		instance_destroy();
}
