function TextBox(_rel_x = 0, _rel_y = 0, _w = 100, _h = 40) : Control(_rel_x, _rel_y, _w, _h) constructor {
    tte_ext_input_create();
    tte_ext_input_set_font(font_small);
    tte_ext_input_set_multiline(false);
    tte_ext_input_set_text_color(c_black, 1);
    tte_ext_input_set_size(w, h);
    tte_ext_input_set_background_color(c_white, 0);

    // methods
    on_step = function() {
        tte_ext_input_step();
    }

    on_draw = function() {
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        
        // draw background
        draw_set_alpha(1);
        draw_set_color(global.current_skin.button_idle_color);
        draw_rectangle_wh(x, y, width, height, false);
        draw_set_alpha(global.current_skin.button_active_alpha);
        draw_set_color(global.current_skin.button_active_color);
        draw_rectangle_wh(x, y, width, height, false);

        // draw text box
        tte_ext_input_draw();
        
        // draw border
        draw_set_alpha(1);
        draw_set_color(c_black);
        draw_rectangle_wh(x, y, width, height, true);
    }
}