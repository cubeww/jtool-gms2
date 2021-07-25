function SkinConfig(_rx = 0, _ry = 0, _w = 400, _h = 225) : Control(_rx, _ry, _w, _h) constructor {
	rx = (room_width - _w) / 2;
	ry = (room_height - _h) / 2;
	panel = add_child(new Panel(0, 0, _w, _h));
	panel.color = make_color_rgb(225, 225, 225);
	list_w = 200;
	lst_skin_names = add_child(new ListBox(0, 0, list_w - 20 - 1, _h));
	lst_skin_names.show_count = 10;
	lst_skin_names.add_item("(Default)");
	lst_skin_names.select = 0;
	
	preview = add_control(Control);
	skin = pointer_null;
	
	btn_close = add_child(new Button(0, 0, 40, 25, "X", noone, function() {
		global.state = last_state;
		if (skin != pointer_null && skin != global.default_skin) {
			skin.destroy();
		}
		destroy();
	}));
	btn_close.rx = w - btn_close.w;	
	
	btn_apply = add_child(new Button(0, 0, _w - list_w - 16, 32, "Apply", spr_menu_skin));
	btn_apply.rx = list_w + 8;
	btn_apply.ry = _h - 8 - btn_apply.h;
	
	slider = add_child(new SlideBar(list_w - 20, 0, 20, _h, function() {
		lst_skin_names.start_index = max(0, 
		floor((ds_list_size(lst_skin_names.list) - lst_skin_names.show_count) * slider.pos));
	}));

	last_state = global.state;
	global.state = GLOBALSTATE_POPUP;
	
	black_alpha = 0.5;
	
	apple_index = 0;
	spike_index = 0;
	spike_speed = 0;
	bg_type = BG_TYPE_STRETCH;
	killer_color = c_white;
	
	// read skin names
	var ini = get_working_directory() + "skins/skins.ini";
	ini_open(ini);
	var names = ini_read_string("skins", "names", "");
	if (names != "") {
		for (var i = 0, name = string_extract(names, ",", 0); name != ""; name = string_extract(names, ",", ++i)) {
			lst_skin_names.add_item(name);
		}
	}
	ini_close();
	
	show_preview = function() {
		// load skin file
		if (skin != pointer_null && skin != global.default_skin) {
			skin.destroy();
		}
		var name = lst_skin_names.get_select_item();
		if (lst_skin_names.select != 0) {
			skin = new Skin();
			skin.load(name);
		} else {
			skin = global.default_skin;
		}

		spike_speed = skin.spike_animspeed;
		bg_type = skin.bg_type;
		killer_color = skin.killer_idle_color;
		// update preview sprites
		sprite_assign(spr_spike_up_preview, skin.spikeup)
		sprite_assign(spr_spike_down_preview, skin.spikedown);
		sprite_assign(spr_spike_left_preview, skin.spikeleft);
		sprite_assign(spr_spike_right_preview, skin.spikeright);
		sprite_assign(spr_apple_preview, skin.apple);
		sprite_assign(spr_edit_block_preview, skin.block);
		sprite_assign(spr_save_preview, skin.save);
		sprite_assign(spr_platform_preview, skin.platform);
		sprite_assign(spr_jump_refresher_preview, skin.jumprefresher);
		sprite_assign(spr_walljump_l_preview, skin.walljumpL);
		sprite_assign(spr_walljump_r_preview, skin.walljumpR);
		sprite_assign(bg_background_preview, skin.background);
	}
	lst_skin_names.on_click = show_preview;
	show_preview();
	
	apply_skin = function() {
		skin.apply();
		global.config.save();
		if (skin != global.default_skin) {
			skin.destroy();
		}
		global.state = last_state;
		destroy();
	}
	btn_apply.on_click = apply_skin;
	
	on_step = function() {
		apple_index += 1 / 15;
		spike_index += spike_speed;
	}
	
	on_draw = function() {
		// draw black background
		draw_set_color(c_black);
		draw_set_alpha(alpha * black_alpha);
		draw_rectangle(0, 0, room_width, room_height, 0);
	}
	
	preview.on_draw = function() {
		// draw preview
		draw_set_alpha(alpha);

		var xo = x + list_w + 8;
		var yo = y + 40;
		
		var block = 32;
		
		var xx = xo;
		var yy = yo;
		
		// draw bg
		if (bg_type == BG_TYPE_STRETCH)
			draw_sprite_stretched(bg_background_preview, 0, x + list_w, y + 1, w - list_w, h - 1);
		else
			draw_sprite_tiled_area(bg_background_preview, 0, 0, 0, x + list_w, y + 1, x + w - 1, y + h - 1);
		
		draw_set_font(fa_left);
		draw_set_font(fa_top);
		draw_text_outline(x + list_w + 8, y + 16, "Preview", c_white, c_black);
		
		yy += block;
		draw_sprite_ext(spr_spike_left_preview, floor(spike_index), xx, yy, 1, 1, 0, killer_color, 1);
		xx += block;
		draw_sprite(spr_edit_block_preview, 0, xx, yy);
		yy -= block;
		draw_sprite_ext(spr_spike_up_preview, floor(spike_index), xx, yy, 1, 1, 0, killer_color, 1);
		yy += block * 2;
		draw_sprite_ext(spr_spike_down_preview, floor(spike_index), xx, yy, 1, 1, 0, killer_color, 1);
		yy -= block;
		xx += block;
		draw_sprite_ext(spr_spike_right_preview, floor(spike_index), xx, yy, 1, 1, 0, killer_color, 1);
		xx += block;
		draw_sprite_ext(spr_apple_preview, floor(apple_index), xx+16, yy+16, 1, 1, 0, killer_color, 1);
		xx += block;
		draw_sprite(spr_jump_refresher_preview, 0, xx+16, yy+16);
		xx -= block;
		yy += block;
		draw_sprite(spr_save_preview, 0, xx, yy);
		xx += block;
		draw_sprite(spr_platform_preview, 0, xx, yy);
		yy -= block * 2;
		draw_sprite(spr_edit_block_preview, 0, xx, yy);
		draw_sprite(spr_walljump_l_preview, 0, xx, yy);
		xx -= block;
		draw_sprite(spr_edit_block_preview, 0, xx, yy);
		draw_sprite(spr_walljump_r_preview, 0, xx, yy);
	}
}
