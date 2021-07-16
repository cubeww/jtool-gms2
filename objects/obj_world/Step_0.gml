if (keyboard_check_pressed(ord("R"))) {
	instance_destroy(obj_player);
	instance_destroy(obj_blood);
	global.player_grav = global.save_player_grav;
	global.player_xscale = global.save_player_xscale;
	instance_create_layer(global.save_player_x, 
						  global.save_player_y, 
						  palette_object_get_layer(obj_player),
						  obj_player);
}