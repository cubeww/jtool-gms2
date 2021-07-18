function Panel(_rx = 0, _ry = 0, _w = 128, _h = 128) : Control(_rx, _ry, _w, _h) constructor {
	// properties
	border_color = c_black;
	
	// methods
	on_draw = function() {
		// background color
		draw_set_alpha(alpha);
		draw_sprite_stretched(spr_popup, 0, x, y, w, h);
		
		// border
		draw_set_color(border_color);
		draw_rectangle(x, y, x+w-1, y+h-1, 1);
	}
}