if (array_length(control.children) > 0 && global.state != GLOBALSTATE_POPUP) {
    last_state = global.state;
    global.state = GLOBALSTATE_POPUP;
} else if (array_length(control.children) == 0 && global.state == GLOBALSTATE_POPUP) {
    global.state = last_state;
}
event_inherited();

