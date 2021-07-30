
function uuid_generate() {
	var d = current_time + epoch() * 10000, uuid = array_create(32), i = 0, r;

	for (i=0;i<array_length(uuid);++i) {
	    r = floor((d + random(1) * 16)) mod 16;
    
	    if (i == 16)
	        uuid[i] = dec_to_hex(r & $3|$8);
	    else
	        uuid[i] = dec_to_hex(r);
	}

	uuid[12] = "4";

	return uuid_array_implode(uuid);
}

function uuid_array_implode(argument0) {
	var s = "", i=0, sl = array_length(argument0), a = argument0, sep = "-";

	repeat 8 s += a[i++];
	s += sep;

	repeat 4 s += a[i++];
	s += sep;

	repeat 4 s += a[i++];
	s += sep;

	repeat 4 s += a[i++];
	s += sep;

	repeat 12 s += a[i++];

	return s;
}

function iff(argument0, argument1, argument2) {
	if argument0 return argument1 return argument2
}

function epoch() {
	return round(date_second_span(date_create_datetime(2016,1,1,0,0,1), date_current_datetime()));
}

function dec_to_hex(argument0) {
    var dec, hex, h, byte, hi, lo;
    dec = argument0;
    if (dec) hex = "" else hex="0";
    h = "0123456789abcdef";
    while (dec) {
        byte = dec & 255;
        hi = string_char_at(h, byte div 16 + 1);
        lo = string_char_at(h, byte mod 16 + 1);
        hex = iff(hi!="0", hi, "") + lo + hex;
        dec = dec >> 8;
    }
    return hex;
}