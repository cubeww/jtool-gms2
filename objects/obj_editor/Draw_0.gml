if (global.state == GLOBALSTATE_IDLE && cursor_in_area && !drag_held && !picker_held && !code_held) {
	var blend = c_white;
	if (is_color_killer(selected_object)) {
		blend = global.current_skin.killer_idle_color;
	}
	draw_sprite_ext(selected_sprite, 0, xsnapped, ysnapped, 1, 1, 0, blend, 0.3);
}