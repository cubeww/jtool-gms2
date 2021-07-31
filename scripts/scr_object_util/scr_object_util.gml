function object_in_palette(index) {
	switch (index) {
	    case obj_spike_up:
	    case obj_spike_right:
	    case obj_spike_left:
	    case obj_spike_down:
	    case obj_mini_spike_up:
	    case obj_mini_spike_right:
	    case obj_mini_spike_left:
	    case obj_mini_spike_down:
	    case obj_block:
	    case obj_mini_block:
	    case obj_apple:
	    case obj_save:
	    case obj_platform:
	    case obj_killer_block:
	    case obj_water:
	    case obj_water2:
	    case obj_water3:
	    case obj_vine_l:
	    case obj_vine_r:
	    case obj_bullet_blocker:
	    case obj_player_start:
	    case obj_warp:
	    case obj_jump_refresher:
	    case obj_gravity_arrow_up:
	    case obj_gravity_arrow_down:
	    case obj_save_flip:
	    case obj_trg:
	    case obj_mini_killer_block:
	        return true;
			break;
		default:
			return false;
			break;
	}
}

function object_at_pos(_x, _y, _obj_index) {
	with (all) {
		if (object_index == _obj_index) {
			if (x == _x && y == _y) {
				return id;
			}
		}
	}
	return noone;
}

function palette_object_get_layer(_obj_index) {
	switch (_obj_index) {
		case obj_block:
		case obj_mini_block:
		case obj_bullet_blocker:
		case obj_platform:
			return "Block";
		case obj_spike_up:
		case obj_spike_down:
		case obj_spike_left:
		case obj_spike_right:
		case obj_mini_spike_up:
		case obj_mini_spike_down:
		case obj_mini_spike_left:
		case obj_mini_spike_right:
		case obj_apple:
		case obj_killer_block:
		case obj_mini_killer_block:
			return "Killer";
		case obj_water:
		case obj_water2:
		case obj_water3:
			return "Water";
		case obj_player:
			return "Player";
		case obj_save:
			return "Save";
		case obj_vine_l:
		case obj_vine_r:
			return "Vine";
		case obj_blood:
			return "Blood";
		default:
			return "Misc";
		
	}
	return noone;
}

function is_color_killer(_obj_index) {
	switch (_obj_index) {
		case obj_spike_up:
		case obj_spike_down:
		case obj_spike_left:
		case obj_spike_right:
		
		case obj_mini_spike_up:
		case obj_mini_spike_down:
		case obj_mini_spike_left:
		case obj_mini_spike_right:
		
		case obj_apple:
			return true;
		default:
			return false;
	}
}
