function SlideBar(_rx = 0, _ry = 0, _w = 32, _h = 128, _on_slide = pointer_null) : Control(_rx, _ry, _w, _h) constructor {
	pos = 0; // 0 to 1
	on_slide = _on_slide;
	
	slider_w = _w;
	slider_h = 32;
	
	held = false;

	on_step = function() {
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x+w-1, y+h-1)) {
			if (mouse_check_button(mb_left)) {
				held = true;
				pos = clamp((mouse_y - (y+slider_h/2) ) / (h-slider_h), 0, 1);
				
				if (on_slide != pointer_null)
					on_slide();
			} else {
				held = false;
			}
		} else {
			held = false;
		}
		
		if (mouse_wheel_down()) {
			pos = clamp(pos + 0.01, 0, 1);
			on_slide();
		} else if (mouse_wheel_up()) {
			pos = clamp(pos - 0.01, 0, 1);
			on_slide();
		}
	}
	
	on_draw = function() {
		draw_set_alpha(alpha);
		
		// draw border
		draw_set_color(c_black);
		draw_rectangle(x, y, x+w-1, y+h-1, 1);
		
		// draw slider
		draw_set_color(global.current_skin.button_idle_color);
		draw_button(x, y+pos*(h-slider_h), x+slider_w-1, y+pos*(h-slider_h)+slider_h-1, !held);
	}
}