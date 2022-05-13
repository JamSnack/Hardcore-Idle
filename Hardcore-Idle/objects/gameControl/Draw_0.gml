/// @description Draw stuff to the game 

//Surfaces
if (!surface_exists(surface_movement_grid))
{
	surface_movement_grid = surface_create(game_map_x2, game_map_y2);
	
	surface_set_target(surface_movement_grid);
	
	// - room width and height in terms of cell_size
	var room_h = floor(game_map_y2/cell_size);
	var room_w = floor(game_map_x2/cell_size);
		
	draw_set_color(grid_color);
	
	for(var _x = 2; _x <= room_w; _x++)
	{
		draw_line( _x*cell_size, 32, _x*cell_size, game_map_y2);
	}
		
	for(var _y = 2; _y <= room_h; _y++)
	{
		draw_line( 32, _y*cell_size, game_map_x2, _y*cell_size);
	}
	
	surface_reset_target();
}

//Draw stuff
var x_mouse = floor(mouse_x/cell_size)*cell_size + 16;
var y_mouse = floor(mouse_y/cell_size)*cell_size + 16;

switch(game_turn)
{
	case TURN.player:
	{	
		//Draw movement options
		draw_sprite(spr_selection, can_move, x_mouse, y_mouse);
	}
	break;
}


//Draw world grid
draw_surface(surface_movement_grid, 0, 0);
