event_inherited();

var w = 50;
var h = 50;
var dx = w + 8;
var dy = h + 8;

// normal spikes
var xx = 0;
var yy = 0;
control.add_child(new PaletteItem(xx, yy, w, h, spr_spike_up, obj_spike_up));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_spike_down, obj_spike_down));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_spike_left, obj_spike_left));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_spike_right, obj_spike_right));

// mini spikes
xx = 0;
yy += dy;
control.add_child(new PaletteItem(xx, yy, w, h, spr_mini_spike_up, obj_mini_spike_up));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_mini_spike_down, obj_mini_spike_down));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_mini_spike_left, obj_mini_spike_left));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_mini_spike_right, obj_mini_spike_right));

// block & apple
xx = 0;
yy += dy;
control.add_child(new PaletteItem(xx, yy, w, h, spr_edit_block, obj_block));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_edit_mini_block, obj_mini_block));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_platform, obj_platform));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_apple, obj_apple));

// water & vine
xx = 0;
yy += dy;
control.add_child(new PaletteItem(xx, yy, w, h, spr_water2, obj_water2));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_water3, obj_water3));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_walljump_r, obj_vine_r));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_walljump_l, obj_vine_l));

// jump refresher & save & player start
xx = 0;
yy += dy;
control.add_child(new PaletteItem(xx, yy, w, h, spr_jump_refresher, obj_jump_refresher));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_save, obj_save));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_player_start, obj_player_start));

xx += dx;
control.add_child(new PaletteItem(xx, yy, w, h, spr_ellipsis, noone, function() {
	moreobjs.disabled = !moreobjs.disabled;
}));

// more objects
yy += dy - 8;
moreobjs = control.add_child(new Panel(-8, yy, 240, 124));
moreobjs.color = make_color_rgb(215, 215, 215);
moreobjs.disabled = true;

xx = 8;
yy = 8;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_warp, obj_warp));

xx += dx;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_killer_block, obj_killer_block));

xx += dx;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_water1, obj_water));

xx += dx;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_bullet_blocker, obj_bullet_blocker));

xx = 8;
yy += dy;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_gravity_arrow_up, obj_gravity_arrow_up));

xx += dx;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_gravity_arrow_down, obj_gravity_arrow_down));

xx += dx;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_save_flip, obj_save_flip));

xx += dx;
moreobjs.add_child(new PaletteItem(xx, yy, w, h, spr_pink32, obj_trg));
