function ds_map_log(map) {
	var str, cur, size;
	str = "{ "

	cur = ds_map_find_first(map)
	size = ds_map_size(map)

	for (var i = 0; i < size; i += 1) {
	    str += string(cur)
	    str += ": "
	    str += string(ds_map_find_value(map, cur))
	    if (i != size - 1) {
	        str += ", "
	    }
	    cur = ds_map_find_next(map, cur)
	}

	return str + " }"
}

function ds_list_log(list) {
	var str, size;
	str = "["

	size = ds_list_size(list)

	for (var i = 0; i < size; i += 1) {
	    str += string(ds_list_find_value(list, i))
	    if (i != size - 1) {
	        str += ","
	    }
	}

	return str + "]"

}

function ds_list_swap(list, pos1, pos2) {
	var m = list[| pos1];
	list[| pos1] = list[| pos2];
	list[| pos2] = m;
}