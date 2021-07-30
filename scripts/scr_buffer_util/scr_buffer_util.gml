function buffer_write_fixed(buf, type, value) {
	var newsize;
	if (type == buffer_string) {
		newsize = buffer_tell(buf) + string_length(value) + 1;
	} else if (type == buffer_text) {
		newsize = buffer_tell(buf) + string_length(value);
	} else {
		newsize = buffer_tell(buf) + buffer_sizeof(type);
	}
	if (newsize > buffer_get_size(buf)) {
		buffer_resize(buf, newsize)
	}
	buffer_write(buf, type, value);
}

function buffer_write_buffer(buf, value, compress = false) {
	var size = buffer_get_size(value);
	
	if (compress) {
		value = buffer_compress(value, 0, size);
		size = buffer_get_size(value);
	}
	
	buffer_write_fixed(buf, buffer_u32, size);
		
	buffer_copy(value, 0, buffer_get_size(value), buf, buffer_tell(buf));
	
	buffer_seek(buf, buffer_seek_relative, size);
}

function buffer_read_buffer(buf, decompress = false) {
	var size = buffer_read(buf, buffer_u32);
	
	var out = buffer_create(1, buffer_grow, 1);
	
	buffer_copy(buf, buffer_tell(buf), size, out, 0);
	if (decompress) {
		out = buffer_decompress(out);
	}
	
	buffer_seek(buf, buffer_seek_relative, size);
	
	return out;
}

function buffer_write_pascal_string(buf, str) {
	var size = string_length(str);
	
	buffer_write_fixed(buf, buffer_u32, size);
	
	buffer_write_fixed(buf, buffer_text, str);
}

function buffer_read_pascal_string(buf) {
	var size = buffer_read(buf, buffer_u32);
	
	var strbuf = buffer_create(0, buffer_grow, 1);
	
	buffer_copy(buf, buffer_tell(buf), size, strbuf, 0);
	
	buffer_seek(buf, buffer_seek_relative, size);
	
	return buffer_read(strbuf, buffer_text);
}

function buffer_read_and_write(bufread, bufwrite, type) {
	var v = buffer_read(bufread, type);
	buffer_write_fixed(bufwrite, type, v);
	return v;
}

function buffer_read_and_write_buffer(bufread, bufwrite, decompress) {
	var v = buffer_read_buffer(bufread, decompress);
	buffer_write_buffer(bufwrite, v, decompress);
	return v;
}