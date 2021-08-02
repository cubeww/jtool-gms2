function PaletteItem(_rel_x, _rel_y, _w, _h, _spr, _obj, _on_click = pointer_null): Control(_rel_x, _rel_y, _w, _h) constructor {
    spr = _spr;
    obj = _obj;

    border = true;
    border_color = c_black;

    on_click = _on_click;
    flash_alpha = 0;

    // methods
    on_step = function() {
        if (point_in_rectangle(mouse_x, mouse_y, x, y, x + w, y + h)) {
            enter = true;
            if (mouse_check_button_pressed(mb_left)) {
                // toggle selected object
                if (obj != noone) {
                    obj_editor.selected_object = obj;
                    obj_editor.selected_sprite = spr;
                }

                // create flash effect
                TweenFire(self, EaseInOutQuad, TWEEN_MODE_ONCE, false, 0, room_speed / 5, "flash_alpha", 1, 0);

                if (on_click != pointer_null)
                    on_click();
            }
        } else {
            enter = false;
        }
    }

    on_draw = function() {
        draw_set_alpha(alpha);

        // background color
        draw_set_color(global.current_skin.button_idle_color);
        draw_rectangle_wh(x, y, w, h, 0);
        if (enter) {
            draw_set_alpha(alpha * global.current_skin.button_active_alpha);
            draw_set_color(global.current_skin.button_active_color);
            draw_rectangle_wh(x, y, w, h, 0);
        }

        // sprite
        var blend = c_white;
        if (is_color_killer(obj)) {
            blend = global.current_skin.killer_idle_color;
        }
        draw_sprite_ext(spr, 0, x + sprite_get_xoffset(spr) + w / 2 - sprite_get_width(spr) / 2,
            y + sprite_get_yoffset(spr) + h / 2 - sprite_get_height(spr) / 2,
            1, 1, 0, blend, 1);

        // flash effect
        draw_set_alpha(alpha * global.current_skin.button_palette_pressed_alpha * flash_alpha);
        draw_set_color(global.current_skin.button_palette_pressed_color);
        draw_rectangle_wh(x, y, w, h, 0);

        // border
        draw_set_alpha(alpha);
        if (border) {
            draw_set_color(border_color);
            draw_rectangle_wh(x, y, w, h, 1);
        }
    }
}