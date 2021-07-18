function ListBox(_rx = 0, _ry = 0, _w = 128, _h = 128, _on_click = pointer_null) : Control(_rx, _ry, _w, _h) constructor {
	list = ds_list_create();
	show_count = 8;
	select = noone;
	enter_color = make_color_rgb(229, 243, 255);
	select_color = make_color_rgb(163, 214, 255);
	text_color = c_black;
	on_click = _on_click;
	enter = noone;
	text_xoffset = 4;
	max_text_length = 20;
	
	start_index = 0;
	
	add_item = function(item) {
		ds_list_add(list, item);
	}
	
	remove_item = function(pos) {
		ds_list_delete(list, pos);
	}
	
	get_select_item = function() {
		if (select != noone)
			return list[| select];
		else return noone;
	}
	
	on_step = function() {
		var dy = h / show_count;
		for (var i = 0; i < show_count; i++) {
			var index = start_index + i;
			if (index > ds_list_size(list) - 1) {
				break;
			}
			
			if (point_in_rectangle(mouse_x, mouse_y, x, y + i*dy, x + w - 1, y + (i+1)*dy - 1)) {
				enter = index;
				if (mouse_check_button_pressed(mb_left)) {
					select = index;
					if (on_click != pointer_null)
						on_click();
				}
				break;
			} else {
				enter = noone;
			}
		}
	}
	
	on_draw = function() {
		draw_set_alpha(alpha);
		
		// draw border
		draw_set_color(c_black);
		draw_rectangle(x, y, x + w - 1, y + h - 1, 1);
		
		// draw items
		var dy = h / show_count;
		for (var i = 0; i < show_count; i++) {
			var index = start_index + i;
			if (index > ds_list_size(list) - 1) {
				break;
			}
			
			var x1 = x;
			var y1 = y + i * dy;
			var x2 = x + w - 1;
			var y2 = y + (i+1) * dy - 1;
			
			if (select == index) {
				// draw select color
				draw_set_color(select_color);
				draw_rectangle(x1, y1, x2, y2, 0);
			} else if (enter == index) {
				// draw enter color
				draw_set_color(enter_color);
				draw_rectangle(x1, y1, x2, y2, 0);
			}
			// draw item text
			draw_set_color(text_color);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			var x3 = x;
			var y3 = (y1 + y2) / 2;
			var str = string_copy(list[| index], 1, max_text_length);
			if (string_length(list[| index]) > max_text_length)
				str += "...";
			draw_text(x3 + text_xoffset, y3, str);
		}
	}
}