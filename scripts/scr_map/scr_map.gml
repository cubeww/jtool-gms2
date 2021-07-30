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
	objects = [];
	
	//---------------------------------------------------------------------------
	// save / load methods
	//---------------------------------------------------------------------------
	
	save_current = function() {
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
		array_clear(objects);
		with (all) {
			if (!object_in_palette(object_index)) 
				continue;
			var maxpos = 896;
			var minpos = -128;
			if (x >= maxpos || y >= maxpos || x < minpos || y < minpos)
			    continue;
			array_push(other.objects, new MapObject(x, y, object_index));
		}
		
		// sort objects y
		var len = array_length(objects);
		for (var i = 0; i < len; i++) {
			for (var j = 0; j < len - i - 1; j++) {
				if (objects[j].y > objects[j + 1].y) {
					array_swap(objects, j, j + 1);
				}
			}
		}
	}
	
	apply = function() {
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
		var len = array_length(objects);
		for (var i = 0; i < len; i++) {
			var obj = objects[i];
			instance_create_layer(obj.x, obj.y, palette_object_get_layer(obj.index), obj.index);
		}
		global.current_save.load();
	}
		
	// rmj save / load
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
		var len = array_length(objects);
		for (var i = 0; i < len; i++) {
			var obj = objects[i];
		    var rmjcode = index_to_rmj_id(obj.index);
		    if (rmjcode == -1) {
		        if (object_in_palette(obj.index))
					continue;
		    }
		    file_text_write_string(f, " " + string(obj.x) + " " + string(obj.y) + " " + string(rmjcode));
		}
		file_text_close(f);
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
		array_clear(objects);
		while (!file_text_eoln(f)) {
		    var xx = file_text_read_real(f);
		    var yy = file_text_read_real(f);
		    var type = file_text_read_real(f);
		    array_push(objects, new MapObject(xx, yy, rmj_id_to_index(type)));
		    if (file_text_eoln(f))
		        break;
		}
		file_text_close(f);

		inf_jump = false;
		dotkid = false;
		save_type = SAVETYPE_SHOOT;
		border_type = BORDER_DEATH;
	}
		
	// jtool 1.x map save / load
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
		var len = array_length(objects);
		for (var i = 0, yy = pointer_null; i < len; i++) {
			var obj = objects[i];
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
					array_clear(objects);
					for (var objstr = string_extract(v, "-", 1), p = 1; objstr != ""; objstr = string_extract(v, "-", ++p)) {
						var i = 1;
						var yy = base32_string_to_int(string_copy(objstr, i, 2));
						i += 2;
						while (i <= string_length(objstr)) {
							var objid = jmap_id_to_index(base32_string_to_int(string_copy(objstr, i, 1)));
							var xx = base32_string_to_int(string_copy(objstr, i + 1, 2));
							array_push(objects, new MapObject(xx - 128, yy - 128, objid));
							i += 3;
						}
					}
					break;
			}
		}
	}

	// jtool-gms2 map save / load (binary format)
	save_map = function(filename) {
		var buf = buffer_create(0, buffer_grow, 1);
		buffer_write_fixed(buf, buffer_string, "JTOOLMAP");
		buffer_write_fixed(buf, buffer_string, "BETA");
		buffer_write_fixed(buf, buffer_string, "inf");
		buffer_write_fixed(buf, buffer_u8, infjump);
		buffer_write_fixed(buf, buffer_string, "dot");
		buffer_write_fixed(buf, buffer_u8, dotkid);
		buffer_write_fixed(buf, buffer_string, "sav");
		buffer_write_fixed(buf, buffer_u8, save_type);
		buffer_write_fixed(buf, buffer_string, "bor");
		buffer_write_fixed(buf, buffer_u8, border_type);
		buffer_write_fixed(buf, buffer_string, "px");
		buffer_write_fixed(buf, buffer_f32, player_x);
		buffer_write_fixed(buf, buffer_string, "py");
		buffer_write_fixed(buf, buffer_f32, player_y);
		buffer_write_fixed(buf, buffer_string, "ps");
		buffer_write_fixed(buf, buffer_s8, player_xscale);
		buffer_write_fixed(buf, buffer_string, "pg");
		buffer_write_fixed(buf, buffer_s8, player_grav);
		
		buffer_write_fixed(buf, buffer_string, "objs");
		var objs = buffer_create(0, buffer_grow, 1);
		var num = array_length(objects);
		buffer_write_fixed(objs, buffer_s32, num);
		for (var i = 0; i < num; i++) {
			var o = objects[i];
			buffer_write_fixed(objs, buffer_s16, o.x);
			buffer_write_fixed(objs, buffer_s16, o.y);
			buffer_write_fixed(objs, buffer_u16, o.index);
		}
		buffer_write_buffer(buf, objs, true);
		
		buffer_save(buf, filename);
	}
	load_map = function(filename) {
		var buf = buffer_load(filename);
		while (buffer_tell(buf) < buffer_get_size(buf)) {
			var key = buffer_read(buf, buffer_string);
			switch (key) {
				case "inf":
					inf_jump = buffer_read(buf, buffer_u8);
					break;
				case "dot":
					dotkid = buffer_read(buf, buffer_u8);
					break;
				case "sav":
					save_type = buffer_read(buf, buffer_u8);
					break;
				case "bor":
					border_type = buffer_read(buf, buffer_u8);
					break;
				case "px":
					player_x = buffer_read(buf, buffer_f32);
					break;
				case "py":
					player_y = buffer_read(buf, buffer_f32);
					break;
				case "ps":
					player_xscale = buffer_read(buf, buffer_s8);
					break;
				case "pg":
					player_grav = buffer_read(buf, buffer_s8);
					break;
				case "objs":
					array_clear(objects);
					var objs = buffer_read_buffer(buf, true);
					var num = buffer_read(objs, buffer_s32);
					
					for (var i = 0; i < num; i++) {
						var xx = buffer_read(objs, buffer_s16);
						var yy = buffer_read(objs, buffer_s16);
						var index = buffer_read(objs, buffer_u16);
						var obj = new MapObject(xx, yy, index);
						array_push(objects, obj);
					}
					break;
			}
		}
	}
	
	//---------------------------------------------------------------------------
	// GameMaker exporter
	//---------------------------------------------------------------------------
	
	save_gm8 = function() {
		// reference: 
		// https://github.com/WastedMeerkat/gm81decompiler/blob/master/decompiler/gmk.cpp 
		
		var namefile = get_open_filename("Name File|*.json", "");
		if (namefile == "")
		    exit;
    
		var f = file_text_open_read(namefile);
		var str = file_text_read_string_all(f);
		file_text_close(f);

		var namemap = json_decode(str);
		if (namemap == -1) {
			show_message("Wrong Name File !");
			exit;
		}
		
		var filename = get_open_filename("GM8 Project (*.gmk, *.gm81)|*.gmk;*.gm81", "");
		if (filename == "")
		    exit;
    
		var mapname = get_string("Enter the new room name", "room");
		if (mapname == "")
		    exit;
			
		var file = buffer_load(filename);

		var indexmap = ds_map_create();
		
		var newfile = buffer_create(buffer_get_size(file), buffer_grow, 1);
		
		// check magic number
		if (buffer_read_and_write(file, newfile, buffer_s32) != 1234321) {
			show_message("Wrong GM8 File !");
			exit;
		}
		
		// check version
		var ver = buffer_read_and_write(file, newfile, buffer_s32);
		if (ver != 800 && ver != 810) {
			show_message("Wrong GM8 File !");
			exit;
		}
		
		// game id and guid
		for (var i = 0; i < 5; i++) {
		    buffer_read_and_write(file, newfile, buffer_s32);
		}
		
		// skip everything we don"t need
		// settings
		buffer_read_and_write(file, newfile, buffer_s32); // version
		buffer_read_and_write_buffer(file, newfile, false); // settings data

		// triggers
		buffer_read_and_write(file, newfile, buffer_s32); // version
		var count = buffer_read_and_write(file, newfile, buffer_s32); // trigger count
		for (var i = 0; i < count; i++) {
		    buffer_read_and_write_buffer(file, newfile, false); // trigger data
		}
		buffer_read_and_write(file, newfile, buffer_f64); // last changed double

		// constants
		buffer_read_and_write(file, newfile, buffer_s32); // version
		var count = buffer_read_and_write(file, newfile, buffer_s32); // constant count
		for (var i = 0; i < count; i++) {
		    buffer_write_pascal_string(newfile, buffer_read_pascal_string(file)); // trigger data
			buffer_write_pascal_string(newfile, buffer_read_pascal_string(file)); // trigger data
		}
		buffer_read_and_write(file, newfile, buffer_f64); // last changed double

		// sound, sprite, background, path, script, font, timeline
		for (var i = 0; i < 7; i++) {
		    buffer_read_and_write(file, newfile, buffer_s32); // version
		    var count = buffer_read_and_write(file, newfile, buffer_s32); // asset count
		    for (var j = 0; j < count; j++) {
		        buffer_read_and_write_buffer(file, newfile, false); // asset data
		    }
		}
		
		// object
		// we need to get their index
		buffer_read_and_write(file, newfile, buffer_s32); // version
		var count = buffer_read_and_write(file, newfile, buffer_s32); // object count
		for (var i = 0; i < count; i++) {
		    var obj = buffer_read_and_write_buffer(file, newfile, true); // object data
			
		    if (buffer_read(obj, buffer_s32) == 0) {
				// object has been deleted 
		        continue;
		    }
    
		    var name = buffer_read_pascal_string(obj);
    
		    // find name in the namemap
		    for (var j = ds_map_find_first(namemap); 
					!is_undefined(ds_map_find_value(namemap, j)); 
					j = ds_map_find_next(namemap, j)) {
		        var value = namemap[? j];
		        if (name == value) {
		            indexmap[? j] = i;
		        }
		    }
		}
		// room 
		// check version
		if (buffer_read_and_write(file, newfile, buffer_s32) != 800) {
		    show_message("error while reading room chunk !");
		    exit;
		}

		// origin room count
		var roomcount = buffer_read(file, buffer_s32); // room count

		// we will add a new room, so we add 1 to new room chunk
		buffer_write_fixed(newfile, buffer_s32, roomcount + 1);

		// write origin data to new room chunk
		for (var i = 0; i < roomcount; i++) {
		    buffer_read_and_write_buffer(file, newfile, false);
		}

		var newroomindex = roomcount;

		// now we reached the end of room chunk, add a new room
		// new room chunk
		var newroom = buffer_create(0, buffer_grow, 1);
		buffer_write_fixed(newroom, buffer_s32, 1); // is room vaild

		buffer_write_pascal_string(newroom, mapname); // room name
		buffer_write_fixed(newroom, buffer_f64, 0);         // lastchanged double
		buffer_write_fixed(newroom, buffer_s32, 541);       // version header

		buffer_write_pascal_string(newroom, "");      // caption
		buffer_write_fixed(newroom, buffer_s32, 800); // width
		buffer_write_fixed(newroom, buffer_s32, 608); // height
		buffer_write_fixed(newroom, buffer_s32, 32);  // snap X
		buffer_write_fixed(newroom, buffer_s32, 32);  // snap Y

		buffer_write_fixed(newroom, buffer_s32, 0);  // on "◇" grid
		buffer_write_fixed(newroom, buffer_s32, 50); // room speed
		buffer_write_fixed(newroom, buffer_s32, 0);  // persistent
		buffer_write_fixed(newroom, buffer_s32, 0);  // bg color
		buffer_write_fixed(newroom, buffer_s32, 0);  // bg color draw
		buffer_write_pascal_string(newroom, "");      // room creation code

		// background
		buffer_write_fixed(newroom, buffer_s32, 8); // always 8
		for (var i = 0; i < 8; i++)
		{
		    buffer_write_fixed(newroom, buffer_s32, 1);  // visible
		    buffer_write_fixed(newroom, buffer_s32, 0);  // foreground
		    buffer_write_fixed(newroom, buffer_s32, -1); // bgindex
		    buffer_write_fixed(newroom, buffer_s32, 0);  // x
		    buffer_write_fixed(newroom, buffer_s32, 0);  // y
		    buffer_write_fixed(newroom, buffer_s32, 1);  // tileh
		    buffer_write_fixed(newroom, buffer_s32, 1);  // tilev
		    buffer_write_fixed(newroom, buffer_s32, 0);  // vspeed
		    buffer_write_fixed(newroom, buffer_s32, 0);  // hspeed
		    buffer_write_fixed(newroom, buffer_s32, 0);  // stretch
		}

		// view
		buffer_write_fixed(newroom, buffer_s32, 1); // enable view
		buffer_write_fixed(newroom, buffer_s32, 8); // always 8
		for (var i = 0; i < 8; i++)
		{
		    buffer_write_fixed(newroom, buffer_s32, i == 0); // visible
		    buffer_write_fixed(newroom, buffer_s32, 0);      // view x
		    buffer_write_fixed(newroom, buffer_s32, 0);      // view y
		    buffer_write_fixed(newroom, buffer_s32, 800);    // view w
		    buffer_write_fixed(newroom, buffer_s32, 608);    // view h
		    buffer_write_fixed(newroom, buffer_s32, 0);      // port x
		    buffer_write_fixed(newroom, buffer_s32, 0);      // port y
		    buffer_write_fixed(newroom, buffer_s32, 800);    // port w
		    buffer_write_fixed(newroom, buffer_s32, 608);    // port h
		    buffer_write_fixed(newroom, buffer_s32, 400);    // hborder
		    buffer_write_fixed(newroom, buffer_s32, 304);    // vborder
		    buffer_write_fixed(newroom, buffer_s32, 0);      // hspeed
		    buffer_write_fixed(newroom, buffer_s32, 0);      // vspeed
		    buffer_write_fixed(newroom, buffer_s32, -1);     // follow object
		}

		// instance
		
		// get instance count
		var num = 0;
		for (var i = 0; i < array_length(objects); i++) {
			var o = objects[i];
			if (!ds_map_exists(indexmap, object_get_name(o.index)))
				continue;
			num++;
		}
		
		// write instance data
		buffer_write_fixed(newroom, buffer_s32, num);
		var oid = 100001;
		for (var i = 0; i < array_length(objects); i++) {
			var o = objects[i];
			if (!ds_map_exists(indexmap, object_get_name(o.index)))
				continue;
				
			buffer_write_fixed(newroom, buffer_s32, o.x); // instance x          
		    buffer_write_fixed(newroom, buffer_s32, o.y); // instance y          
		    buffer_write_fixed(newroom, buffer_s32, indexmap[? object_get_name(o.index)]); // object index        
		    buffer_write_fixed(newroom, buffer_s32, oid); // instance id
		    buffer_write_pascal_string(newroom, ""); // instance creation code    
		    buffer_write_fixed(newroom, buffer_s32, 0); // locked         
    
		    oid += 1;
		}

		// tile
		// make a tile system sometime? skip now
		buffer_write_fixed(newroom, buffer_s32, 0); // tile count

		// maker settings
		buffer_write_fixed(newroom, buffer_s32, 0);   // remember room editor info
		buffer_write_fixed(newroom, buffer_s32, 800); // editor width
		buffer_write_fixed(newroom, buffer_s32, 608); // editor height
		buffer_write_fixed(newroom, buffer_s32, 1);   // show grid
		buffer_write_fixed(newroom, buffer_s32, 1);   // show obj
		buffer_write_fixed(newroom, buffer_s32, 1);   // show tile
		buffer_write_fixed(newroom, buffer_s32, 1);   // show bg
		buffer_write_fixed(newroom, buffer_s32, 1);   // show fg
		buffer_write_fixed(newroom, buffer_s32, 1);   // show view
		buffer_write_fixed(newroom, buffer_s32, 1);   // delete underlying obj
		buffer_write_fixed(newroom, buffer_s32, 1);   // delete underlying tile
		buffer_write_fixed(newroom, buffer_s32, 0);   // tab
		buffer_write_fixed(newroom, buffer_s32, 0);   // xpos scroll
		buffer_write_fixed(newroom, buffer_s32, 0);   // ypos scroll

		buffer_write_buffer(newfile, newroom, true); // write to new file
		
		buffer_read_and_write(file, newfile, buffer_s32); // last instance id
		buffer_read_and_write(file, newfile, buffer_s32); // last tile id
		
		// included file
		buffer_read_and_write(file, newfile, buffer_s32); // version
		var count = buffer_read_and_write(file, newfile, buffer_s32); // included file count
		for (var i = 0; i < count; i++) {
		    buffer_read_and_write_buffer(file, newfile, false); // included file data
		}

		// packages
		buffer_read_and_write(file, newfile, buffer_s32); // version
		var count = buffer_read_and_write(file, newfile, buffer_s32); // package count
		for (var i = 0; i < count; i++) {
		    buffer_read_and_write_buffer(file, newfile, false); // package data
		}

		// game information
		buffer_read_and_write(file, newfile, buffer_s32); // version
		buffer_read_and_write_buffer(file, newfile, false); // game information data
		
		// lib creation code
		buffer_read_and_write(file, newfile, buffer_s32); // version
		var count = buffer_read_and_write(file, newfile, buffer_s32); // lib creation code count
		for (var i = 0; i < count; i++) {
		    buffer_read_and_write_buffer(file, newfile, false); // lib creation code data
		}
		
		// room order
		buffer_read_and_write(file, newfile, buffer_s32); // version
		var count = buffer_read_and_write(file, newfile, buffer_s32); // room order count
		for (var i = 0; i < count; i++) {
		    buffer_read_and_write(file, newfile, buffer_s32); // room order data
		}
		
		// resource tree
		// status: 1 = resource group, 2 = normal group, 3 = resource
		// group: 1 = objects group, 2 = sprites group, 3 = sounds group, 4 = rooms group, 6 = backgrounds group, 
		//        7 = scripts group, 8 = paths group, 9 = fonts group, 10 = game information, 11 = global game settings, 
		//        12 = timelines group, 13 = extension packages

		for (var i = 0; i < 12; i++) {
		    buffer_read_and_write(file, newfile, buffer_s32); // status
		    buffer_read_and_write(file, newfile, buffer_s32); // group
		    buffer_read_and_write(file, newfile, buffer_s32); // index
			
		    var name = buffer_read_pascal_string(file); // name
		    buffer_write_pascal_string(newfile, name); 
			
		    var isrooms = false;
		    if (name == "Rooms") {
		        isrooms = true;
			}
    
		    var count = buffer_read(file, buffer_s32); // child count
		    buffer_write_fixed(newfile, buffer_s32, count + isrooms);
		    read_tree_children(file, count, newfile);
		    if (isrooms) {
				// add a new room to resource tree
		        buffer_write_fixed(newfile, buffer_s32, 3);            // status
		        buffer_write_fixed(newfile, buffer_s32, 4);            // group
		        buffer_write_fixed(newfile, buffer_s32, newroomindex); // index
		        buffer_write_pascal_string(newfile, mapname);          // name
		        buffer_write_fixed(newfile, buffer_s32, 0);            // child count
		    }
		}
		
		// write a backup
		if (file_exists(filename + ".bak")) {
			file_delete(filename + ".bak");
		}
		buffer_save(file, filename + ".bak");
		
		// write to file
		file_delete(filename);
		buffer_save(newfile, filename);
	}
		
	save_gms = function() {
		var namefile = get_open_filename("Name File|*.json", "");
		if (namefile == "")
		    exit;
    
		var f = file_text_open_read(namefile);
		var str = file_text_read_string_all(f);
		file_text_close(f);

		var namemap = json_decode(str);
		if (namemap == -1)
		{
		    show_message("Wrong name file !");   
		    exit;
		}

		var filename = get_save_filename("GMS1 Room (*.room.gmx)|*.room.gmx", "");
		if (filename == "")
		    exit;

		DerpXmlWrite_New();
		DerpXmlWrite_Config("    ", chr(10));

		DerpXmlWrite_Comment("This Document is generated by Jtool-GMS2, if you edit it by hand then you do so at your own risk!");
		DerpXmlWrite_OpenTag("room");
		    DerpXmlWrite_OpenTag("width");
		        DerpXmlWrite_Text("800");
		    DerpXmlWrite_CloseTag();
    
		    DerpXmlWrite_OpenTag("height");
		        DerpXmlWrite_Text("608");
		    DerpXmlWrite_CloseTag();
    
		    DerpXmlWrite_OpenTag("speed");
		        DerpXmlWrite_Text("50");
		    DerpXmlWrite_CloseTag();
    
		    DerpXmlWrite_OpenTag("vsnap");
		        DerpXmlWrite_Text("32");
		    DerpXmlWrite_CloseTag();
    
		    DerpXmlWrite_OpenTag("hsnap");
		        DerpXmlWrite_Text("32");
		    DerpXmlWrite_CloseTag();
    
		    DerpXmlWrite_OpenTag("enableViews");
		        DerpXmlWrite_Text("-1");
		    DerpXmlWrite_CloseTag();
    
		    DerpXmlWrite_OpenTag("views");
		        DerpXmlWrite_LeafElement("view", "");
		        DerpXmlWrite_Attribute("visible", "-1");
		        DerpXmlWrite_Attribute("objName", "&lt;undefined&gt;");
		        DerpXmlWrite_Attribute("xview", "0");
		        DerpXmlWrite_Attribute("yview", "0");
		        DerpXmlWrite_Attribute("wview", "800");
		        DerpXmlWrite_Attribute("hview", "608");
		        DerpXmlWrite_Attribute("xport", "0");
		        DerpXmlWrite_Attribute("yport", "0");
		        DerpXmlWrite_Attribute("wport", "800");
		        DerpXmlWrite_Attribute("hport", "608");
		        DerpXmlWrite_Attribute("hborder", "400");
		        DerpXmlWrite_Attribute("vborder", "304");
		        DerpXmlWrite_Attribute("hspeed", "-1");
		        DerpXmlWrite_Attribute("vspeed", "-1");
		    DerpXmlWrite_CloseTag();
    
		    DerpXmlWrite_OpenTag("instances");
		        for (var i = 0; i < array_length(objects); i++) {
					var o = objects[i];
		            if (!ds_map_exists(namemap, object_get_name(o.index)))
		                continue;
                
		            DerpXmlWrite_LeafElement("instance", "");;
		            DerpXmlWrite_Attribute("objName", ds_map_find_value(namemap, object_get_name(o.index)));
		            DerpXmlWrite_Attribute("x", string(o.x));
		            DerpXmlWrite_Attribute("y", string(o.y));
		            DerpXmlWrite_Attribute("name", "inst_" + random_instance_id());
		            DerpXmlWrite_Attribute("locked", "0");
		            DerpXmlWrite_Attribute("code", "");
		            DerpXmlWrite_Attribute("scaleX", "1");
		            DerpXmlWrite_Attribute("scaleY", "1");
		            DerpXmlWrite_Attribute("colour", "4294967295");
		            DerpXmlWrite_Attribute("rotation", "0");
		        }
		    DerpXmlWrite_CloseTag();
		DerpXmlWrite_CloseTag();
    
		var xml_string = DerpXmlWrite_GetString();
		DerpXmlWrite_UnloadString();

		var f = file_text_open_write(filename);
		file_text_write_string(f, xml_string);
		file_text_close(f);
	}
		
	save_gms2 = function() {
		var namefile = get_open_filename("Name File|*.json", "");
		if (namefile == "")
		    exit;
    
		var f = file_text_open_read(namefile);
		var str = file_text_read_string_all(f);
		file_text_close(f);

		var namemap = json_decode(str);
		if (namemap == -1) {
		    show_message("Wrong name file !");   
		    exit;
		}
		
		var filename = get_open_filename("GMS2 Room (*.yy)|*.yy", "");
		if (filename == "")
		    exit;
			
		// get room path
		var namelen = string_length(filename_name(filename));
		var roompath = string_copy(filename, 
				string_length(filename) - 3 - 2 * namelen, 
				2 * namelen + 11);	
			
		var str = get_gms2_template(0);
		// write instances
		var inst_ids = [];
		for (var i = 0; i < array_length(objects); ++i) {
			var o = objects[i];
			if (!ds_map_exists(namemap, object_get_name(o.index)))
				continue;
				
			var _path = namemap[? object_get_name(o.index)]
			var pos = string_last_pos("/", _path);
			var _name = string_copy(_path, pos + 1, string_last_pos(".", _path) - pos - 1);
			
			var inst_id = "inst_" + random_instance_id();
			str += "{\"properties\":[],\"isDnd\":false,\"objectId\":{\"name\":\"" + _name + "\",\"path\":\"" + _path + "\",},\"inheritCode\":false,\"hasCreationCode\":false,\"colour\":4294967295,\"rotation\":0.0,\"scaleX\":1.0,\"scaleY\":1.0,\"imageIndex\":0,\"imageSpeed\":1.0,\"inheritedItemId\":null,\"frozen\":false,\"ignore\":false,\"inheritItemSettings\":false,\"x\":" + string(o.x) + ",\"y\":" + string(o.y) + ",\"resourceVersion\":\"1.0\",\"name\":\"" + inst_id + "\",\"tags\":[],\"resourceType\":\"GMRInstance\",},";
			array_push(inst_ids, inst_id);
		}
		// write instances order
		str += get_gms2_template(1);
		for (var i = 0; i < array_length(inst_ids); ++i) {
			var o = inst_ids[i];
			str += "{\"name\":\"" + o + "\",\"path\":\"" + string_replace_all(roompath, @"\", "/") + "\",},";
		}
		
		// save to file
		str += get_gms2_template(2);
		var f = file_text_open_write(filename);
		file_text_write_string(f, str);
		file_text_close(f);
	}
	
}

function read_tree_children(file, _count, newfile) {
	for (var i = 0; i < _count; i++) {
	    buffer_read_and_write(file, newfile, buffer_s32); // status
	    buffer_read_and_write(file, newfile, buffer_s32); // group
	    buffer_read_and_write(file, newfile, buffer_s32); // index
	    var name = buffer_read_pascal_string(file);       // name
	    buffer_write_pascal_string(newfile, name);
	    var count = buffer_read_and_write(file, newfile, buffer_s32); // child count
	    
	    read_tree_children(file, count, newfile);
	}
}

function random_instance_id() {
	str = "";
	repeat (8) {
	    n = irandom_range(0, 15);
	    if (n > 9) {
	        str += chr(55 + n);
	    } else {
	        str += string(n);
	    }
	}
	return str;
}

function MapObject(_x, _y, _index) constructor {
	x = _x;
	y = _y;
	index = _index;
}
