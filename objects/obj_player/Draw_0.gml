/// @description Draw kid sprite

if (global.dotkid) {
	draw_sprite_ext(mask_index, image_index, x, y, 
			global.player_xscale, global.player_grav, 
			image_angle, image_blend, image_alpha);
	if (global.config.dotkid_outline) {
		draw_sprite_ext(spr_dotkid_outline, image_index, x, y + 8, 
				global.player_xscale, global.player_grav, 
				image_angle, image_blend, image_alpha);
	}
} else {
	switch (global.config.show_hitbox) {
		case 0:
			draw_sprite_ext(sprite_index, image_index, x, y, 
					global.player_xscale, global.player_grav, 
					image_angle, image_blend, image_alpha);
			break;
		case 1:
			draw_sprite_ext(sprite_index, image_index, x, y, 
					global.player_xscale, global.player_grav, 
					image_angle, image_blend, image_alpha);
			draw_sprite_ext(mask_index, image_index, x, y, 
					global.player_xscale, global.player_grav, 
					image_angle, image_blend, 0.5);
			break;
		case 2:
			draw_sprite_ext(mask_index, image_index, x, y, 
					global.player_xscale, global.player_grav, 
					image_angle, image_blend, image_alpha);
			break;
	} 
}