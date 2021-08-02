function __tte_ext_input_check_surface() {
	/// Check if surface exists
	if( !surface_exists( tte_surface ) ) {
	    tte_surface = surface_create( width - padding_left - padding_right, height - padding_top - padding_bottom );
	    update = true;
	}
}

function __tte_ext_input_handle_mouse() {
	/// Handle mouse

	var mx, my;
	mx = ( mouse_x - x - padding_left );
	my = ( mouse_y - y - padding_top );

	if( point_in_rectangle( mx, my, 0, 0, width-1, height-1 ) ) {
	    hover = true;
    
	    if( mouse_check_button( mb_left ) ) {
	        if( mouse_check_button_pressed( mb_left ) ) {
	            focus = true;
	            selDrag = false;
	            selVisible = false;
	            update = true;
	        }
	        if( hover_x != mx || hover_y != my && focus ) {
	            hover_x = mx;
	            hover_y = my;
            
	            tte_ext_handle_mouse_selection( mx+scrollx, my+scrolly );
	        }
	    }
	}
	else {
	    hover = false;
	    if( mouse_check_button_pressed( mb_left ) ) {
	        focus = false;
	        caretVisible = false;
	        caretTimer += caretDelay;
	        update = true;
	    }
    
	}
}

function __tte_ext_input_handle_keyboard() {
	/// Handle Keyboard
	if( focus ) {

	    var ctrl = keyboard_check( vk_control );
	    var alt = keyboard_check( vk_alt );
	    var shift = keyboard_check( vk_shift );
	    var changed = false;
    
	    if( keyboard_string != "" && !ctrl && !alt ) {
	        if( tte_ext_has_selection() ) tte_ext_selection_delete();
	        tte_ext_input_insert( keyboard_string );
	        keyboard_string = "";
	        forceCaret = true;
	        changed = true;
	    }
	    else if( keyboard_check_pressed( vk_anykey ) ) {
	        tte_ext_input_handle_key( keyboard_key, ctrl, alt, shift );
	        repeatKey = keyboard_key;
	        repeatTimer = current_time+repeatFirstDelay-repeatDelay;
        
	        switch( repeatKey ) {
	            case vk_backspace:
	            case vk_delete:
	            case vk_space:
	            case vk_enter:
	                changed = true;
	            break;
	        }
	    }
	    if( repeatKey != vk_nokey ) {
	        if( keyboard_check_released( repeatKey ) ) repeatKey = vk_nokey;
	        else if( keyboard_check( vk_anykey ) && repeatKey != vk_nokey ) {
	            if( current_time >= repeatTimer+repeatDelay ) {
	                tte_ext_input_handle_key( repeatKey, ctrl, alt, shift );
	                repeatTimer += repeatDelay;
	                switch( repeatKey ) {
	                    case vk_backspace:
	                    case vk_delete:
	                    case vk_space:
	                    case vk_enter:
	                        changed = true;
	                    break;
	                }
	            }
	        }
	    }
    
	    if( changed ) if( script_exists( on_changed ) ) script_execute( on_changed, tte_ext_input_get_text() );
	}
}

function __tte_ext_input_handle_caret() {
	/// Handle Caret
	if( focus ) {
	    if( forceCaret ) {
	        forceCaret = false;
	        caretTimer = current_time;
	        caretVisible = true;
	        update = true;
	    }
	    else if( current_time >= caretTimer+caretDelay ) {
	        caretVisible = !caretVisible;
	        caretTimer += caretDelay;
	        update = true;
	    }
	}
}

