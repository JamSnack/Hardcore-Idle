/// @description INIT
// You can write your code in this editor
target = obj_player;
damage = 1;
max_hp = 1;
hp = max_hp;

function to_string()
{
	var str = "HP: " + string(hp) + "/" + string(max_hp) + "\nAttack: "+string(damage);
	
	return str;
}
