left_pressed = mouse_check_button_pressed(mb_left);
left_released = mouse_check_button_released(mb_left);

left_held_last = left_held;
left_held = mouse_check_button(mb_left);

right_pressed = mouse_check_button_pressed(mb_right);
right_released = mouse_check_button_released(mb_right);

right_held_last = right_held;
right_held = mouse_check_button(mb_right);

drag_held = keyboard_check(vk_space);
picker_held = keyboard_check(vk_control);
code_held = keyboard_check(vk_alt);

cursor_in_area = point_in_rectangle(mouse_x, mouse_y, xmin, ymin, xmax, ymax);

snap = 32;

// undo events
function add_create_event(_x, _y, _obj_index) {
	if (cur_event == noone) {
		cur_event = new UndoEvent(UNDO_EVENT_CREATE);
	}
	cur_event.add_sub_event(new CreateSubEvent(_x, _y, _obj_index));
}

function add_remove_event(_x, _y, _obj_index) {
	if (cur_event == noone) {
		cur_event = new UndoEvent(UNDO_EVENT_REMOVE);
	}
	cur_event.add_sub_event(new RemoveSubEvent(_x, _y, _obj_index));
}

function add_move_event(_id, _old_x, _old_y, _new_x, _new_y) {
	if (cur_event == noone) {
		cur_event = new UndoEvent(UNDO_EVENT_MOVE);
	}
	cur_event.add_sub_event(new MoveSubEvent(_id, _old_x, _old_y, _new_x, _new_y));
}

function finish_event() {
	if (cur_event != noone) {
		// clean useless events
		var size = ds_list_size(undo_list);
		for (var i = undo_pos; i < size; i++) {
			ds_list_delete(undo_list, undo_pos);
		}
		ds_list_add(undo_list, cur_event);
		cur_event = noone;
		undo_pos++;
	}
}

function finish_create_object(_x, _y) {
	if (!object_at_pos(_x, _y, selected_object)) {
		var inst = instance_create_layer(_x, _y, palette_object_get_layer(selected_object), selected_object);
		add_create_event(inst.x, inst.y, inst.object_index);
	}
}

function finish_move_object() {
	if (caught_object != noone) {
		add_move_event(caught_object, caught_old_x, caught_old_y, caught_object.x, caught_object.y);
		caught_object = noone;
		finish_event();
	}
}

