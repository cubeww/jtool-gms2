xmin = 0;
ymin = 0;
xmax = 799;
ymax = 607;

selected_object = obj_block;
selected_sprite = spr_edit_block;

caught_object = noone;
caught_old_x = pointer_null;
caught_old_y = pointer_null;

left_pressed = false;
left_released = false;
left_held = false;
left_held_last = false;

right_pressed = false;
right_released = false;
right_held = false;
right_held_last = false;

drag_held = false;
picker_held = false;
code_held = false;

xsnapped = 0;
ysnapped = 0;
cursor_in_area = false;

snap = 32;

// undo & redo
undo_list = [];
undo_pos = 0;

#macro UNDO_EVENT_CREATE 0
#macro UNDO_EVENT_REMOVE 1
#macro UNDO_EVENT_MOVE 2

function UndoEvent(_type) constructor {
	type = _type;
	sub_events = [];
	
	add_sub_event = function(event) {
		array_push(sub_events, event);
	}
}

function CreateSubEvent(_x, _y, _obj_index) constructor {
	x = _x;
	y = _y;
	obj_index = _obj_index;
}

function RemoveSubEvent(_x, _y, _obj_index) constructor {
	x = _x;
	y = _y;
	obj_index = _obj_index;
}

function MoveSubEvent(_id, _old_x, _old_y, _new_x, _new_y) constructor {
	obj_id = _id;
	old_x = _old_x;
	old_y = _old_y;
	new_x = _new_x;
	new_y = _new_y;
}

cur_event = noone;
mouse_x_last = mouse_x;
mouse_y_last = mouse_y;
