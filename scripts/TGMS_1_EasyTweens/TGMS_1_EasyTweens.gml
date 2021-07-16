/*
	It is safe to delete any function from this script
	or to delete this whole script entirely
*/

TGMS_HIDE_WARNING TweenEasyUseDelta;
function TweenEasyUseDelta(use_seconds) 
{	/// @desc Toggle between using step or delta(seconds) timing for "Easy Tweens"
	/// @func TweenEasyUseDelta([use_seconds?])
	
	SharedTweener();
	
	if (use_seconds == undefined)
	{
		return global.TGMS.EasyUseDelta;
	}
	
	global.TGMS.EasyUseDelta = use_seconds;
}	

TGMS_HIDE_WARNING TweenEasyMove;
function TweenEasyMove(x1, y1, x2, y2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyMove") && TweenExists(__TweenEasyMove))
	{
		TweenDestroy(__TweenEasyMove);
	}
	
	if (argument_count > 8)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "x", x1, x2, "y", y1, y2];
		var i = 7; repeat(argument_count-8) { array_push(_args, argument[++i]); }
		__TweenEasyMove = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyMove = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "x", x1, x2, "y", y1, y2);	
	}

	return __TweenEasyMove;
}

TGMS_HIDE_WARNING TweenEasyScale;
function TweenEasyScale(x1, y1, x2, y2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyScale") && TweenExists(__TweenEasyScale))
	{
		TweenDestroy(__TweenEasyScale);
	}
	
	if (argument_count > 8)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_xscale", x1, x2, "image_yscale", y1, y2];
		var i = 7; repeat(argument_count-8) { array_push(_args, argument[++i]); }
		__TweenEasyScale = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyScale = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_xscale", x1, x2, "image_yscale", y1, y2);
	}
	
	return __TweenEasyScale;
}

TGMS_HIDE_WARNING TweenEasyRotate;
function TweenEasyRotate(angle1, angle2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyRotate") && TweenExists(__TweenEasyRotate))
	{
		TweenDestroy(__TweenEasyRotate);
	}

	if (argument_count > 6)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_angle", angle1, angle2];
		var i = 5; repeat(argument_count-6) { array_push(_args, argument[++i]); }
		__TweenEasyRotate = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyRotate = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_angle", angle1, angle2);
	}
	
	return __TweenEasyRotate;
}

TGMS_HIDE_WARNING TweenEasyFade;
function TweenEasyFade(alpha1, alpha2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyFade") && TweenExists(__TweenEasyFade))
	{
		TweenDestroy(__TweenEasyFade);
	}

	if (argument_count > 6)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_alpha", alpha1, alpha2];
		var i = 5; repeat(argument_count-6) { array_push(_args, argument[++i]); }
		__TweenEasyFade = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyFade = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_alpha", alpha1, alpha2);
	}
	
	return __TweenEasyFade;
}

TGMS_HIDE_WARNING TweenEasyBlend;
function TweenEasyBlend(col1, col2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyBlend") && TweenExists(__TweenEasyBlend))
	{
		TweenDestroy(__TweenEasyBlend);
	}
	
	if (argument_count > 6)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_blend", col1, col2];
		var i = 5; repeat(argument_count-6) { array_push(_args, argument[++i]); }
		__TweenEasyBlend = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyBlend = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_blend", col1, col2);
	}
	
	return __TweenEasyBlend;
}

TGMS_HIDE_WARNING TweenEasyImage;
function TweenEasyImage(index1, index2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyImage") && TweenExists(__TweenEasyImage))
	{
		TweenDestroy(__TweenEasyImage);
	}

	if (argument_count > 6)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_index", index1, index2];
		var i = 5; repeat(argument_count-6) { array_push(_args, argument[++i]); }
		__TweenEasyImage = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyImage = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "image_index", index1, index2);
	}
	
	return __TweenEasyImage;
}
	
TGMS_HIDE_WARNING TweenEasyTurn;
function TweenEasyTurn(dir1, dir2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyTurn") && TweenExists(__TweenEasyTurn))
	{
		TweenDestroy(__TweenEasyTurn);
	}

	if (argument_count > 6)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "direction", dir1, dir2];
		var i = 5; repeat(argument_count-6) { array_push(_args, argument[++i]); }
		__TweenEasyTurn = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyTurn = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "direction", dir1, dir2);
	}
	
	return __TweenEasyTurn;
}
	
TGMS_HIDE_WARNING TweenEasyPath;
function TweenEasyPath(path, absolute, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasyPath") && TweenExists(__TweenEasyPath))
	{
		TweenDestroy(__TweenEasyPath);
	}
					
	if (argument_count > 6)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, absolute ? {data:[TPPath, path]} : {data:[TPPath, path, x, y]}, 0, 1];
		var i = 5; repeat(argument_count-6) { array_push(_args, argument[++i]); }
		__TweenEasyPath = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasyPath = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, absolute ? {data:[TPPath, path]} : {data:[TPPath, path, x, y]}, 0, 1);
	}
	
	return __TweenEasyPath;
}

TGMS_HIDE_WARNING TweenEasySpeed;
function TweenEasySpeed(spd1, spd2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasySpeed") && TweenExists(__TweenEasySpeed))
	{
		TweenDestroy(__TweenEasySpeed);
	}

	if (argument_count > 6)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "speed", spd1, spd2];
		var i = 5; repeat(argument_count-6) { array_push(_args, argument[++i]); }
		__TweenEasySpeed = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasySpeed = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "speed", spd1, spd2);
	}
	
	return __TweenEasySpeed;
}

TGMS_HIDE_WARNING TweenEasySpeedHV;
function TweenEasySpeedHV(hspd1, vspd1, hspd2, vspd2, delay, duration, ease, mode=0) 
{
	if (!instance_exists(o_SharedTweener)) SharedTweener();
	
	if (variable_instance_exists(id, "__TweenEasySpeedHV") && TweenExists(__TweenEasySpeedHV))
	{
		TweenDestroy(__TweenEasySpeedHV);
	}

	if (argument_count > 8)
	{
		var _args = [id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "hspeed", hspd1, hspd2, "vspeed", vspd1, vspd2];
		var i = 7; repeat(argument_count-8) { array_push(_args, argument[++i]); }
		__TweenEasySpeedHV = script_execute_ext(TweenFire, _args);
	}
	else
	{
		__TweenEasySpeedHV = TweenFire(id, ease, mode, global.TGMS.EasyUseDelta, delay, duration, "hspeed", hspd1, hspd2, "vspeed", vspd1, vspd2);
	}
	
	return __TweenEasySpeedHV;
}