if (global.state == GLOBALSTATE_IDLE) {
	if (cursor_in_area) {
		xsnapped = floor(mouse_x / snap) * snap;
		ysnapped = floor(mouse_y / snap) * snap;
		
		window_set_cursor(cr_none);
		if (drag_held) {
			// drag object
			cursor_sprite = spr_cursor_open_hand;
			
			if (left_held) {
				cursor_sprite = spr_cursor_closed_hand;
				// catch object
				if (caught_object == noone) {
					with (all) {
						if (object_in_palette(object_index)) {
							var col = collision_point(mouse_x, mouse_y, object_index, true, true);
							if (col != noone) {
								other.caught_object = col;
								other.caught_old_x = col.x;
								other.caught_old_y = col.y;
								break;
							}
						}
					}
				} else {
					// move caught  object
					caught_object.x = xsnapped;
					caught_object.y = ysnapped;
				}
			} 
			if (left_released) {
				finish_move_object();
			}
		} else if (picker_held) {
			// pick up object
			cursor_sprite = spr_cursor_dropper;
			if (left_pressed) {
				var col = ds_list_create();
				collision_point_list(mouse_x, mouse_y, all, true, false, col, false);
				for (var i = 0; i < ds_list_size(col); i++) {
					var obj = col[| i];
					if (object_in_palette(obj.object_index)) {
						selected_object = obj.object_index;
						selected_sprite = obj.sprite_index;
					}
				}
				ds_list_destroy(col);
			}
		} else if (code_held) {
			// edit object code
			cursor_sprite = spr_cursor_coder;
		} else {
			window_set_cursor(cr_arrow);
			cursor_sprite = noone;
			
			if (left_held) {
				// create object
				if (left_held_last) {
					// create a line
					var dir = point_direction(mouse_x_last, mouse_y_last, mouse_x, mouse_y);
					var n = floor(point_distance(mouse_x_last, mouse_y_last, mouse_x, mouse_y));
					var len = 1;
					var dx = lengthdir_x(len, dir);
					var dy = lengthdir_y(len, dir);
					var xx = mouse_x_last;
					var yy = mouse_y_last;
					var xxn_last = noone;
					var yyn_last = noone;
					for (var i = 0; i < n; i++) {
						var xxn = floor(xx / snap) * snap;
						var yyn = floor(yy / snap) * snap;
						if (xxn != xxn_last || yyn != yyn_last) {
							xxn_last = xxn;
							yyn_last = yyn;
							finish_create_object(xxn, yyn);
						}
						xx += dx;
						yy += dy;
					}
				}
				finish_create_object(xsnapped, ysnapped);
			} else if (right_held) {
				var col = ds_list_create();
				// remove object
				if (right_held_last) {
					// remove a line
					collision_line_list(mouse_x_last, mouse_y_last, mouse_x, mouse_y, all, true, false, col, false);
				} else {
					// remove a point
					collision_point_list(mouse_x, mouse_y, all, true, false, col, false);
				}
				for (var i = 0; i < ds_list_size(col); i++) {
					var obj = col[| i];
					if (object_in_palette(obj.object_index)) {
						if (obj.object_index == obj_player_start)
							continue;
						
						with (other) {
							add_remove_event(obj.x, obj.y, obj.object_index);
						}
						instance_destroy(obj);
					}
				}
				ds_list_destroy(col);
			}
		}
		
		if (!drag_held) {
			finish_move_object();
		}
		
		if (left_released || right_released) {
			finish_event();
		}
	} else {
		window_set_cursor(cr_arrow);
		cursor_sprite = noone;
	}
}

// undo & redo handle
if (keyboard_check(vk_control)) {
	if (keyboard_check_pressed(ord("Z"))) {
		// undo
		if (undo_pos >= 1) {
			undo_pos--;
			var last_event = undo_list[| undo_pos];
			for (var i = 0; i < ds_list_size(last_event.sub_events); i++) {
				var sub_event = last_event.sub_events[| i];
				switch (last_event.type) {
					case UNDO_EVENT_CREATE:
						var obj = object_at_pos(sub_event.x, sub_event.y, sub_event.obj_index);
						instance_destroy(obj);
						break;
					case UNDO_EVENT_REMOVE:
						instance_create_layer(sub_event.x, sub_event.y, palette_object_get_layer(sub_event.obj_index), sub_event.obj_index);
						break;
					case UNDO_EVENT_MOVE:
						var obj = sub_event.obj_id;
						obj.x = sub_event.old_x;
						obj.y = sub_event.old_y;
						break;
				}
			}
		}
	}
	if (keyboard_check_pressed(ord("Y"))) {
		// redo
		if (undo_pos < ds_list_size(undo_list)) {
			var last_event = undo_list[| undo_pos];
			for (var i = 0; i < ds_list_size(last_event.sub_events); i++) {
				var sub_event = last_event.sub_events[| i];
				switch (last_event.type) {
					case UNDO_EVENT_CREATE:
						instance_create_layer(sub_event.x, sub_event.y, palette_object_get_layer(sub_event.obj_index), sub_event.obj_index);
						break;
					case UNDO_EVENT_REMOVE:
						var obj = object_at_pos(sub_event.x, sub_event.y, sub_event.obj_index);
						instance_destroy(obj);
						break;
					case UNDO_EVENT_MOVE:
						var obj = sub_event.obj_id;
						obj.x = sub_event.new_x;
						obj.y = sub_event.new_y;
						break;
				}
			}
			undo_pos++;
		}
	}
}

mouse_x_last = mouse_x;
mouse_y_last = mouse_y;