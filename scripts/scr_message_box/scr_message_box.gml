function MessageBox(_text = ""): Control(0, 0, 320, 130) constructor {
    // properties
    rel_x = room_width / 2 - w / 2;
    rel_y = room_height / 2 - h / 2;

    // fields
    panel = add_child(new Panel(0, 0, w, h));

    lbl = panel.add_child(new Label(w / 2, 32, _text, fa_center, fa_top));

    btn_ok = panel.add_child(new Button(0, 0, 130, 32, "OK", noone, destroy));
    btn_ok.rel_x = w / 2 - btn_ok.w / 2;
    btn_ok.rel_y = h - btn_ok.h - 8;

    btn_close = panel.add_child(new Button(0, 0, 40, 25, "X", noone, destroy));
    btn_close.rel_x = w - btn_close.w;
    btn_close.rel_y = 0;

    // methods
    on_draw = function() {
        // draw black screen
        draw_set_alpha(alpha * 0.5);
        draw_set_color(c_black);
        draw_rectangle_wh(0, 0, room_width, room_height, 0);
    }
}