function Save() constructor {
	x = 0;
	y = 0;
	grav = 1;
	xscale = 1;
	
	save = function() {
		if (instance_exists(obj_player)) {
			x = obj_player.x;
			y = obj_player.y;
			grav = global.player_grav;
			xscale = global.player_xscale;
		}
	}
	
	load = function() {
		instance_destroy(obj_player);
		instance_destroy(obj_blood);
		global.player_grav = grav;
		global.player_xscale = xscale;
		instance_create_layer(x, 
							  y, 
							  palette_object_get_layer(obj_player),
							  obj_player);
	}
}