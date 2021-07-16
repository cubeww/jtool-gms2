if (global.state == GLOBALSTATE_IDLE && cursor_in_area && !drag_held && !picker_held && !code_held) {
	draw_sprite_ext(selected_sprite, 0, xsnapped, ysnapped, 1, 1, 0, c_white, 0.3);
}