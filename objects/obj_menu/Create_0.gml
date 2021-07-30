/// @description Define menu

event_inherited();

#macro MENUTAB_FILE 0
#macro MENUTAB_MAP 1
#macro MENUTAB_PLAYER 2
#macro MENUTAB_VIEW 3
#macro MENUTAB_RECORD 4
#macro MENUTAB_HELP 5

menu_tab = MENUTAB_FILE;

// menu panel
menu_height = 220;
menu_hide_y = -menu_height - 2;
menu = control.add_child(new Panel(0, menu_hide_y, 1056, menu_height));

// menu methods
show_menu = function() {
	if (global.state == GLOBALSTATE_IDLE && menu.ry == menu_hide_y) {
		global.state = GLOBALSTATE_MENU;
		TweenFire(menu, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, room_speed / 3, "ry", menu.ry, 0);
	}
}

close_menu = function() {
	global.state = GLOBALSTATE_IDLE;
	TweenFire(menu, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, room_speed / 3, "ry", menu.ry, menu_hide_y);
}

// define menu panel ui
var w = 130;     // button width
var h = 32;      // button height
var dx = 140;    // horizontal spacing between the two buttons
var dy = 40;     // vertical spacing between the two buttons
var xo = 20;     // x origin
var yo = 10;     // tab select y origin
var yo2 = 50;    // normal y origin

var xx = 0; // current x
var yy = 0; // current y

// file tab
tab_file = menu.add_child(new ToggleButton(xo + dx * 0, yo, w, h, 
	"File", "[ File ]", noone, function() { menu_tab = MENUTAB_FILE; }, true,
	function() { return menu_tab == MENUTAB_FILE; }));

xx = 0;
yy = yo2;
btn_openmap = tab_file.add_child(new Button(xx, yy, w, h, "Open Map", spr_menu_open, function() {
	var filename = get_open_filename_ext("all supported files|*.jmap2;*.jmap;*.map|jtool-gms2 map (*.jmap2)|*.jmap2|jtool 1.x map (*.jmap)|*.jmap|record my jumps map (*.map)|*.map", "", "", "Save Map");
	if (filename == "")
		return;
	switch (filename_ext(filename)) {
		case ".jmap2":
			global.current_map.load_map(filename);
			break;
		case ".jmap":
			global.current_map.load_jmap(filename);
			break;
		case ".map":
			global.current_map.load_rmj(filename);
			break;
	}
	global.current_map.apply();
}));

yy += dy;
btn_savemap = tab_file.add_child(new Button(xx, yy, w, h, "Save Map", spr_menu_save, function() {
	var filename = get_save_filename_ext("jtool-gms2 map (*.jmap2)|*.jmap2|jtool 1.x map (*.jmap)|*.jmap|record my jumps map (*.map)|*.map", "", "", "Save Map");
	if (filename == "")
		return;
		
	global.current_map.save_current();
	
	switch (filename_ext(filename)) {
		case ".jmap2":
			global.current_map.save_map(filename);
			break;
		case ".jmap":
			global.current_map.save_jmap(filename);
			break;
		case ".map":
			global.current_map.save_rmj(filename);
			break;
	}
}));	

xx += dx;
yy = yo2;

btn_exportgm8 = tab_file.add_child(new Button(xx, yy, w, h, "Export GM8 Map", noone, function() {
	global.current_map.save_current();
	global.current_map.save_gm8();
}));

yy += dy;
btn_exportgms1 = tab_file.add_child(new Button(xx, yy, w, h, "Export GMS1 Map", noone, function() {
	global.current_map.save_current();
	global.current_map.save_gms();
}));

yy += dy;
btn_exportgms2 = tab_file.add_child(new Button(xx, yy, w, h, "Export GMS2 Map", noone, function() {
	global.current_map.save_current();
	global.current_map.save_gms2();
}));

yy += dy;
btn_exportiwm = tab_file.add_child(new Button(xx, yy, w, h, "Export IWM Map", noone, function() {}));

// map tab
tab_map = menu.add_child(new ToggleButton(xo + dx * 1, yo, w, h,
	"Map", "[ Map ]", noone, function() { menu_tab = MENUTAB_MAP; }, true,
	function() { return menu_tab == MENUTAB_MAP; }));

xx = -dx;
yy = yo2;
btn_clearmap = tab_map.add_child(new Button(xx, yy, w, h, "New Map (F2)", spr_menu_clear_map, function() {}));

yy += dy;
btn_backups = tab_map.add_child(new ToggleButton(xx, yy, w, h, "Backups off", "Backups on", noone, function() {
	global.config.backup = !global.config.backup;
	global.config.save();
}, false, function() {
	return global.config.backup;
}));

// player tab
tab_player = menu.add_child(new ToggleButton(xo + dx * 2, yo, w, h, 
	"Player", "[ Player ]", noone, function() { menu_tab = MENUTAB_PLAYER; }, true, 
	function() { return menu_tab == MENUTAB_PLAYER; }));
	
