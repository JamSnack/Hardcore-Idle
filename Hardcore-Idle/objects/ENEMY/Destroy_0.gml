/// @description Grant XP and Loot
with (gameControl)
	give_xp( other.max_hp*4 + round(other.damage*1.25));
	
drop_item(x, y, create_item("Greeg Marbs", 1, "Swordma", spr_green_marble, 0, ITEM_TYPE.wep_melee));
