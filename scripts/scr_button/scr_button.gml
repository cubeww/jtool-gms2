// the most basic button, when pressed, the "on_click" method will be called 
function Button(_rx = 0, _ry = 0, _w = 130, _h = 32, _text = "", _icon = noone, _on_click = function() {}) : Control(_rx, _ry, _w, _h) constructor {
	// properties
	on_click = _on_click;

	border = true;
	border_color = c_black;

	leave_color = make_color_rgb(175, 175, 175);
	enter_color = make_color_rgb(215, 215, 215);

	text = _text;
	text_color = c_black;

	icon = _icon;
	icon_xo = 16;
	icon_yo = 0;

	// fields
	enter = false;
	lbl = add_control(Label);
	lbl.halign = fa_center;
	lbl.valign = fa_middle;
	
	// methods
	static on_step = function() {
		lbl.rx = w/2 + (icon != noone ? sprite_get_width(icon) : 0);
		lbl.ry = h/2;
		lbl.text = text;
		lbl.color = text_color;
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
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
function ToggleButton(_rx = 0, _ry = 0, _w = 130, _h = 32, _inactive_text = "", _active_text = "", _icon = noone, _on_click = function() {}) : Button(_rx, _ry, _w, _h, _active_text, _icon, _on_click) constructor {
	// properties
	inactive_text = _inactive_text;

	// fields
	active = false;
	
	// methods
	static on_step = function() {
		lbl.rx = w/2 + (icon != noone ? sprite_get_width(icon) : 0);
		lbl.ry = h/2;
		lbl.text = active ? text : inactive_text;
		lbl.color = text_color;
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				active = !active;
				
				on_click();
			}
		} else {
			enter = false;
		}
	}
}
// expand toggle button, when pressed, the "on_click" method will be called, 
// and it will switch between inactive and active states. When in inactive state, children will be disabled. 
function ExpandToggleButton(_rx = 0, _ry = 0, _w = 130, _h = 32, _inactive_text = "", _active_text = "", _icon = noone, _on_click = function() {}) : ToggleButton(_rx, _ry, _w, _h, _inactive_text, _active_text, _icon, _on_click) constructor {
	// methods
	static on_step = function() {
		lbl.rx = w/2 + (icon != noone ? sprite_get_width(icon) : 0);
		lbl.ry = h/2;
		lbl.text = active ? text : inactive_text;
		lbl.color = text_color;
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				active = !active;
				on_click();
			}
		} else {
			enter = false;
		}
		
		for (var i = 0; i < ds_list_size(children); i++) {
			var ctrl = children[| i];
			if (ctrl != lbl) {
				ctrl.disabled = !active;
			}
		}
	}
}
// conditional expand toggle button, it uses a function as the "active" condition 
function CondExpandToggleButton(_rx = 0, _ry = 0, _w = 130, _h = 32, _inactive_text = "", _active_text = "", _icon = noone, _on_click = function() {}, _cond = function() {}) : ToggleButton(_rx, _ry, _w, _h, _inactive_text, _active_text, _icon, _on_click) constructor {
	// properties
	cond = _cond;
	
	// methods
	static on_step = function() {
		lbl.rx = w/2 + (icon != noone ? sprite_get_width(icon) : 0);
		lbl.ry = h/2;
		lbl.text = active ? text : inactive_text;
		lbl.color = text_color;
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				on_click();
			}
		} else {
			enter = false;
		}
		
		active = cond();
		for (var i = 0; i < ds_list_size(children); i++) {
			var ctrl = children[| i];
			if (ctrl != lbl) {
				ctrl.disabled = !active;
			}
		}
	}
}
// multiple toggle button, can toggle between multiple states 
function MultipleToggleButton(_rx = 0, _ry = 0, _w = 130, _h = 32, _texts = [], _icon = noone, _on_click = function() {}, _num = 0, _max_num = 2) : Button(_rx, _ry, _w, _h, "", _icon, _on_click) constructor {
	// properties
	texts = _texts;
	num = _num;
	max_num = _max_num;
	
	// methods
	static on_step = function() {
		lbl.rx = w/2 + (icon != noone ? sprite_get_width(icon) : 0);
		lbl.ry = h/2;
		lbl.text = texts[num];
		lbl.color = text_color;
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
			enter = true;
			if (mouse_check_button_pressed(mb_left)) {
				num++;
				if (num > max_num)
					num = 0;
				
				on_click();
			}
		} else {
			enter = false;
		}
	}
}
