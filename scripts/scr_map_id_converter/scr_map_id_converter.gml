
function index_to_jmap_id(objectindex) {
	switch (objectindex) {
	    case obj_block:
	        return 1;
	    case obj_mini_block:
	        return 2;
	    case obj_spike_up:
	        return 3;
	    case obj_spike_right:
	        return 4;
	    case obj_spike_left:
	        return 5;
	    case obj_spike_down:
	        return 6;
	    case obj_mini_spike_up:
	        return 7;
	    case obj_mini_spike_right:
	        return 8;
	    case obj_mini_spike_left:
	        return 9;
	    case obj_mini_spike_down:
	        return 10;
	    case obj_apple:
	        return 11;
	    case obj_save:
	        return 12;
	    case obj_platform:
	        return 13;
	    case obj_water:
	        return 14;
	    case obj_water2:
	        return 15;
	    case obj_vine_l:
	        return 16;
	    case obj_vine_r:
	        return 17;
	    case obj_killer_block:
	        return 18;
	    case obj_bullet_blocker:
	        return 19;
	    case obj_player_start:
	        return 20;
	    case obj_warp:
	        return 21;
	    case obj_jump_refresher:
	        return 22;
	    case obj_water3:
	        return 23;
	    case obj_gravity_arrow_up:
	        return 24;
	    case obj_gravity_arrow_down:
	        return 25;
	    case obj_save_flip:
	        return 26;
	    case obj_mini_killer_block:
	        return 27;
	    default:
	        return -1;
	}
}

function jmap_id_to_index(saveid) {
	switch (saveid) {
	    case 1:
	        return obj_block;
	    case 2:
	        return obj_mini_block;
	    case 3:
	        return obj_spike_up;
	    case 4:
	        return obj_spike_right;
	    case 5:
	        return obj_spike_left;
	    case 6:
	        return obj_spike_down;
	    case 7:
	        return obj_mini_spike_up;
	    case 8:
	        return obj_mini_spike_right;
	    case 9:
	        return obj_mini_spike_left;
	    case 10:
	        return obj_mini_spike_down;
	    case 11:
	        return obj_apple;
	    case 12:
	        return obj_save;
	    case 13:
	        return obj_platform;
	    case 14:
	        return obj_water;
	    case 15:
	        return obj_water2;
	    case 16:
	        return obj_vine_l;
	    case 17:
	        return obj_vine_r;
	    case 18:
	        return obj_killer_block;
	    case 19:
	        return obj_bullet_blocker;
	    case 20:
	        return obj_player_start;
	    case 21:
	        return obj_warp;
	    case 22:
	        return obj_jump_refresher;
	    case 23:
	        return obj_water3;
	    case 24:
	        return obj_gravity_arrow_up;
	    case 25:
	        return obj_gravity_arrow_down;
	    case 26:
	        return obj_save_flip;
	    case 27:
	        return obj_mini_killer_block;
	    default:
	        return noone;
	}
}

function index_to_rmj_id(objectindex) {
	switch (objectindex) {
	    case obj_block:
	        return 2;
	    case obj_spike_up:
	        return 12;
	    case obj_spike_right:
	        return 11;
	    case obj_spike_left:
	        return 10;
	    case obj_spike_down:
	        return 9;
	    case obj_mini_spike_up:
	        return 19;
	    case obj_mini_spike_right:
	        return 18;
	    case obj_mini_spike_left:
	        return 17;
	    case obj_mini_spike_down:
	        return 16;
	    case obj_apple:
	        return 20;
	    case obj_save:
	        return 32;
	    case obj_platform:
	        return 31;
	    case obj_water:
	        return 23;
	    case obj_water2:
	        return 30;
	    case obj_vine_l:
	        return 29;
	    case obj_vine_r:
	        return 28;
	    case obj_killer_block:
	        return 27;
	    case obj_player_start:
	        return 3;
	    default:
	        return -1;
	}
}

function rmj_id_to_index(saveid) {
	switch (saveid) {
	    case 2:
			return obj_block;
	    case 12:
	        return obj_spike_up;
	    case 11:
	        return obj_spike_right;
	    case 10:
	        return obj_spike_left;
	    case 9:
	        return obj_spike_down;
	    case 19:
	        return obj_mini_spike_up;
	    case 18:
	        return obj_mini_spike_right;
	    case 17:
	        return obj_mini_spike_left;
	    case 16:
	        return obj_mini_spike_down;
	    case 32:
	        return obj_save;
	    case 31:
	        return obj_platform;
	    case 23:
	        return obj_water;
	    case 30:
	        return obj_water2;
	    case 20:
	        return obj_apple;
	    case 27:
	        return obj_killer_block;
	    case 28:
	        return obj_vine_r;
	    case 29:
	        return obj_vine_l;
	    case 3:
	        return obj_player_start;
	}
}