function tte_ext_input_handle_key() {
	var key = argument[0];
	var ctrl =  argument[1];
	var alt = argument[2];
	var shift = argument[3];

	switch( key ) {
	    case vk_left:
	        if( shift && !tte_ext_has_selection() ) tte_ext_set_selection_anchor( line, column );
	        tte_ext_move_cursor( 0, -1, true );
	        if( shift ) tte_ext_input_handle_selection( true );
	        else tte_ext_unselect();
	    break;
	    case vk_right:
	        if( shift && !tte_ext_has_selection() ) tte_ext_set_selection_anchor( line, column );
	        tte_ext_move_cursor( 0, 1, true );
	        if( shift ) tte_ext_input_handle_selection( true );
	        else tte_ext_unselect();
	    break;
	    case vk_up:
	        if( !multiline ) break;
	        if( shift && !tte_ext_has_selection() ) tte_ext_set_selection_anchor( line, column );
	        tte_ext_move_cursor( -1, 0, true );
	        if( shift ) tte_ext_input_handle_selection( true );
	        else tte_ext_unselect();
	    break;
	    case vk_down:
	        if( !multiline ) break;
	        if( shift && !tte_ext_has_selection() ) tte_ext_set_selection_anchor( line, column );
	        tte_ext_move_cursor( 1, 0, true );
	        if( shift ) tte_ext_input_handle_selection( true );
	        else tte_ext_unselect();
	    break;
	    case vk_home:
	        if( shift && !tte_ext_has_selection() ) tte_ext_set_selection_anchor( line, column );
	        tte_ext_move_cursor( line, 1 );
	        if( shift ) tte_ext_input_handle_selection( true );
	        else tte_ext_unselect();
	    break;
	    case vk_end:
	        if( shift && !tte_ext_has_selection() ) tte_ext_set_selection_anchor( line, column );
	        tte_ext_move_cursor( line, string_length( lines[| line] ) + 1 );
	        if( shift ) tte_ext_input_handle_selection( true );
	        else tte_ext_unselect();
	    break;
	    case vk_delete:
	        if( tte_ext_has_selection() ) tte_ext_selection_delete();
	        else {
	            if( column <= string_length( lines[| line] ) ) {
	                var wasHash = false;
	                if( wasHash ) lines[| line] = string_delete( lines[| line], column, 2 );
	                else lines[| line] = string_delete( lines[| line], column, 1 );
	            }
	            else if( line < ds_list_size( lines )-1 ) {
	                lines[| line] += lines[| line+1];
	                ds_list_delete( lines, line+1 );
	            }
	        }
	    break;
	    case vk_backspace:
	        if( tte_ext_has_selection() ) tte_ext_selection_delete();
	        else {
	            if( column > 1 ) {
		              column--;
		              lines[| line] = string_delete( lines[| line], column, 1 );
	            }
	            else if( line > 0 ) {
	                column = string_length( lines[| line-1] )+1;
	                lines[| line-1] += lines[| line];
	                ds_list_delete( lines, line );
	                line--;
	            }
	        }
	    break;
	    case vk_enter:
	        if( !multiline ) break;
	        if( tte_ext_has_selection() ) tte_ext_selection_delete();
	        else {
	            ds_list_insert(
	                lines,
	                line+1,
	                string_copy( lines[| line], column, string_length( lines[| line] ) - column+1 )
	            );
	            lines[| line] = string_copy( lines[| line], 1, column-1 );
	            line++;
	            column = 1;
	        }
	    break;
	}
    
	forceCaret = true;
}

function tte_ext_input_handle_selection() {
	/// tte_ext_input_handle_selection( withKeyboard=false )
	var doDrag = selDrag;
	if( argument_count >= 1 ) doDrag = argument[0];

	if( !doDrag ) {
	    tte_ext_set_selection_anchor( line, column );
	    tte_ext_unselect();
	} else {
	    if( line < selAnchorLine ) tte_ext_set_selection(
	        line,
	        column,
	        selAnchorLine,
	        selAnchorCol
	    );
	    else if( line > selAnchorLine ) tte_ext_set_selection(
	        selAnchorLine,
	        selAnchorCol,
	        line,
	        column
	    );
	    else if( column < selAnchorCol ) tte_ext_set_selection(
	        line,
	        column,
	        line,
	        selAnchorCol
	    );
	    else tte_ext_set_selection(
	        line,
	        selAnchorCol,
	        line,
	        column
	    );
	}

	update = true;
}

