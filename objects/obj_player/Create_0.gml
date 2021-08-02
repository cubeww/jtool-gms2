/// @description Initialize kid variables
hsp = 0;
vsp = 0;
grav = 0.4 * global.player_grav;
djump = true;
jump = 8.5;
jump2 = 7;
max_hsp = 3;
max_vsp = 9;
xprev = x;
yprev = y;
on_platform = false;
image_speed = 0.5;
sprite_index = spr_player_idle;

if (global.player_grav == 1) {
    mask_index = spr_player_mask;
} else {
    mask_index = spr_player_mask_flip;
}

// dotkid
dotkid_check = function() {
    if (global.dotkid && mask_index != spr_dotkid) {
        mask_index = spr_dotkid;
    } else if (!global.dotkid && mask_index == spr_dotkid) {
        mask_index = spr_player_mask;
    }
}

dotkid_check();
