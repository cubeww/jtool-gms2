// the most basic button, when pressed, the "on_click" method will be called 
function Button(_rx = 0, _ry = 0, _w = 130, _h = 32, _text = "", _icon = noone, _on_click = pointer_null) : Control(_rx, _ry, _w, _h) constructor {
	// properties
	on_click = _on_click;

	border = true;
	border_color = c_black;

	leave_color = make_color_rgb(175, 175, 175);
	enter_color = make_color_rgb(215, 215, 215);

	text = _text;
	text_color = c_black;
	text_font = font_small;

	icon = _icon;
	icon_xo = 16;
	icon_yo = 0;

	// fields
	enter = false;
	
	// methods
	on_step = function() {
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				if (on_click != pointer_null)
					on_click();
			}
		} else {
			enter = false;
		}
	}
	
	on_draw = function() {
		draw_set_alpha(alpha);
		
		// background color
		if (!enter) {
			draw_set_color(leave_color);
			draw_rectangle(x, y, x + w, y + h, 0);
		} else {
			draw_set_color(enter_color);
			draw_rectangle(x, y, x + w, y + h, 0);
		}
		
		// text
		draw_set_font(text_font);
		draw_set_color(text_color);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(x + w/2 + (icon != noone ? sprite_get_width(icon) : 0),
				  y + h/2, text);
		
		// icon
		if (icon != noone) {
			draw_sprite(icon, 0, x + icon_xo, y + h/2 + icon_yo);
		}
	
		// border
		if (border) {
			draw_set_color(border_color);
			draw_rectangle(x, y, x + w, y + h, 1);
		}
	}
}
// toggle button, press it to call the "on_click" method, and it will toggle between inactive and active states 
function ToggleButton(_rx = 0, _ry = 0, _w = 130, _h = 32, _inactive_text = "", _active_text = "", _icon = noone, _on_click = pointer_null, _hide_children = false, _cond = pointer_null) : Button(_rx, _ry, _w, _h, "", _icon, _on_click) constructor {
	// properties
	inactive_text = _inactive_text;
	active_text = _active_text;
	hide_children = _hide_children;
	cond = _cond;

	// fields
	active = false;
	
	// methods
	on_step = function() {
		text = active ? active_text : inactive_text;
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				active = !active;
				
				if (on_click != pointer_null)
					on_click();
			}
		} else {
			enter = false;
		}
		
		if (cond != pointer_null)
			active = cond();
			
		if (hide_children) {
			for (var i = 0; i < ds_list_size(children); i++) {
				var ctrl = children[| i];
				ctrl.disabled = !active;
			}
		}
	}
}

// multiple toggle button, can toggle between multiple states 
function MultipleToggleButton(_rx = 0, _ry = 0, _w = 130, _h = 32, _texts = [], _icon = noone, _on_click = pointer_null, _num = 0, _max_num = 2) : Button(_rx, _ry, _w, _h, "", _icon, _on_click) constructor {
	// properties
	texts = _texts;
	num = _num;
	max_num = _max_num;
	
	// methods
	on_step = function() {
		text = texts[num];
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				num++;
				if (num > max_num)
					num = 0;
				if (on_click != pointer_null)
					on_click();
			}
		} else {
			enter = false;
		}
	}
}
