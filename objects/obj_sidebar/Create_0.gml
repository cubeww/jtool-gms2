/// @description Define sidebar

event_inherited();

// define sidebar
sidebar = control.add_control(Control);
	
// define instructions
btn_instr = sidebar.add_child(new ToggleButton(8, 8, 96, 32, "Instructions", "Hide", noone, function() {
	if (btn_instr.active)
		TweenFire(instr, EaseOutExpo, TWEEN_MODE_ONCE, false, 0, room_speed, "ralpha", instr.ralpha, 1);
	else
		TweenFire(instr, EaseOutExpo, TWEEN_MODE_ONCE, false, 0, room_speed, "ralpha", instr.ralpha, 0);
}));

instr = btn_instr.add_child(new Panel(-256, -8, 248, 275));
instr.color = make_color_rgb(220, 221, 221);
instr.ralpha = 0;

cury = 12;
var instr_add_label = function(key, hint) {
	instr.add_child(new Label(12, cury, key, fa_left, fa_top)); 
	instr.add_child(new Label(100, cury, hint, fa_left, fa_top)); 
	cury += 26;
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
