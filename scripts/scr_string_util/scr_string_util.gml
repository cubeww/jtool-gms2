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

function int_to_base32_string(number) {
	var base32string = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@";
	var result = "";
	while (number > 0) {
	    var decimal = number / 32;
	    number = floor(decimal);
	    var pos = (decimal - number) * 32;
	    result = string_char_at(base32string, pos + 1) + result;
	}

	return result;

}

function pad_string_left(str, length, padchar) {
	while (string_length(str) < length) {
	    str = padchar + str;
	}
	return str;
}

function float_to_base32_string(float) {
	return pad_string_left(int_to_base32_string(bin_to_dec(encode_real_double(float))), 13, "0");
}

function bin_to_dec(bin) {
	var dec, l, p;
    dec = 0;
    l = string_length(bin);
    for (p=1; p<=l; p+=1) {
        dec = dec << 1;
        if (string_char_at(bin, p) == "1") dec = dec | 1;
    }
    return dec;
}

function encode_real_double(n) {
	var str, byte, E, M;
    if (n == 0) {
        return string_repeat(chr(0),8);
    }
    byte[0] = 0;
    byte[7] = 0;
    if (n < 0) {
        n *= -1;
        byte[7] = byte[7] | $80;
    }
    E = floor(log2(n));
    M = n / power(2,E) - 1;
    E += 1023;
    var i;
    i = 0;
    while (i < 11) {
        if (i < 4) {
            byte[6] = byte[6] | ((E & (1<<i)) << 4);
        } else {
            byte[7] = byte[7] | ((E & (1<<i)) >> 4);
        }
        i += 1;
    }
    i = 51;
    while (i >= 0) {
        M *= 2;
        if (M >= 1) {
            byte[i div 8] = byte[i div 8] | (1<<(i mod 8));
            M -= 1;
        }
        i -= 1;
    }
    str = "";
    for (i = 7; i >= 0; i -= 1) {
        //str += chr(byte[i]);
        for (var j=0; j<8; j+=1) {
            str += string((byte[i] & (128>>j)) != 0)
        }
    }
    return str;
}

function base32_string_to_int(str) {
	var base32string = "0123456789abcdefghijklmnopqrstuv";
	var result = 0;
	var length = string_length(str);
	for (var i = 0; i < length; i++)
	{
	    var char = string_char_at(str, i + 1);
	    var charvalue = string_pos(char, base32string) - 1;
	    var placevalue = power(32, length - 1 - i);
	    result += charvalue * placevalue;
	}

	return result;
}

function base32_string_to_float(str) {
	return decode_real_double(pad_string_left(dec_to_bin(base32_string_to_int(str)), 64, "0"));
}

function dec_to_bin(dec) {
	var bin;
    if (dec) bin = "" else bin="0";
    while (dec) {
        bin = string_char_at("01", (dec & 1) + 1) + bin;
        dec = dec >> 1;
    }
    return bin;
}

function decode_real_double(str) {
	var S, E, M, byte, n;
    var i;
    for (i = 0; i < 8; i += 1) {
        //byte[i] = ord(string_char_at(str,8 - i));
        byte[i] = 0
        for (var j=0; j<8; j+=1) {
            byte[i] += real(string_char_at(str,(7-i)*8+j+1)) * (128>>j)
        }
    }
    S = 1 - 2*((byte[7] & $80) > 0);
    i = 0;
    M = 0;
    while (i <= 51) {
        if (byte[i div 8] & (1<<(i mod 8)) > 0) {
            M += 1;
        }
        M /= 2;
        i += 1;
    }
    i = 62;
    E = 0;
    while (i > 51) {
        E *= 2;
        if (byte[i div 8] & (1<<(i mod 8)) > 0) {
            E += 1;
        }
        i -= 1;
    }
    if (E == 0) {
        n = S * M * power(2, -1022);
    }
    else {
        n = S * (M + 1) * power(2, E - 1023);
    }
    return n;
}