xx = -dx * 2;
yy = yo2;
btn_dotkid = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Dotkid", "[ Dotkid ]", spr_menu_dotkid, function() {
	global.dotkid = !global.dotkid;
}, false, function() {
	return global.dotkid;
}));

yy += dy;
btn_savetype = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Z Saves", "Shoot Save", spr_menu_save_point, function() {
	global.save_type = !global.save_type;
}, false, function() {
	return global.save_type;
}));

yy += dy;
btn_infjump = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Inf Jump", "[ Inf Jump ]", spr_menu_inf_jump, function() {
	global.infjump = !global.infjump;
}, false, function() {
	return global.infjump;
}));

yy += dy;
btn_deathborder = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Death Border", "Solid Border", spr_menu_border_type, function() {
	global.border_type = !global.border_type;
}, false, function() {
	return global.border_type;
}));

xx += dx;
yy = yo2;
btn_dotoutline = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Dot Outline", "[ Dot Outline ]", spr_menu_dot_outline, function() {
	global.config.dotkid_outline = !global.config.dotkid_outline;
	global.config.save();
}, false, function() {
	return global.config.dotkid_outline;
}));

yy += dy;
btn_death = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Death", "[ Death ]", spr_menu_death, function() {
	global.config.death_enable = !global.config.death_enable;
	global.config.save();
}, false, function() {
	return global.config.death_enable;
}));

yy += dy;
btn_hitbox = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Hitbox", "[ Hitbox ]", spr_menu_hitbox, function() {
	global.config.show_hitbox++;
	if (global.config.show_hitbox > 2) {
		global.config.show_hitbox = 0;
	}
	global.config.save();
}, false, function() {
	return global.config.show_hitbox >= 1;
}));

// view tab
tab_view = menu.add_child(new ToggleButton(xo + dx * 3, yo, w, h, 
	"View", "[ View ]", noone, function() { menu_tab = MENUTAB_VIEW; }, true,
	function() { return menu_tab == MENUTAB_VIEW; }));

xx = -dx * 3;
yy = yo2;
btn_changeskin = tab_view.add_child(new Button(xx, yy, w, h, "Change Skin", spr_menu_skin, function() {
	obj_popup_window.control.add_control(SkinConfig);
}));

yy += dy;
btn_grid = tab_view.add_child(new MultipleToggleButton(xx, yy, w, h, 
	["Grid: off", "Grid: 32", "Grid: 16", "Grid: 8", "Grid: 4"], spr_menu_grid, function() {}, 0, 4));

yy += dy;
btn_coordinates = tab_view.add_child(new ToggleButton(xx, yy, w, h, "Coordinates", "[ Coordinates ]", spr_menu_coords, function() {
	global.config.mouse_coords = !global.config.mouse_coords;
	global.config.save();
}, false, function() {
	return global.config.mouse_coords;
}));

yy += dy;
btn_depthorder = tab_view.add_child(new Button(xx, yy, w, h, "Depth Order", spr_menu_depth, function() {}));

xx += dx;
yy = yo2;
btn_lockwater = tab_view.add_child(new ToggleButton(xx, yy, w, h, "Lock Water", "[ Lock Water ]", spr_menu_water_lock, function() {
	btn_lockwater.icon = btn_lockwater.active ? spr_menu_water_lock : spr_menu_water_lock2;
	global.water_lock = !global.water_lock;
}, false, function() {
	return global.water_lock;
}));

yy += dy;
btn_fullscreen = tab_view.add_child(new Button(xx, yy, w, h, "Fullscreen", spr_menu_fullscreen, function() {
	window_set_fullscreen(!window_get_fullscreen());
	global.config.save();
}, false, function() {
	return window_get_fullscreen();
}));

yy += dy;
btn_hidesidebar = tab_view.add_child(new ToggleButton(xx, yy, w, h, "Hide Sidebar", "Show Sidebar", spr_menu_sidebar, function() {
	global.config.hide_sidebar = !global.config.hide_sidebar;
	btn_hidesidebar.icon = global.config.hide_sidebar ? spr_menu_sidebar2 : spr_menu_sidebar;
}, false, function() {
	return global.config.hide_sidebar;
}));

// record tab
tab_record = menu.add_child(new ToggleButton(xo + dx * 4, yo, w, h, 
	"Record", "[ Record ]", noone, function() { menu_tab = MENUTAB_RECORD; }, true, 
	function() { return menu_tab == MENUTAB_RECORD; }));

xx = -dx * 4;

// help tab
tab_help = menu.add_child(new ToggleButton(xo + dx * 5, yo, w, h, 
	"Help", "[ Help ]", noone, function() { menu_tab = MENUTAB_HELP; }, true, 
	function() { return menu_tab == MENUTAB_HELP; }));

xx = -dx * 5;

// close menu button
xx = 1056 - w - 8;
yy = 12;
btn_close = menu.add_child(new Button(xx, yy, w, h, "Close Menu", noone, close_menu));


