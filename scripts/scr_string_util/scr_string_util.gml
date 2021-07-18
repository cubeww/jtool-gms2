function string_extract(str,sep,ind) {
	var len = string_length(sep)-1;
    repeat (ind) {
		var pos = string_pos(sep,str);
		if (pos == 0)
			return "";
		str = string_delete(str,1,pos+len);
	}
    str = string_delete(str,string_pos(sep,str),string_length(str));
    return str;
}