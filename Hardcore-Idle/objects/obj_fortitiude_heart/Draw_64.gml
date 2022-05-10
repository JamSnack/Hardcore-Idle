/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//keep the surface going
if (!surface_exists(liquid_surface))
{
	liquid_surface = surface_create(sprite_width, sprite_height);
}


//fill our hearts with oil
surface_set_target(liquid_surface);
draw_sprite(sprite_index, image_index, 0, 0);

gpu_set_colorwriteenable(1,1,1,0);
draw_sprite(spr_jam_filling, 0, 0, sprite_height * ((liquid_filling_max - drawn_filling)/liquid_filling_max));
gpu_set_colorwriteenable(1,1,1,1);

surface_reset_target();

draw_surface(liquid_surface, x, y);

//Text
var _t = "Liquid: " + string(liquid_filling) + "/" + string(liquid_filling_max);
draw_text_outlined_transformed(x - string_width(_t)/2 + sprite_width/2, y + sprite_height + 32, c_black, c_white, _t, 1, 1, 0);

