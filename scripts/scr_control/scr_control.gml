// Base class for all controls
function Control(_rel_x = 0, _rel_y = 0, _w = 32, _h = 32) constructor {
    // properties
    root = noone;
    children = [];

    // coordinates relative to the ROOT control 
    rel_x = _rel_x;
    rel_y = _rel_y;

    // absolute coordinates (in the room)
    x = 0;
    y = 0;

    // control width & height
    w = _w;
    h = _h;

    // relative alpha 
    rel_alpha = 1;

    // absolute alpha 
    alpha = 1;

    disabled = false; // if disabled, on_step() and on_draw() methods are no longer called 

    // methods
    add_child = function(ctrl) {
        array_push(children, ctrl);
        ctrl.root = self;
        return ctrl;
    }

    add_control = function(control) {
        var ctrl = new control();
        add_child(ctrl);
        return ctrl;
    }

    remove_child = function(ctrl) {
        array_delete(children, array_get_index(children, ctrl), 1);
    }

    destroy = function() {
        root.remove_child(self);
    }

    on_step = pointer_null;
    on_draw = pointer_null;
}