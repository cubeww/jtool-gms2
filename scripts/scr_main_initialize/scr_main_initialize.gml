#macro GLOBALSTATE_IDLE 0
#macro GLOBALSTATE_MENU 1
#macro GLOBALSTATE_POPUP 2

#macro SAVETYPE_Z 0
#macro SAVETYPE_SHOOT 1

#macro BG_TYPE_TILE 0
#macro BG_TYPE_STRETCH 1

#macro BORDER_DEATH 0
#macro BORDER_SOLID 1

function main_initialize() {
	DerpXml_Init();
	
	global.project_directory = @"D:\Projects\GMS2\jtool\bin";
	
	window_set_caption("jtool-gms2");
	room_speed = 50;
	
	global.state = GLOBALSTATE_IDLE;
	global.save_type = SAVETYPE_Z;
	global.water_lock = false;
	
	global.player_xscale = 1;
	global.player_grav = 1;
	global.dotkid = false;
	global.infjump = false;
	global.border_type = BORDER_DEATH;
	
	global.current_save = new Save();
	
	global.default_skin = new Skin();
	global.current_skin = new Skin();
	
	global.current_map = new Map();
	
	global.config = new Config();
	global.config.load();
}