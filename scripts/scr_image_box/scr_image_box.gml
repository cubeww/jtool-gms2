function ImageBox(_rel_x = 0, _rel_y = 0, _w = 64, _h = 64, _image = noone, _index = 0): Control(_rel_x, _rel_y, _w, _h) constructor {
    // properties
    image = _image;
    index = _index;

    // methods
    on_draw = function() {
        draw_set_alpha(alpha);
        var xscale = w / sprite_get_width(image);
        var yscale = h / sprite_get_height(image);
        draw_sprite_ext(image, index,
            x + sprite_get_xoffset(image) * xscale,
            y + sprite_get_yoffset(image) * yscale,
            xscale,
            yscale,
            0, c_white, 1);
    }
}