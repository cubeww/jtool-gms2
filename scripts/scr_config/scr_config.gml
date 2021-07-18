function Config() constructor {
	death_enable = true;
	grid_snap = 16;
	fullscreen = false;
	show_analysis = true;
	dotkid_outline = true;
	hide_sidebar = false;
	editor_instructions = false;
	show_hitbox = 0;
	grid_draw = 32;
	mouse_coords = true;
	player_y_extended = false;
	depth_order = "";
	backup = 0;
	check_updates = true;
	
	save = function() {
		ini_open(get_working_directory() + "config.ini");
		ini_write_real("prefs", "death", death_enable);
		ini_write_real("prefs", "gridsnap", grid_snap);
		ini_write_string("prefs", "skin", global.current_skin.name);
		ini_write_real("prefs", "fullscreen", fullscreen);
		ini_write_real("prefs", "showanalysis", show_analysis);
		ini_write_real("prefs", "dotkidoutline", dotkid_outline);
		ini_write_real("prefs", "hidesidebar", hide_sidebar);
		ini_write_real("prefs", "editorinstructions", editor_instructions);
		ini_write_real("prefs", "showhitbox", show_hitbox);
		ini_write_real("prefs", "grid_draw", grid_draw);
		ini_write_real("prefs", "mousecoords", mouse_coords);
		ini_write_real("prefs", "playery_extended", player_y_extended);
		ini_write_string("prefs", "depthorder", depth_order);
		ini_write_real("prefs", "backup", backup);
		ini_write_real("prefs", "checkupdates", check_updates);
		ini_close();
	}
	load = function() {
		var ini = get_working_directory() + "config.ini";
		ini_open(ini);
		death_enable = ini_read_real("prefs", "death", false);
		grid_snap = ini_read_real("prefs", "gridsnap", 32);
		var skin_name = ini_read_string("prefs", "skin", "pat_default");
		window_set_fullscreen(ini_read_real("prefs", "fullscreen", false));
		show_analysis = ini_read_real("prefs", "showanalysis", true);
		dotkid_outline = ini_read_real("prefs", "dotkidoutline", true);
		hide_sidebar = ini_read_real("prefs", "hidesidebar", false);
		editor_instructions = ini_read_real("prefs", "editorinstructions", true);
		show_hitbox = ini_read_real("prefs", "showhitbox", 0);
		grid_draw = ini_read_real("prefs", "grid_draw", false);
		mouse_coords = ini_read_real("prefs", "mousecoords", false);
		player_y_extended = ini_read_real("prefs", "playery_extended", false);
		depth_order = ini_read_string("prefs", "depthorder", "0,1,2,3");
		backup = ini_read_real("prefs", "backup", true);
		check_updates = ini_read_real("prefs", "checkupdates", true);
		ini_close();
		
		global.current_skin.load(skin_name);
		global.current_skin.apply();
	}
}