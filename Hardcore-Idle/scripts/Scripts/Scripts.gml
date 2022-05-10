// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//draw_text_outlined(x, y, outline color, string color, string)  

function draw_text_outlined(x, y, outline_color, text_color, text)
{
	//Outline  
	draw_set_color(outline_color);  
	
	draw_text(x+1, y+1, text);  
	draw_text(x-1, y-1, text);  
	draw_text(x,   y+1, text);  
	draw_text(x+1, y,   text);  
	draw_text(x,   y-1, text);  
	draw_text(x-1, y,   text);  
	draw_text(x-1, y+1, text);  
	draw_text(x+1, y-1, text);  
  
	//Text  
	draw_set_color(text_color);  
	draw_text(x, y, text);
}

function draw_text_outlined_transformed(x, y, outline_color, text_color, text, xscale, yscale, angle)
{
	//Outline  
	draw_set_color(outline_color);  
	
	draw_text_transformed(x+1, y+1, text, xscale, yscale, angle);  
	draw_text_transformed(x-1, y-1, text, xscale, yscale, angle);    
	draw_text_transformed(x,   y+1, text, xscale, yscale, angle);    
	draw_text_transformed(x+1, y,   text, xscale, yscale, angle);   
	draw_text_transformed(x,   y-1, text, xscale, yscale, angle);    
	draw_text_transformed(x-1, y,   text, xscale, yscale, angle);   
	draw_text_transformed(x-1, y+1, text, xscale, yscale, angle);    
	draw_text_transformed(x+1, y-1, text, xscale, yscale, angle);    
  
	//Text  
	draw_set_color(text_color);  
	draw_text_transformed(x, y, text, xscale, yscale, angle);  
}

function create_pop_text(x, y, color, outline_color, scale, text)
{
	var _pop = instance_create_layer(x, y, "Instances", efct_pop_text);
	_pop.color = color;
	_pop.outline_color = outline_color;
	_pop.scale_target = scale;
	_pop.text = text;
}
