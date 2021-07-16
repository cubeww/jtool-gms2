/// @description Draw controls

function draw_children(root) {
	for (var i = 0; i < ds_list_size(root.children); i++) {
		var ctrl = root.children[| i];
		if (ctrl.disabled)
			continue;
		
		// call draw function
		ctrl.on_draw();
		
		// recursively update child control 
		draw_children(ctrl);
	}
}

draw_children(control);
