/// @description Give XP and resources
with (gameControl)
	give_xp(obj_player.x, obj_player.y, other.max_hp*4 + round(other.damage*1.25));
	
drop_item(x, y, resource);
