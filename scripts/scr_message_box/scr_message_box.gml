function MessageBox(_rx = 0, _ry = 0, _w = 320, _h = 130, _text = "") : Control(_rx, _ry, _w, _h) constructor {
	// properties
	text = _text;

	// fields
	lbl = add_control(Label);
	
	btn_ok = add_child(new Button(0, 0, 130, 32, "OK", noone, destroy));
	btn_close = add_child(new Button(0, 0, 40, 25, "X", noone, destroy));
	
	// methods
	static on_step = function() {
		lbl.rx = w/2;
		lbl.ry = 32;
		lbl.valign = fa_top;
		lbl.text = text;
		
		btn_ok.rx = w/2 - btn_ok.w/2;
		btn_ok.ry = h - btn_ok.h - 8;
		
		btn_close.rx = w - btn_close.w;
		btn_close.ry = 0;
	}
	
	static on_draw = function() {
		// draw black screen
		draw_set_alpha(alpha * 0.5);
		draw_set_color(c_black);
		draw_rectangle(-1, -1, room_width, room_height, 0);
		
		// draw background
		draw_set_alpha(alpha);
		draw_set_color(make_color_rgb(226, 226, 226));
		draw_rectangle(x, y, x+w, y+h, 0);
		
		// draw border
		draw_set_alpha(alpha);
		draw_set_color(c_black);
		draw_rectangle(x, y, x+w, y+h, 1);
	}
}