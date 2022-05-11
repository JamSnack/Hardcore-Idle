/// @description Grant XP and Loot
with (gameControl)
	give_xp( other.max_hp*4 + round(other.damage*1.25));
	
drop_item(x, y, generate_item());
