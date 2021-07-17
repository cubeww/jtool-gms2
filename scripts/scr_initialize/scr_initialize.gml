#macro GLOBALSTATE_IDLE 0
#macro GLOBALSTATE_MENU 1
#macro GLOBALSTATE_POPUP 2

#macro SAVETYPE_Z 0
#macro SAVETYPE_SHOOT 1

function game_initialize() {
	window_set_caption("jtool-gms2");
	room_speed = 50;
	
	global.state = GLOBALSTATE_IDLE;
	global.death_enable = true;
	global.save_type = SAVETYPE_Z;
	
	global.player_xscale = 1;
	global.player_grav = 1;
	
	global.save_player_x = noone;
	global.save_player_y = noone;
	global.save_player_grav = 1;
	global.save_player_xscale = 1;
}