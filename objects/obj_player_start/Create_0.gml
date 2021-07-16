instance_destroy(obj_player);

with (object_index) {
	if (id != other.id)
		instance_destroy();
}

global.save_player_x = x + 17;
global.save_player_y = y + 23;

instance_create_layer(x + 17, y + 23, palette_object_get_layer(obj_player), obj_player);