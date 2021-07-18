function get_working_directory() {
	if (working_directory != program_directory) {
		return global.project_directory + "/";
	} else {
		return working_directory;
	}
}

function ini_read_color_hsv(section, key, def) {
	var str = ini_read_string(section, key, def);
	if (string_pos(",", str) != 0) {
		return make_color_hsv(real(string_extract(str, ",", 0)), real(string_extract(str, ",", 1)), real(string_extract(str, ",", 2)));
	} else {
		return real(def);
	}
}