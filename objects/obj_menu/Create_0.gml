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
menu.color = make_color_rgb(220, 221, 221);

// menu methods
show_menu = function() {
	if (global.state == GLOBALSTATE_IDLE && menu.ry == menu_hide_y) {
		global.state = GLOBALSTATE_MENU;
		TweenFire(menu, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, room_speed / 2, "ry", menu.ry, 0);
	}
}

close_menu = function() {
	global.state = GLOBALSTATE_IDLE;
	TweenFire(menu, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, room_speed / 2, "ry", menu.ry, menu_hide_y);
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
tab_file = menu.add_child(new CondExpandToggleButton(xo + dx * 0, yo, w, h, 
	"File", "[ File ]", noone, function() { menu_tab = MENUTAB_FILE; }, 
	function() { return menu_tab == MENUTAB_FILE; }));

xx = 0;
yy = yo2;
btn_openmap = tab_file.add_child(new Button(xx, yy, w, h, "Open Map", spr_menu_open, function() {}));

yy += dy;
btn_savemap = tab_file.add_child(new Button(xx, yy, w, h, "Save Map", spr_menu_save, function() {}));

yy += dy;
btn_importrmj = tab_file.add_child(new Button(xx, yy, w, h, "Import RMJ Map", noone, function() {}));

yy += dy;
btn_exportrmj = tab_file.add_child(new Button(xx, yy, w, h, "Export RMJ Map", noone, function() {}));

xx += dx;
yy = yo2;
btn_exportgm8 = tab_file.add_child(new Button(xx, yy, w, h, "Export GM8 Map", noone, function() {}));

yy += dy;
btn_exportgms1 = tab_file.add_child(new Button(xx, yy, w, h, "Export GMS1 Map", noone, function() {}));

yy += dy;
btn_exportgms2 = tab_file.add_child(new Button(xx, yy, w, h, "Export GMS2 Map", noone, function() {}));

yy += dy;
btn_exportiwm = tab_file.add_child(new Button(xx, yy, w, h, "Export IWM Map", noone, function() {}));

// map tab
tab_map = menu.add_child(new CondExpandToggleButton(xo + dx * 1, yo, w, h, 
	"Map", "[ Map ]", noone, function() { menu_tab = MENUTAB_MAP; }, 
	function() { return menu_tab == MENUTAB_MAP; }));

xx = -dx;
yy = yo2;
btn_clearmap = tab_map.add_child(new Button(xx, yy, w, h, "New Map (F2)", spr_menu_clear_map, function() {}));

yy += dy;
btn_backups = tab_map.add_child(new ToggleButton(xx, yy, w, h, "Backups off", "Backups on", noone, function() {}));

// player tab
tab_player = menu.add_child(new CondExpandToggleButton(xo + dx * 2, yo, w, h, 
	"Player", "[ Player ]", noone, function() { menu_tab = MENUTAB_PLAYER; }, 
	function() { return menu_tab == MENUTAB_PLAYER; }));
	
xx = -dx * 2;
yy = yo2;
btn_dotkid = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Dotkid", "[ Dotkid ]", spr_menu_dotkid, function() {}));

yy += dy;
btn_savetype = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Z Saves", "Shoot Save", spr_menu_save_point, function() {}));

yy += dy;
btn_infjump = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Inf Jump", "[ Inf Jump ]", spr_menu_inf_jump, function() {}));

yy += dy;
btn_deathborder = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Death Border", "[ Dotkid ]", spr_menu_border_type, function() {}));

xx += dx;
yy = yo2;
btn_dotoutline = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Dot Outline", "[ Dot Outline ]", spr_menu_dot_outline, function() {}));

yy += dy;
btn_death = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Death", "[ Death ]", spr_menu_death, function() {}));

yy += dy;
btn_hitbox = tab_player.add_child(new ToggleButton(xx, yy, w, h, "Hitbox", "[ Hitbox ]", spr_menu_hitbox, function() {}));

// view tab
tab_view = menu.add_child(new CondExpandToggleButton(xo + dx * 3, yo, w, h, 
	"View", "[ View ]", noone, function() { menu_tab = MENUTAB_VIEW; }, 
	function() { return menu_tab == MENUTAB_VIEW; }));

xx = -dx * 3;
yy = yo2;
btn_changeskin = tab_view.add_child(new Button(xx, yy, w, h, "Change Skin", spr_menu_skin, function() {}));

yy += dy;
btn_grid = tab_view.add_child(new MultipleToggleButton(xx, yy, w, h, 
	["Grid: off", "Grid: 32", "Grid: 16", "Grid: 8", "Grid: 4"], spr_menu_grid, function() {}, 0, 4));

yy += dy;
btn_coordinates = tab_view.add_child(new ToggleButton(xx, yy, w, h, "Coordinates", "[ Coordinates ]", spr_menu_coords, function() {}));

yy += dy;
btn_depthorder = tab_view.add_child(new Button(xx, yy, w, h, "Depth Order", spr_menu_depth, function() {}));

xx += dx;
yy = yo2;
btn_lockwater = tab_view.add_child(new ToggleButton(xx, yy, w, h, "Lock Water", "[ Lock Water ]", spr_menu_water_lock, function() {
	btn_lockwater.icon = btn_lockwater.active ? spr_menu_water_lock : spr_menu_water_lock2;
}));

yy += dy;
btn_fullscreen = tab_view.add_child(new Button(xx, yy, w, h, "Fullscreen", spr_menu_fullscreen, function() {}));

yy += dy;
btn_hidesidebar = tab_view.add_child(new ToggleButton(xx, yy, w, h, "Hide Sidebar", "Show Sidebar", spr_menu_sidebar, function() {
	btn_hidesidebar.icon = btn_hidesidebar.active ? spr_menu_sidebar2 : spr_menu_sidebar;
}));

// record tab
tab_record = menu.add_child(new CondExpandToggleButton(xo + dx * 4, yo, w, h, 
	"Record", "[ Record ]", noone, function() { menu_tab = MENUTAB_RECORD; }, 
	function() { return menu_tab == MENUTAB_RECORD; }));

xx = -dx * 4;

// help tab
tab_help = menu.add_child(new CondExpandToggleButton(xo + dx * 5, yo, w, h, 
	"Help", "[ Help ]", noone, function() { menu_tab = MENUTAB_HELP; }, 
	function() { return menu_tab == MENUTAB_HELP; }));

xx = -dx * 5;

// close menu button
xx = 1056 - w - 8;
yy = 12;
btn_close = menu.add_child(new Button(xx, yy, w, h, "Close Menu", noone, close_menu));


