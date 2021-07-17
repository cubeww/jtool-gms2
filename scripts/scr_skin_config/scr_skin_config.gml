function SkinConfig(_rx = 0, _ry = 0, _w = 400, _h = 225) : Control(_rx, _ry, _w, _h) constructor {
	rx = (room_width - _w) / 2;
	ry = (room_height - _h) / 2;
	panel = add_child(new Panel(0, 0, _w, _h));
	panel.color = make_color_rgb(225, 225, 225);
	skin_names = ds_list_create();
	list_w = 200;
	lb_skin_names = add_child(new ListBox(0, 0, list_w - 20, _h));
	lb_skin_names.show_count = 10;
	lb_skin_names.add_item("Default");
	lb_skin_names.add_item("K3S5");
	lb_skin_names.add_item("CN2");
	lb_skin_names.add_item("CN3");
	
	lbl_preview = add_child(new Label(list_w + 8, 8, "Preview", fa_left, fa_top));
	
	btn_close = add_child(new Button(0, 0, 40, 25, "X", noone, destroy));
	btn_close.rx = w - btn_close.w;	
	
	btn_apply = add_child(new Button(0, 0, _w - list_w - 16, 32, "Apply"));
	btn_apply.rx = list_w + 8;
	btn_apply.ry = _h - 8 - btn_apply.h;
	
	slider = add_child(new SlideBar(list_w - 20 + 2, 0, 20, _h));

	global.state = GLOBALSTATE_POPUP;
	
	black_alpha = 0;
	TweenFire(self, EaseOutQuad, TWEEN_MODE_ONCE, false, 0, 50, "black_alpha", 0, 0.5);
	
	preview = add_control(Control);
	apple_index = 0;
	
	on_step = function() {
		apple_index += 1 / 15;
	}
	
	on_draw = function() {
		// draw black background
		draw_set_color(c_black);
		draw_set_alpha(alpha * black_alpha);
		draw_rectangle(0, 0, room_width, room_height, 0);
	}
	
	preview.on_draw = function() {
		// draw preview
		draw_set_alpha(alpha);
		var xo = x + list_w + 8;
		var yo = y + 40;
		
		var block = 32;
		
		var xx = xo;
		var yy = yo;
		
		yy += block;
		draw_sprite(spr_spike_left, 0, xx, yy);
		xx += block;
		draw_sprite(spr_edit_block, 0, xx, yy);
		yy -= block;
		draw_sprite(spr_spike_up, 0, xx, yy);
		yy += block * 2;
		draw_sprite(spr_spike_down, 0, xx, yy);
		yy -= block;
		xx += block;
		draw_sprite(spr_spike_right, 0, xx, yy);
		xx += block;
		draw_sprite(spr_apple, floor(apple_index), xx+16, yy+16);
		xx += block;
		draw_sprite(spr_jump_refresher, 0, xx+16, yy+16);
		xx -= block;
		yy += block;
		draw_sprite(spr_save, 0, xx, yy);
		xx += block;
		draw_sprite(spr_platform, 0, xx, yy);
		yy -= block * 2;
		draw_sprite(spr_edit_block, 0, xx, yy);
		draw_sprite(spr_walljump_l, 0, xx, yy);
		xx -= block;
		draw_sprite(spr_edit_block, 0, xx, yy);
		draw_sprite(spr_walljump_r, 0, xx, yy);
	}
}