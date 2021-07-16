function PaletteItem(_rx, _ry, _w, _h, _spr, _obj, _on_click = function() {}) : Control(_rx, _ry, _w, _h) constructor {
	spr = _spr;
	obj = _obj;
	
	border = true;
	border_color = c_black;

	leave_color = make_color_rgb(175, 175, 175);
	enter_color = make_color_rgb(215, 215, 215);
	
	flash_alpha = 0;
	flash_color = c_black;
	
	on_click = _on_click;
	
	// methods
	static on_step = function() {
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				// toggle selected object
				if (obj != noone) {
					obj_editor.selected_object = obj;
					obj_editor.selected_sprite = spr;
				}
				
				// create flash effect
				TweenFire(self, EaseInOutQuad, TWEEN_MODE_ONCE, false, 0, room_speed/5, "flash_alpha", 0.5, 0);
				
				on_click();
			}
		} else {
			enter = false;
		}
	}
	
	static on_draw = function() {
		draw_set_alpha(alpha);
		
		// background color
		if (!enter) {
			draw_set_color(leave_color);
			draw_rectangle(x, y, x + w, y + h, 0);
		} else {
			draw_set_color(enter_color);
			draw_rectangle(x, y, x + w, y + h, 0);
		}
		
		// sprite
		draw_sprite(spr, 0, x + sprite_get_xoffset(spr) + w/2 - sprite_get_width(spr)/2, 
							y + sprite_get_yoffset(spr) + h/2 - sprite_get_height(spr)/2);
		
		// flash effect
		draw_set_alpha(alpha * flash_alpha);
		draw_set_color(flash_color);
		draw_rectangle(x, y, x+w, y+h, 0);

		// border
		draw_set_alpha(alpha);
		if (border) {
			draw_set_color(border_color);
			draw_rectangle(x, y, x + w, y + h, 1);
		}
	}
}