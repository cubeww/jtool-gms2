/// @description Classic kid physics  
// set x / y previous
xprev = x;
yprev = y;

// keyboard check
var L = keyboard_check_direct(vk_left);
var R = keyboard_check_direct(vk_right);

var h = 0;
if (R) { 
	h = 1; 
} else if (L) { 
	h = -1; 
}

// set horizontal speed 
if (h != 0) {
	global.player_xscale = h;
	sprite_index = spr_player_running;
    image_speed = 0.5;
} else {
	sprite_index = spr_player_idle;
    image_speed = 0.2;
}
hsp = max_hsp * h;

if (!on_platform) {
	if (vsp * global.player_grav < -0.05) {
        sprite_index = spr_player_jump;
    } else if (vsp * global.player_grav > 0.05) {
        sprite_index = spr_player_fall;
    }
} 
if (distance_to_object(obj_bullet) <= (abs(global.player_xscale * 64)) && instance_number(obj_bullet) > 0) {
    sprite_index = spr_player_shoot;
    image_speed = 0.2;
} else if (!place_meeting(x, y + 4 * global.player_grav, obj_platform)) { 
	on_platform = false; 
}
    
// limit vertical speed 
if (abs(vsp) > max_vsp) { 
	vsp = sign(vsp) * max_vsp; 
}

// water
if (place_meeting(x, y, obj_water)) {
    vsp = min(abs(vsp), 2) * global.player_grav;
    
    if (place_meeting(x, y, obj_water2)) { 
        djump = true;
    } 
}

// jump
if (keyboard_check_pressed(vk_shift)) {
    if (place_meeting(x, y + 1 * global.player_grav, obj_block) || place_meeting(x, y + 1 * global.player_grav, obj_platform) || on_platform) {
        audio_play_sound(snd_jump, 0, 0);
		vsp = -jump * global.player_grav;
        djump = true;
    } else if (djump || place_meeting(x, y, obj_water)) {
		audio_play_sound(snd_djump, 0, 0);
		sprite_index = spr_player_jump;
        vsp = -jump2 * global.player_grav;
        if (!place_meeting(x, y, obj_water2)) { 
			djump = false; 
		} else { 
			djump = true; 
		}
    }
}

if (keyboard_check_released(vk_shift)) {
    if (vsp * global.player_grav < 0) { 
		vsp *= 0.45; 
	}
}

// shoot
if (keyboard_check_pressed(ord("Z")) && !keyboard_check(vk_control)) {
	if (instance_number(obj_bullet) < 4) {
	    var b = instance_create_layer(x, y, palette_object_get_layer(obj_bullet), obj_bullet);
	    b.hspeed = global.player_xscale * 16;
	    audio_play_sound(snd_shoot, 0, 0);
	}
}

// vine
var not_on_block, on_vineL, on_vineR;
not_on_block = !place_meeting(x, y + 1 * global.player_grav, obj_block);
on_vineL = place_meeting(x - 1, y, obj_vine_l) && not_on_block;
on_vineR = place_meeting(x + 1, y, obj_vine_r) && not_on_block;
if (on_vineL || on_vineR) {
	if (on_vineL) {
		global.player_xscale = 1;
	} else {
		global.player_xscale = -1;
	}
	
    vsp = 2 * global.player_grav;
	
	sprite_index = spr_player_sliding;
    image_speed = 0.5;
	
    if ((on_vineL && keyboard_check_pressed(vk_right)) || (on_vineR && keyboard_check_pressed(vk_left))) {
        if (keyboard_check(vk_shift)) {
            if (on_vineR) { 
				hsp = -15; 
			} else { 
				hsp = 15; 
			}
            vsp = -9 * global.player_grav;
			sprite_index = spr_player_jump;
        } else {
            if (on_vineR) { 
				hsp = -3; 
			} else { 
				hsp = 3; 
			}
			sprite_index = spr_player_fall;
        }
    }
}

// movement
vsp += grav;
x += hsp;
y += vsp;

// block collision
var dir;
if place_meeting(x, y, obj_block) {
    x = xprev;
    y = yprev;
     
    if (place_meeting(x + hsp, y, obj_block)) {
        dir = sign(hsp);
        while (!place_meeting(x + dir, y, obj_block)) { 
			x += dir; 
		}
        hsp = 0;
    }
    if (place_meeting(x, y + vsp, obj_block)) {
        dir = sign(vsp);
        while (!place_meeting(x, y + dir, obj_block)) { 
			y += dir; 
		}
        if (vsp * global.player_grav > 0) { 
			djump = true; 
		}
        vsp = 0;
    }
    if (place_meeting(x + hsp, y + vsp * global.player_grav, obj_block)) { 
		hsp = 0; 
	}
    
    x += hsp;
    y += vsp;
    if (place_meeting(x, y, obj_block)) {
        x = xprev;
        y = yprev; 
    }
}

// platform collision
var pf = instance_place(x, y, obj_platform);
if (pf != noone) {
	if (global.player_grav == 1) {
	    if (y - vsp / 2 <= pf.y) {
	        y = pf.y - 9;
	        vsp = 0;
        
	        on_platform = true;
	        djump = true;
	    }
	} else {
		if (y - vsp / 2 >= pf.y + pf.sprite_height - 1) {
	        y = pf.y + pf.sprite_height + 8;
	        vsp = 0;
        
	        on_platform = true;
	        djump = true;
	    }
	}
}

// gravity arrow
function flip_grav() {
	global.player_grav *= -1;
	grav = 0.4 * global.player_grav;
    djump = 1;
    vsp = 0;

    if (global.player_grav == 1) {
        mask_index = spr_player_mask;
    } else {
        mask_index = spr_player_mask_flip;
    }

    y += 4 * global.player_grav;
}

if (place_meeting(x, y, obj_gravity_arrow_up)) {
	if (global.player_grav == 1) {
		flip_grav();
	}
}

if (place_meeting(x, y, obj_gravity_arrow_down)) {
	if (global.player_grav == -1) {
		flip_grav();
	}
}

// save
var save = instance_place(x, y, obj_save);
if (save != noone) {
	if (global.player_grav == 1 && save.can_save) {
	    if (keyboard_check_pressed(ord("Z"))) {
			save.image_index = 1;
			save.alarm[0] = 30;
			save.alarm[1] = 59;
			save.can_save = false;
			
			global.save_player_x = x;
			global.save_player_y = y;
			global.save_player_grav = global.player_grav;
			global.save_player_xscale = global.player_xscale;
		}
	}
}

// killer collision
var k = instance_place(x, y, obj_player_killer);
if (k != noone) {
	audio_play_sound(snd_death, 0, 0);
	with (k) {
		TweenEasyBlend(make_color_rgb(255, 105, 105), c_white, 0, 50, EaseOutExpo);
	}
	
	repeat (200)
		instance_create_layer(x, y, palette_object_get_layer(obj_blood),obj_blood);
	instance_destroy();
}


