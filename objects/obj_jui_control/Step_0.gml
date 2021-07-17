/// @description Update controls

function update_children(root, rrx, rry, rralpha) {
	for (var i = 0; i < ds_list_size(root.children); i++) {
		var ctrl = root.children[| i];
		if (ctrl.disabled)
			continue;
		
		// update relative position
		var rx2 = rrx + ctrl.rx;
		var ry2 = rry + ctrl.ry;
		
		ctrl.x = rx2;
		ctrl.y = ry2;
		
		// update relative alpha
		var al2 = rralpha * ctrl.ralpha;
		ctrl.alpha = al2;
		
		// call update function
		if (ctrl.on_step != pointer_null)
			ctrl.on_step();
		
		// recursively update child control 
		update_children(ctrl, rx2, ry2, al2);
	}
}

update_children(control, x, y, image_alpha);
