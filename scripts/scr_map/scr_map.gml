function Map() constructor {
	// metadata
	infjump = false;
	dotkid = false;
	save_type = SAVETYPE_SHOOT;
	border_type = BORDER_DEATH;
	player_x = 0;
	player_y = 0;
	player_xscale = 1;
	player_grav = 1;
	objects = ds_list_create();
	
	// save methods
	save_map = function() {
		// save metadata
		infjump = global.infjump;
		dotkid = global.dotkid;
		save_type = global.save_type;
		border_type = global.border_type;
		player_x = global.current_save.x;
		player_y = global.current_save.y;
		player_xscale = global.current_save.xscale;
		player_grav = global.current_save.grav;
		
		// save objects
		ds_list_clear(objects);
		with (all) {
			if (!object_in_palette(object_index)) 
				continue;
			var maxpos = 896;
			var minpos = -128;
			if (x >= maxpos || y >= maxpos || x < minpos || y < minpos)
			    continue;
			ds_list_add(other.objects, new MapObject(x, y, object_index));
		}
		
		// sort objects y
		var len = ds_list_size(objects);
		for (var i = 0; i < len; i++) {
			for (var j = 0; j < len - i - 1; j++) {
				if (objects[| j].y > objects[| j + 1].y) {
					ds_list_swap(objects, j, j + 1);
				}
			}
		}
	}
	
	save_rmj = function(filename) {
		// header 
		var f = file_text_open_write(filename);
		file_text_write_string(f, " 1.030000");
		file_text_writeln(f);
		file_text_write_string(f, "Imported from jtool-gms2");
		file_text_writeln(f);
		file_text_write_string(f, "someone");
		file_text_writeln(f);

		// objects 
		var len = ds_list_size(objects);
		for (var i = 0; i < len; i++) {
			var obj = objects[| i];
		    var rmjcode = index_to_rmj_id(obj.index);
		    if (rmjcode == -1) {
		        if (object_in_palette(obj.index))
					continue;
		    }
		    file_text_write_string(f, " " + string(obj.x) + " " + string(obj.y) + " " + string(rmjcode));
		}
		file_text_close(f);
	}
	save_jmap = function(filename) {
		var f = file_text_open_write(filename);
		var delim = "|";
		
		// write metadata
		file_text_write_string(f, "jtool");
		file_text_write_string(f, delim);
		file_text_write_string(f, "1.3.5");
		file_text_write_string(f, delim);
		file_text_write_string(f, "inf:" + string(infjump));
		file_text_write_string(f, delim);
		file_text_write_string(f, "dot:" + string(dotkid));
		file_text_write_string(f, delim);
		file_text_write_string(f, "sav:" + string(save_type));
		file_text_write_string(f, delim);
		file_text_write_string(f, "bor:" + string(border_type));
		file_text_write_string(f, delim);
		file_text_write_string(f, "px:" + float_to_base32_string(player_x));
		file_text_write_string(f, delim);
		file_text_write_string(f, "py:" + float_to_base32_string(player_y));
		file_text_write_string(f, delim);
		file_text_write_string(f, "ps:" + string(player_xscale));
		file_text_write_string(f, delim);
		file_text_write_string(f, "pg:" + string(player_grav));
		
		// write objects
		file_text_write_string(f, delim);
		file_text_write_string(f, "objects:");
		var len = ds_list_size(objects);
		for (var i = 0, yy = pointer_null; i < len; i++) {
			var obj = objects[| i];
			if (yy != obj.y) {
				yy = obj.y;
				file_text_write_string(f, "-" + pad_string_left(int_to_base32_string(obj.y + 128), 2, "0"));
			}
			var objid = index_to_jmap_id(obj.index);
			if (objid != -1) {
				file_text_write_string(f, 
						int_to_base32_string(objid) + pad_string_left(int_to_base32_string(obj.x + 128), 2, "0"));
			}
		}
		
		file_text_close(f);
	}
	save_jmx = function(filename) {}
	
	save_gm8 = function(filename) {}
	save_gms = function(filename) {}
	save_gms2 = function(filename) {}
	
	// load methods
	load_map = function() {
		// load metadata
		global.infjump = infjump;
		global.dotkid = dotkid;
		global.save_type = save_type;
		global.border_type = border_type;
		global.current_save.x = player_x;
		global.current_save.y = player_y;
		global.current_save.xscale = player_xscale;
		global.current_save.grav = player_grav;
		
		// load objects
		with (all) {
			if (object_in_palette(object_index))
				instance_destroy();
		}
		var len = ds_list_size(objects);
		for (var i = 0; i < len; i++) {
			var obj = objects[| i];
			instance_create_layer(obj.x, obj.y, palette_object_get_layer(obj.index), obj.index);
		}
		global.current_save.load();
	}
	
	load_rmj = function(filename) {
		var f = file_text_open_read(filename);
		var firstline = file_text_read_string(f);
		if (firstline != " 1.030000")
		{
		    file_text_close(f);
		    exit;
		}
		file_text_readln(f);
		file_text_readln(f);
		file_text_readln(f);
		ds_list_clear(objects);
		while (!file_text_eoln(f)) {
		    var xx = file_text_read_real(f);
		    var yy = file_text_read_real(f);
		    var type = file_text_read_real(f);
		    ds_list_add(objects, new MapObject(xx, yy, rmj_id_to_index(type)));
		    if (file_text_eoln(f))
		        break;
		}
		file_text_close(f);

		inf_jump = false;
		dotkid = false;
		save_type = SAVETYPE_SHOOT;
		border_type = BORDER_DEATH;
	}
	load_jmap = function(filename) {
		var f = file_text_open_read(filename);
		var str = file_text_readln(f);
		file_text_close(f);
		for (var content = string_extract(str, "|", 0), pos = 0; content != ""; content = string_extract(str, "|", ++pos)) {
			if (string_pos(":", content) == 0)
				continue;
				
			var k = string_extract(content, ":", 0);
			var v = string_extract(content, ":", 1);
			switch (k) {
				case "inf":
					infjump = real(v);
					break;
				case "dot":
					dotkid = real(v);
					break;
				case "sav":
					save_type = real(v);
					break;
				case "bor":
					border_type = real(v);
					break;
				case "px":
					player_x = base32_string_to_float(v);
					break;
				case "py":
					player_y = base32_string_to_float(v);
					break;
				case "ps":
					player_xscale = real(v);
					break;
				case "pg":
					player_grav = real(v);
					break;
				case "objects":
					ds_list_clear(objects);
					for (var objstr = string_extract(v, "-", 1), p = 1; objstr != ""; objstr = string_extract(v, "-", ++p)) {
						var i = 1;
						var yy = base32_string_to_int(string_copy(objstr, i, 2));
						i += 2;
						while (i <= string_length(objstr)) {
							var objid = jmap_id_to_index(base32_string_to_int(string_copy(objstr, i, 1)));
							var xx = base32_string_to_int(string_copy(objstr, i + 1, 2));
							ds_list_add(objects, new MapObject(xx - 128, yy - 128, objid));
							i += 3;
						}
					}
					break;
			}
		}
	}
	load_jmx = function(filename) {}
}

function MapObject(_x, _y, _index) constructor {
	x = _x;
	y = _y;
	index = _index;
}

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