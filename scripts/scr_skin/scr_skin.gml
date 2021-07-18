function Skin() constructor {
	name = "Default";
	spike_frames = 1;
	spike_animspeed = 0;
	minispike_frames = 1;
	minispike_animspeed = 0;
	killer_idle_color = make_color_hsv(0, 0, 255);
	killer_active_color = make_color_hsv(0, 128, 255);
	bulletblocker_alpha = 0.3;
	
	bg_type = BG_TYPE_STRETCH;
	bg_hspeed = 0;
	bg_vspeed = 0;
	button_idle_color = make_color_hsv(0, 0, 175);
	button_active_color = make_color_hsv(0, 0, 255);
	button_palette_pressed_color = make_color_hsv(0, 0, 0);
	button_palette_pressed_alpha = 0.5;
	button_active_alpha = 0.5;
	button_active_border = 0;
	
	spikeup = sprite_duplicate(spr_spike_up_default);
	spikedown = sprite_duplicate(spr_spike_down_default);
	spikeleft = sprite_duplicate(spr_spike_left_default);
	spikeright = sprite_duplicate(spr_spike_right_default);
	
	miniup = sprite_duplicate(spr_mini_spike_up_default);
	minidown = sprite_duplicate(spr_mini_spike_down_default);
	minileft = sprite_duplicate(spr_mini_spike_left_default);
	miniright = sprite_duplicate(spr_mini_spike_right_default);
	
	apple = sprite_duplicate(spr_apple_default);
	block = sprite_duplicate(spr_edit_block_default);
	miniblock = sprite_duplicate(spr_edit_mini_block_default);
	save = sprite_duplicate(spr_save_default);
	
	platform = sprite_duplicate(spr_platform_default);
	jumprefresher = sprite_duplicate(spr_jump_refresher_default);
	walljumpL = sprite_duplicate(spr_walljump_l_default);
	walljumpR = sprite_duplicate(spr_walljump_r_default);
	
	water1 = sprite_duplicate(spr_water1_default);
	water2 = sprite_duplicate(spr_water2_default);
	water3 = sprite_duplicate(spr_water3_default);
	bulletblocker = sprite_duplicate(spr_bullet_blocker_default);
	
	warp = sprite_duplicate(spr_warp_default);
	playerstart = sprite_duplicate(spr_player_start_default);
	popup = sprite_duplicate(spr_popup_default);
	background = sprite_duplicate(bg_background_default);
	sidebar = sprite_duplicate(spr_sidebar_default);
	
	load_sprite = function(fname, spr, def, image_num = noone) {
		if (file_exists(fname)) {
			var num = (image_num == noone) ? sprite_get_number(def) : image_num;
			sprite_replace(spr, fname, num, 0, 0, sprite_get_xoffset(spr), sprite_get_yoffset(spr));
		} else {
			if (spr != def)
				sprite_assign(spr, def);
		}
	}
	
	load = function(skin_name) {
		name = skin_name;
		
		var dir = get_working_directory() + "skins/" + skin_name + "/";
		var ini = dir + "skin_config.ini";
		ini_open(ini);
		
		// load ui section
		button_idle_color = ini_read_color_hsv("ui", "button_idle_color", global.default_skin.button_idle_color);
		button_active_color = ini_read_color_hsv("ui", "button_active_color", global.default_skin.minispike_animspeed);
		button_palette_pressed_color = ini_read_color_hsv("ui", "button_palette_pressed_color", global.default_skin.button_palette_pressed_color);
		button_palette_pressed_alpha = ini_read_real("ui", "button_palette_pressed_alpha", global.default_skin.button_palette_pressed_alpha);
		button_active_alpha = ini_read_real("ui", "button_active_alpha", global.default_skin.button_active_alpha);
		button_active_border = ini_read_real("ui", "button_active_border", global.default_skin.button_active_border);
		
		// load objects section
		killer_idle_color = ini_read_color_hsv("objects", "killer_idle_color", global.default_skin.killer_idle_color);
		killer_active_color = ini_read_color_hsv("objects", "killer_active_color", global.default_skin.killer_active_color);
		bulletblocker_alpha = ini_read_real("objects", "bulletblocker_alpha", global.default_skin.bulletblocker_alpha);
		spike_frames = ini_read_real("objects", "spike_frames", global.default_skin.spike_frames);
		spike_animspeed = ini_read_real("objects", "spike_animspeed", global.default_skin.spike_animspeed);
		minispike_frames = ini_read_real("objects", "minispike_frames", global.default_skin.minispike_frames);
		minispike_animspeed = ini_read_real("objects", "minispike_animspeed", global.default_skin.minispike_animspeed);
		
		// load bg section
		var type = ini_read_string("bg", "type", global.default_skin.bg_type);
		if (type == "tile")
			bg_type = BG_TYPE_TILE;
		else if (type == "stretch")
			bg_type = BG_TYPE_STRETCH;
		bg_type = real(bg_type);
		bg_hspeed = ini_read_real("bg", "hspeed", global.default_skin.bg_hspeed);
		bg_vspeed = ini_read_real("bg", "vspeed", global.default_skin.bg_vspeed);
		
		ini_close();
		
		// load sprites
		load_sprite(dir + "spikeup.png", spikeup, spr_spike_up_default, spike_frames);
		load_sprite(dir + "spikedown.png", spikedown, spr_spike_down_default, spike_frames);
		load_sprite(dir + "spikeleft.png", spikeleft, spr_spike_left_default, spike_frames);
		load_sprite(dir + "spikeright.png", spikeright, spr_spike_right_default, spike_frames);
		load_sprite(dir + "apple.png", apple, spr_apple_default);
		load_sprite(dir + "block.png", block, spr_edit_block_default);
		load_sprite(dir + "miniblock.png", miniblock, spr_edit_mini_block_default);
		load_sprite(dir + "save.png", save, spr_save_default);
		load_sprite(dir + "platform.png", platform, spr_platform_default);
		load_sprite(dir + "jumprefresher.png", jumprefresher, spr_jump_refresher_default);
		load_sprite(dir + "walljumpL.png", walljumpL, spr_walljump_l_default);
		load_sprite(dir + "walljumpR.png", walljumpR, spr_walljump_r_default);
		load_sprite(dir + "minileft.png", minileft, spr_mini_spike_left_default, minispike_frames);
		load_sprite(dir + "miniright.png", miniright, spr_mini_spike_right_default, minispike_frames);
		load_sprite(dir + "miniup.png", miniup, spr_mini_spike_up_default, minispike_frames);
		load_sprite(dir + "minidown.png", minidown, spr_mini_spike_down_default, minispike_frames);
		load_sprite(dir + "water1.png", water1, spr_water1_default);
		load_sprite(dir + "water2.png", water2, spr_water2_default);
		load_sprite(dir + "water3.png", water3, spr_water3_default);
		load_sprite(dir + "bulletblocker.png", bulletblocker, spr_bullet_blocker_default);
		load_sprite(dir + "warp.png", warp, spr_warp_default);
		load_sprite(dir + "playerstart.png", playerstart, spr_player_start_default);
		load_sprite(dir + "popup.png", popup, spr_popup_default);
		load_sprite(dir + "bg.png", background, bg_background_default);
		load_sprite(dir + "sidebar.png", sidebar, spr_sidebar_default);	
	}
	
	apply = function() {
		global.current_skin = self;
		
		// apply bg
		var bg = layer_get_id("Bg");
		if (bg_type == BG_TYPE_TILE) {
			layer_background_htiled(bg, 1);
			layer_background_vtiled(bg, 1);
			layer_background_stretch(bg, 0);
		} else {
			layer_background_htiled(bg, 0);
			layer_background_vtiled(bg, 0);
			layer_background_stretch(bg, 1);
		}
		layer_hspeed(bg, bg_hspeed);
		layer_vspeed(bg, bg_vspeed);
		layer_x(bg, 0);
		layer_y(bg, 0);
		
		// apply sprites
		sprite_assign(spr_spike_up, spikeup);
		sprite_assign(spr_spike_down, spikedown);
		sprite_assign(spr_spike_left, spikeleft);
		sprite_assign(spr_spike_right, spikeright);
		
		sprite_assign(spr_mini_spike_up, miniup);
		sprite_assign(spr_mini_spike_down, minidown);
		sprite_assign(spr_mini_spike_left, minileft);
		sprite_assign(spr_mini_spike_right, miniright);
		
		sprite_assign(spr_apple, apple);
		sprite_assign(spr_edit_block, block);
		sprite_assign(spr_edit_mini_block, miniblock);
		sprite_assign(spr_save, save);
		
		sprite_assign(spr_platform, platform);
		sprite_assign(spr_jump_refresher, jumprefresher);
		sprite_assign(spr_walljump_l, walljumpL);
		sprite_assign(spr_walljump_r, walljumpR);
		
		sprite_assign(spr_water1, water1);
		sprite_assign(spr_water2, water2);
		sprite_assign(spr_water3, water3);
		sprite_assign(spr_bullet_blocker, bulletblocker);
		
		sprite_assign(spr_warp, warp);
		sprite_assign(spr_player_start, playerstart);
		sprite_assign(spr_popup, popup);
		sprite_assign(bg_background, background);
		sprite_assign(spr_sidebar, sidebar);
		
		// apply objects
		with (obj_player_killer) {
			if (is_color_killer(object_index))
				image_blend = other.killer_idle_color;
		}
	}
	
	destroy = function() {
		sprite_delete(spikeup);
		sprite_delete(spikedown);
		sprite_delete(spikeleft);
		sprite_delete(spikeright);
		sprite_delete(apple);
		sprite_delete(block);
		sprite_delete(miniblock);
		sprite_delete(save);
		sprite_delete(platform);
		sprite_delete(jumprefresher);
		sprite_delete(walljumpL);
		sprite_delete(walljumpR);
		sprite_delete(minileft);
		sprite_delete(miniright);
		sprite_delete(miniup);
		sprite_delete(minidown);
		sprite_delete(water1);
		sprite_delete(water2);
		sprite_delete(water3);
		sprite_delete(bulletblocker);
		sprite_delete(warp);
		sprite_delete(playerstart);
		sprite_delete(popup);
		sprite_delete(background);
		sprite_delete(sidebar);
	}
}