function array_swap(a, pos1, pos2) {
	var m = a[pos1];
	a[pos1] = a[pos2];
	a[pos2] = m;
}

function array_clear(a) {
	array_delete(a, 0, array_length(a));
}

function array_get_index(a, v) {
	for (var i = 0; i < array_length(a); i++) {
		if (v == a[i])
			return i;
	}
	return -1;
}