if(global.movingvkeys && global.vkeysgridmode)
{
	draw_set_alpha(0.3)
	draw_set_color(c_red)
	var _size = global.vkeysgrid_size
	var _width = display_get_gui_width()
	var _height = display_get_gui_height()
	for (var i = 0; i <= _width; i += _size) 
	{
	    draw_line(i, 0, i, _height);
	}
	for (var i = 0; i <= _height; i += _size) 
	{
	    draw_line(0, i, _width, i);
	}
}

/*
if(global.colorvkeys)
{
	var _width = display_get_gui_width()
	var _height = display_get_gui_height()
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_roundrect_ext((_width / 2) -200, (_height / 2) -100, (_width / 2) +200, (_height / 2) +100, 10, 10, false)
	
	draw_roundrect_ext((_width / 2) -180, (_height / 2) -80, (_width / 2) -140, (_height / 2) +80, 10, 10, false)
}
*/