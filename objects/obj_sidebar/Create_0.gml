/// @description Define sidebar

event_inherited();

// define sidebar
sidebar = control.add_control(Control);
	
// define instructions
btn_instr = sidebar.add_child(new ToggleButton(8, 8, 96, 32, "Instructions", "Hide", noone, function() {	
	global.config.editor_instructions = !global.config.editor_instructions;
}, true, function() {
	return global.config.editor_instructions;
}));

instr = btn_instr.add_child(new Panel(-256, -8, 249, 275));

yy = 12;
var instr_add_label = function(key, hint) {
	instr.add_child(new Label(12, yy, key, fa_left, fa_top)); 
	instr.add_child(new Label(100, yy, hint, fa_left, fa_top)); 
	yy += 26;
}
instr_add_label("L click", "Place Object");
instr_add_label("R click", "Remove Object");
instr_add_label("M button", "Move Object");
instr_add_label("Ctrl", "Select");
instr_add_label("Alt", "Edit Code");
instr_add_label("Ctrl+Z", "Undo");
instr_add_label("Ctrl+Y", "Redo");
instr_add_label("S", "Save");
instr_add_label("W", "Move Kid");
instr_add_label("A, D", "Nudge Kid X");

// define open menu button
btn_menu = sidebar.add_child(new Button(152, 8, 96, 32, "Menu (Esc)", noone, obj_menu.show_menu));

// define snap button
btn_snap = sidebar.add_child(new ToggleButton(8, 336, 112, 32, "Snap: 32", "Snap: 32", spr_menu_grid, pointer_null, true, function() {
    if (btn_snap.active) {
        if (!point_in_rectangle(mouse_x, mouse_y, btn_snap.x, btn_snap.y, btn_snap.x + 112 - 1, btn_snap.y + 106 - 1)) {
            return false;
        }
    }
    return btn_snap.active;
}));

// snap box
snapbox = btn_snap.add_child(new Control());
yy = 31;
var w = 38;
var dw = w - 1;
set_snap = function(new_snap) {
    obj_editor.snap = new_snap; 
    btn_snap.active_text = "Snap: " + string(new_snap);
    btn_snap.inactive_text = btn_snap.active_text;
    btn_snap.active = false;
}
snapbox.add_child(new Button(0, yy, w, w, "32", noone, function() { set_snap(32); }));
snapbox.add_child(new Button(dw, yy, w, w, "16", noone, function() { set_snap(16); }));
snapbox.add_child(new Button(dw * 2, yy, w, w, "8", noone, function() { set_snap(8); }));
snapbox.add_child(new Button(0, yy + dw, w, w, "1", noone, function() { set_snap(1); }));
snapbox.add_child(new Button(dw, yy + dw, w * 2 - 1, w, "other (G)", noone, function() { 
    inputbox = obj_popup_window.control.add_child(new InputBox("Grid snap", function() {
        set_snap(real(inputbox.text));
    }))
}));

// define speed button
btn_speed = sidebar.add_child(new ToggleButton(136, 336, 112, 32, "Speed: 50", "Speed: 50", spr_menu_speed, pointer_null, true, function() {
    if (btn_speed.active) {
        if (!point_in_rectangle(mouse_x, mouse_y, btn_speed.x, btn_speed.y, btn_speed.x + 112 - 1, btn_speed.y + 106 - 1)) {
            return false;
        }
    }
    return btn_speed.active;
}));

// speed box
speedbox = btn_speed.add_child(new Control());
yy = 31;
var w = 38;
var dw = w - 1;
set_speed = function(new_speed) {
    room_speed = new_speed;
    btn_speed.active_text = "Speed: " + string(new_speed);
    btn_speed.inactive_text = btn_speed.active_text;
    btn_speed.active = false;
}
speedbox.add_child(new Button(0, yy, w, w, "50", noone, function() { set_speed(50); }));
speedbox.add_child(new Button(dw, yy, w, w, "25", noone, function() { set_speed(25); }));
speedbox.add_child(new Button(dw * 2, yy, w, w, "10", noone, function() { set_speed(10); }));
speedbox.add_child(new Button(0, yy + dw, w, w, "100", noone, function() { set_speed(100); }));
speedbox.add_child(new Button(dw, yy + dw, w * 2 - 1, w, "other (F)", noone, function() { 
    inputbox = obj_popup_window.control.add_child(new InputBox("Room speed", function() {
        set_speed(real(inputbox.text));
    }))
}));

