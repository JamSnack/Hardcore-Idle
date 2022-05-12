/// @description Insert description here
// You can write your code in this editor
//Handle the liquid filling
if (liquid_filling > 0 && liquid_drain_delay <= 0)
{
	var gains = gameControl.health_points_rate + gameControl.bonus_health_points_rate;
	
	//consume liquid filling
	liquid_filling -= gains;
	
	//add to health
	gameControl.health_points += gains;
	
	//effects
	create_pop_text(obj_player.x + irandom_range(-16, 16), obj_player.y + irandom_range(-16,16), c_red, c_black, 1, "+" + string(gains));
	
	//don't be less than 0
	if (liquid_filling < 0)
		liquid_filling = 0;
		
	//delay
	liquid_drain_delay = gameControl.health_points_speed - gameControl.bonus_health_points_speed;
}
else liquid_drain_delay--;

// Inherit the parent event
event_inherited();

//drawn filling
drawn_filling = approach(drawn_filling, liquid_filling, 0.01);
