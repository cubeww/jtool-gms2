function tte_ext_input_get_text() {
	/// tte_ext_input_get_text()
	var l, lt, txt = "";
	for( l=0; l<ds_list_size( lines ); l++ ) {
	    if( txt != "" ) txt += "\n";
	    txt += lines[| l];
	}
	return txt;
}

function tte_ext_input_set_text() {
	/// tte_ext_input_set_text( text )
	var c,t,w,l;
	t = argument[0];
	l = ds_list_create();
	w = "";

	var p = string_pos( "\n", t );

	while( p > 0 ) {
	    ds_list_add( l, w + string_copy( t, 1, p ) );
	    t = string_copy( t, p+1, string_length( t ) - p  );
	    p = string_pos( "\n", t );
	}

	if( t != "" ) ds_list_add( l, t );

	ds_list_clear( lines );
	ds_list_destroy( lines );

	lines = l;

	var lastl = ds_list_size( lines )-1;
	tte_ext_move_cursor( lastl, string_length( lines[| lastl] )+1 );
}

function tte_ext_input_set_multiline() {
	/// tte_ext_input_set_multiline( multiline=true );
	if( argument_count > 0 ) multiline = argument[0];
	else multiline = true;
}

function tte_ext_input_set_size() {
	/// tte_ext_input_set_size( width, height )
	width = argument[0];
	height = argument[1];

	if( tte_surface != -1 ) surface_free( tte_surface );
	tte_surface = -1;
}

function tte_ext_input_set_padding() {
	/// tte_ext_input_set_padding( left, right, top, bottom );
	padding_left = argument[0];
	padding_top = argument[2];
	padding_right = argument[1];
	padding_bottom = argument[3];
}

function tte_ext_input_set_text_color() {
	/// tte_ext_input_set_text_color( color, alpha );
	fg = argument[0];
	fg_alpha = argument[1];
}

function tte_ext_input_set_background_color() {
	/// tte_ext_input_set_background_color( color, alpha );
	bg = argument[0];
	bg_alpha = argument[1];
}

function tte_ext_input_set_selection_color() {
	/// tte_ext_input_set_selection_color( color, alpha );
	sel = argument[0];
	sel_alpha = argument[1];
}

function tte_ext_input_set_font() {
	/// tte_ext_input_set_font( font );
	font = argument[0];
}

function tte_ext_input_set_on_changed() {
	/// tte_ext_input_set_on_changed( script )
	if( script_exists( argument[0] ) ) on_changed = argument[0];
}

function tte_ext_input_clear_on_changed() {
	/// tte_ext_input_clear_on_changed()
	on_changed = noone;
}

function tte_ext_input_get_surface() {
	/// tte_ext_input_get_surface()
	return tte_surface;
}

