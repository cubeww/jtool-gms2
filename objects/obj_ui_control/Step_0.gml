/// @description Update controls

function update_children(root) {
	for (var i = 0; i < array_length(root.children); i++) {
		var ctrl = root.children[i];
		if (ctrl.disabled)
			continue;
		
		// update relative position
		ctrl.x = root.x + ctrl.rel_x;
		ctrl.y = root.y + ctrl.rel_y;
		
		// update relative alpha
		ctrl.alpha = root.alpha * ctrl.rel_alpha;
		
		// call update function
		if (ctrl.on_step != pointer_null)
			ctrl.on_step();
		
		// recursively update child control 
		update_children(ctrl);
	}
}

control.x = control.rel_x;
control.y = control.rel_y;

update_children(control);
