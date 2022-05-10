/// @description Draw stuff to the game 

//Surfaces
if (!surface_exists(surface_movement_grid))
{
	surface_movement_grid = surface_create(room_width, room_height);
	
	surface_set_target(surface_movement_grid);
	
	// - room width and height in terms of cell_size
	var room_h = floor(room_height/cell_size);
	var room_w = floor(room_width/cell_size);
		
	draw_set_color(grid_color);
	
	for(var _x = 0; _x < room_w; _x++)
	{
		draw_line( _x*cell_size, 0, _x*cell_size, room_height);
	}
		
	for(var _y = 0; _y < room_h; _y++)
	{
		draw_line( 0, _y*cell_size, room_width, _y*cell_size);
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
