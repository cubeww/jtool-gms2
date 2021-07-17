function Label(_rx = 0, _ry = 0, _text = "", _halign = fa_center, _valign = fa_middle, _color = c_black, _font = font_small) : Control(_rx, _ry, 32, 32) constructor {
	// properties
	halign = _halign;
	valign = _valign;

	font = _font;
	text = _text;

	color = _color;
	
	// methods
	on_draw = function() {
		draw_set_alpha(alpha);
		draw_set_font(font);
		draw_set_halign(halign);
		draw_set_valign(valign);
		draw_set_color(color);
		draw_text(x, y, text);
	}
}