function tte_ext_move_cursor() {
	/// tte_ext_move_cursor( line, col, relative=false )
	var l,c,r;
	l = argument[0];
	c = argument[1];
	if( argument_count >= 3 ) r = argument[2]; else r = false;

	var dir = -1;

	if( r ) {
	    if( c < 0 ) repeat( abs(c) ) {
	        if( column > 1 ) column--;
	        else if( line > 0 ) {
	            line--;
	            column = string_length( lines[| line] )+1;
	        }
	    }
	    if( c > 0 ) repeat( c ) {
	        dir = 1;
	        if( column <= string_length( lines[| line] ) ) column++;
	        else if( line < ds_list_size( lines )-1 ) {
	            column = 1;
	            line++;
	        }
	    }
	    if( l < 0 ) repeat( abs(l) ) {
	        if( line > 0 ) {
	            line--;
	            column = min( string_length( lines[| line] )+1, column );
	        }
	    }
	    if( l > 0 ) repeat( l ) {
	        if( line < ds_list_size( lines )-1 ) {
	            line++;
	            column = min( string_length( lines[| line] )+1, column );
	        }
	    }
	}
	else {
	    line = l;
	    column = c;
	}

	update = true;
}

function tte_ext_has_selection() {
	return selVisible;
}

function tte_ext_set_selection() {
	/// tte_ext_set_selection( start_line, start_col, end_line, end_col )
	var sl, sc, el, ec;
	sl = argument[0];
	sc = argument[1];
	el = argument[2];
	ec = argument[3];

	selStartLine = sl;
	selStartCol = sc;
	selEndLine = el;
	selEndCol = ec;

	selVisible = true;
	update = true;
}

function tte_ext_set_selection_anchor() {
	/// tte_ext_set_selection_anchor( line, col )
	var sl, sc;
	sl = argument[0];
	sc = argument[1];

	selAnchorLine = sl;
	selAnchorCol = sc;

	update = true;
}

function tte_ext_unselect() {
	/// tte_ext_unselect()
	tte_ext_set_selection( 1,0,1,0 );
	selVisible = false;
	update = true;
}

function tte_ext_handle_mouse_selection() {
	/// tte_ext_handle_mouse_selection( mx, my );
	var mx, my;
	mx = argument[0];
	my = argument[1];

	draw_set_font( font );
            
	var c,i,j=0,mh,ch=0,cw=0,ccw=0,lcw=0;
	mh = string_height( "|" );
	for( i=0; i<ds_list_size( lines ); i++ ) {
	    if( my >= ch && my <= ch + max( mh, string_height( lines[| i] ) ) ) {
	        if( string_length( lines[| i] ) == 0 ) {
	            column = 1;
	            line = i;
	            tte_ext_input_handle_selection();
	        }
	        else for( j=1; j<=string_length( lines[| i] ); j++ ) {
	            c = string_char_at( lines[| i], j );
	            ccw = string_width( c );
            
	            if( mx >= cw - lcw*0.6 && mx <= cw + ccw*0.6 ) {
	                column = j;
	                line = i;
	                tte_ext_input_handle_selection();
	                break;
	            }
	            else {
	                cw = string_width(string_copy( lines[| i],1,j ));
	                lcw = ccw;
	            }
	        }
        
	        if( j == string_length( lines[| i] )+1 ) {
	            column = j;
	            line = i;
	            tte_ext_input_handle_selection();
	        }
        
	        forceCaret = true;
	        selDrag = true;
	        break;
	    }
	    ch += max( mh, string_height( lines[| i] ) );
	}
}

function tte_ext_selection_delete() {
	/// tte_ext_selection_delete()
	var i,first, last;
	first = string_copy( lines[| selStartLine], 1, selStartCol-1 );
	last = string_copy( lines[| selEndLine], selEndCol, string_length( lines[| line] )-selEndCol+1 );

	if( selStartLine != selEndLine ) ds_list_delete( lines, selEndLine );
	for( i=selEndLine-1; i>selStartLine; i-- ) ds_list_delete( lines, i );

	lines[| selStartLine] = first + last;
	tte_ext_move_cursor( selStartLine, selStartCol );
	tte_ext_unselect();
}

function tte_ext_input_insert() {
	/// tte_ext_input_insert( text )
	var t = argument[0];
	lines[| line] = string_insert( t, lines[| line], column );
	tte_ext_move_cursor( 0, string_length( t ), true );
	update = true;
}


