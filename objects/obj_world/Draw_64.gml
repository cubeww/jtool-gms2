/// @description DEBUG text
draw_set_alpha(1);
draw_set_color(c_red);
draw_set_halign(fa_left);
draw_text(32, 32, "inst: "+string(instance_count));
draw_text(32, 48, "fps: "+string(fps));
draw_text(32, 64, "fps_real: "+string(fps_real));
