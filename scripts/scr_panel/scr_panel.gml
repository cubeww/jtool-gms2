function Panel(_rx = 0, _ry = 0, _w = 128, _h = 128) : Control(_rx, _ry, _w, _h) constructor {
	// properties
	color = c_white;
	border_color = c_black;
	
	// methods
	static on_draw = function() {
		// background color
		draw_set_color(color);
		draw_set_alpha(alpha);
		draw_rectangle(x, y, x+w, y+h, 0);
		
		// border
		draw_set_color(border_color);
		draw_rectangle(x, y, x+w, y+h, 1);
	}
}