// Base class for all controls
function Control(_rx = 0, _ry = 0, _w = 32, _h = 32) constructor {
	// properties
	root = noone;
	children = ds_list_create();
	
	// coordinates relative to the ROOT control 
	rx = _rx;
	ry = _ry;
	
	// absolute coordinates (in the room)
	x = 0;
	y = 0;
	
	// control width & height
	w = _w;
	h = _h;
	
	// relative alpha 
	ralpha = 1;
	
	// absolute alpha 
	alpha = 1;
	
	disabled = false; // if disabled, on_step() and on_draw() methods are no longer called 

	// methods
	add_child = function(ctrl) {
		ds_list_add(children, ctrl);
		ctrl.root = self;
		return ctrl;
	}

	add_control = function(control) {
		var ctrl = new control();
		add_child(ctrl);
		return ctrl;
	}

	remove_child = function(ctrl) {
		ds_list_delete(children, ds_list_find_index(children, ctrl));
	}
	
	destroy = function() {
		root.remove_child(self);
	}
	
	on_step = pointer_null;
	on_draw = pointer_null;
}
