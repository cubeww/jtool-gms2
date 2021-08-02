function Panel(_rel_x = 0, _rel_y = 0, _w = 128, _h = 128): Control(_rel_x, _rel_y, _w, _h) constructor {
    // properties
    border_color = c_black;

    // methods
    on_draw = function() {
        // background color
        draw_set_alpha(alpha);
        draw_sprite_stretched(spr_popup, 0, x, y, w, h);

        // border
        draw_set_color(border_color);
        draw_rectangle_wh(x, y, w, h, 1);
    }
}