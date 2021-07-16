
//	It is safe to delete:
//		Ease
//		EaseToString


// Make sure TGMS is intialized
TGMS_Begin();

TGMS_HIDE_WARNING Ease;
function Ease(value1, value2, amount, ease) 
{	/// @desc Interpolates two values by a given amount using specified ease algorithm
	/*
	value1		start value
	value2		end value
	amount		(0-1) amount to interpolate values
	ease			ease algorithm function
	
	Example:
	    x = Ease(x, mouse_x, 0.5, EaseInOutQuad);
	*/

	if (is_real(ease))
	{
		if (ease < 100000) // Animation Curve ID
		{
			return value1+(value2-value1)*animcurve_channel_evaluate(animcurve_get_channel(ease, 0), amount);
		}
		else // Function ID
		{
			return script_execute(ease, amount, value1, value2-value1, 1);
		}
	}

	// Method
	if (is_method(ease))
	{
		return ease(amount, value1, value2-value1, 1);
	}
	
	// Animation Curve Channel
	return value1+(value2-value1)*animcurve_channel_evaluate(ease, amount);
}


// TODO: MAKE SURE CHANNEL IS WORKING
TGMS_HIDE_WARNING  EaseToString;
function EaseToString(name, ease, channel=0)
{	/// @func EaseToString(name, ease|curve|channel, [channel])
	SharedTweener();

	if (is_real(ease))
	{
		if (ease < 100000)
		{
			ease = animcurve_get_channel(animcurve_get(ease), channel);
		}
		else
		{
			ease = method(undefined, ease);	
		}
	}
	
	name = TGMS_StringStrip(name);
	global.TGMS.ShortCodesEase[? name] = ease;
	global.TGMS.ShortCodesEase[? "~"+name] = ease;
}

function EaseToCurve(ease, num_points=180, force=false)
{
	// JS is faster not using animation curves in many cases... so exit early with a method instead
	if (!force && os_browser != browser_not_a_browser)
	{
		return method(undefined, ease);	
	}
	
	var _points = array_create(num_points+1);
	var i = -1;
	repeat(num_points+1)
	{
		var _time = ++i/num_points;
		_points[i] = animcurve_point_new();
		_points[i].posx = _time;
		_points[i].value = ease(_time, 0, 1, 1);
	}

	var _channel = animcurve_channel_new();
	_channel.type = animcurvetype_linear;
	_channel.iterations = 1;
	_channel.points = _points;
	
	return _channel;
}


//=============================
// PENNER'S EASING ALGORITHMS
//=============================
/*
	Terms of Use: Easing Functions (Equations)
	Open source under the MIT License and the 3-Clause BSD License.

	MIT License
	Copyright © 2001 Robert Penner

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

	BSD License
	Copyright © 2001 Robert Penner

	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
	Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// LINEAR
function EaseLinear(time, start, change, duration)
{	
	return change * time / duration + start;
}

// QUAD
function EaseInQuad(time, start, change, duration)
{	
	return change * time/duration * time/duration + start;
}

function EaseOutQuad(time, start, change, duration)
{
	return -change * time/duration * (time/duration-2) + start;
}

function EaseInOutQuad(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * time * time + start
					: change * -0.5 * ((time-1) * (time - 3) - 1) + start;
}

// CUBIC
function EaseInCubic(time, start, change, duration)
{
	return change * power(time/duration, 3) + start;
}

function EaseOutCubic(time, start, change, duration)
{
	return change * (power(time/duration - 1, 3) + 1) + start;
}

function EaseInOutCubic(time, start, change, duration)
{
	time = 2 * time / duration;
	return time < 1 ? change * 0.5 * power(time, 3) + start
					: change * 0.5 * (power(time-2, 3) + 2) + start;
}

// QUART
function EaseInQuart(time, start, change, duration)
{
	return change * power(time/duration, 4) + start;
}

function EaseOutQuart(time, start, change, duration)
{
	return -change * (power(time/duration - 1, 4) - 1) + start;
}

function EaseInOutQuart(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * power(time, 4) + start
					: change * -0.5 * (power(time - 2, 4) - 2) + start;
}

// QUINT
function EaseInQuint(time, start, change, duration)
{
	return change * power(time/duration, 5) + start;
}

function EaseOutQuint(time, start, change, duration)
{
	return change * (power(time/duration - 1, 5) + 1) + start;
}

function EaseInOutQuint(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * power(time, 5) + start
					: change * 0.5 * (power(time - 2, 5) + 2) + start;
}

// SINE
function EaseInSine(time, start, change, duration)
{
	return change * (1 - cos(time/duration * (pi/2))) + start;
}

function EaseOutSine(time, start, change, duration)
{
	return change * sin(time/duration * (pi/2)) + start;
}

function EaseInOutSine(time, start, change, duration)
{
	return change * 0.5 * (1 - cos(pi*time/duration)) + start;
}

// CIRC
function EaseInCirc(time, start, change, duration)
{
	return change * (1 - sqrt(1 - time/duration * time/duration)) + start;
}

function EaseOutCirc(time, start, change, duration)
{
	time = time/duration - 1;
	return change * sqrt(abs(1 - time * time)) + start;
}

function EaseInOutCirc(time, start, change, duration)
{
	time = 2*time/duration;
	return time < 1 ? change * 0.5 * (1 - sqrt(abs(1 - time * time))) + start
					: change * 0.5 * (sqrt(abs(1 - (time-2) * (time-2))) + 1) + start;
}

// EXPO
function EaseInExpo(time, start, change, duration)
{
	return change * power(2, 10 * (time/duration - 1)) + start;
}

function EaseOutExpo(time, start, change, duration)
{
	return change * (-power(2, -10 * time / duration) + 1) + start;
}

function EaseInOutExpo(time, start, change, duration)
{
	time = 2 * time / duration;
	return time < 1 ? change * 0.5 * power(2, 10 * (time-1)) + start
					: change * 0.5 * (-power(2, -10 * (time-1)) + 2) + start;
}
	
// BACK
function EaseInBack(time, start, change, duration)
{
	time /= duration;
	duration = 1.70158; // repurpose duration as Penner's "s" value -- You can hardcode this into wherever you see 'duration' in the next line
	return change * time * time * ((duration + 1) * time - duration) + start;
}
	
function EaseOutBack(time, start, change, duration)
{
	time = time/duration - 1;
	duration = 1.70158; // "s"
	return change * (time * time * ((duration + 1) * time + duration) + 1) + start;
}	
	
function EaseInOutBack(time, start, change, duration)
{
	time = time/duration*2;
	duration = 1.70158; // "s"

	if (time < 1)
	{
	    duration *= 1.525;
	    return change * 0.5 * (((duration + 1) * time - duration) * time * time) + start;
	}

	time -= 2;
	duration *= 1.525;

	return change * 0.5 * (((duration + 1) * time + duration) * time * time + 2) + start;
}

// BOUNCE
function EaseInBounce(time, start, change, duration)
{
	return change - EaseOutBounce(duration - time, 0, change, duration) + start;
}
	
function EaseOutBounce(time, start, change, duration)
{
	time /= duration;

	if (time < 1/2.75)
	{
	    return change * 7.5625 * time * time + start;
	}
	else
	if (time < 2/2.75)
	{
	    time -= 1.5/2.75;
	    return change * (7.5625 * time * time + 0.75) + start;
	}
	else
	if (time < 2.5/2.75)
	{
	    time -= 2.25/2.75;
	    return change * (7.5625 * time * time + 0.9375) + start;
	}
	else
	{
	    time -= 2.625/2.75;
	    return change * (7.5625 * time * time + 0.984375) + start;
	}
}
	
function EaseInOutBounce(time, start, change, duration)
{
	return time < duration*0.5 ? EaseInBounce(time*2, 0, change, duration)*0.5 + start
							   : EaseOutBounce(time*2 - duration, 0, change, duration)*0.5 + change*0.5 + start;
}
	
// ELASTIC
function EaseInElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = 0;
	var _val = 0;
	
	_a = change;
	_val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration;

	if (_val == 1) { return start+change; }

	if (_p == 0) { _p = duration*0.3; }

	if (_a < abs(change)) 
	{ 
	    _a = change; // lol, wut?
	    _s = _p*0.25; 
	}
	else
	{
	    _s = _p / (2*pi) * arcsin(change/_a);
	}

	return -(_a * power(2,10 * (_val-1)) * sin(((_val-1) * duration - _s) * (2*pi) / _p)) + start;
}
	
function EaseOutElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = 0;
	var _val = 0;
	
	_a = change;
	_val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration;

	if (_val == 1) { return start + change; }

	if (_p == 0) { _p = duration * 0.3; }

	if (_a < abs(change)) 
	{ 
	    _a = change; // lol, wut?
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2*pi) * arcsin (change/_a);
	}

	return _a * power(2, -10 * _val) * sin((_val * duration - _s) * (2*pi) / _p ) + change + start;
}

function EaseInOutElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = 0;
	var _val = 0;
	
	_a = change;
	_val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration*0.5;

	if (_val == 2) { return start+change; }

	if (_p == 0) { _p = duration * (0.3 * 1.5); }

	if (_a < abs(change)) 
	{ 
	    _a = change;
	    _s = _p * 0.25;
	}
	else
	{
	    _s = _p / (2*pi) * arcsin (change / _a);
	}

	if (_val < 1) { return -0.5 * (_a * power(2, 10 * (_val-1)) * sin(((_val-1) * duration - _s) * (2*pi) / _p)) + start; }

	return _a * power(2, -10 * (_val-1)) * sin(((_val-1) * duration - _s) * (2*pi) / _p) * 0.5 + change + start;
}


//======================
// EASING "SHORT CODES"
//======================
//Convert Stringed Ease Functions to use Curves ** improves performance for most platforms -- HTML5 will still use the raw function calls **

global.TGMS.ShortCodesEase = ds_map_create();

// Help automate shortcode creation
var f = function(ease)
{ 
	var map = global.TGMS.ShortCodesEase;
	var i = 0;
	repeat(argument_count-1)
	{
		var _str = argument[++i];
		map[? _str] = ease;
		map[? "~"+_str] = ease;
	}
}


#macro EaseNone ""
TGMS_HIDE_WARNING EaseNone;

// Linear
var _ease = EaseToCurve(EaseLinear, 1);
global.TGMS.ShortCodesEase[? "none"] = _ease;
global.TGMS.ShortCodesEase[? ""] = _ease;
f(_ease, "linear");

// Sine -- Default
f(EaseToCurve(EaseInSine), "i", "in", "isine", "insine");
f(EaseToCurve(EaseOutSine), "o", "out", "osine", "outsine");
f(EaseToCurve(EaseInOutSine), "io", "inout", "iosine", "inoutsine");

// Quad
f(EaseToCurve(EaseInQuad), "iquad", "inquad");
f(EaseToCurve(EaseOutQuad), "oquad", "outquad");
f(EaseToCurve(EaseInOutQuad), "ioquad", "inoutquad");

// Cubic
f(EaseToCurve(EaseInCubic), "icubic", "incubic");
f(EaseToCurve(EaseOutCubic), "ocubic", "outcubic");
f(EaseToCurve(EaseInOutCubic), "iocubic", "inoutcubic");

// Quart
f(EaseToCurve(EaseInQuart), "iquart", "inquart");
f(EaseToCurve(EaseOutQuart), "oquart", "outquart");
f(EaseToCurve(EaseInOutQuart), "ioquart", "inoutquart");

// Quint
f(EaseToCurve(EaseInQuint), "iquint", "inquint");
f(EaseToCurve(EaseOutQuint), "oquint", "outquint");
f(EaseToCurve(EaseInOutQuint), "ioquint", "inoutquint");

// Circ
f(EaseToCurve(EaseInCirc), "icirc", "incirc");
f(EaseToCurve(EaseOutCirc), "ocirc", "outcirc");
f(EaseToCurve(EaseInOutCirc), "iocirc", "inoutcirc");

// Expo
f(EaseToCurve(EaseInExpo), "iexpo", "inexpo");
f(EaseToCurve(EaseOutExpo), "oexpo", "outexpo");
f(EaseToCurve(EaseInOutExpo), "ioexpo", "inoutexpo");

// Back
f(EaseToCurve(EaseInBack), "iback", "inback");
f(EaseToCurve(EaseOutBack), "oback", "outback");
f(EaseToCurve(EaseInOutBack), "ioback", "inoutback");

// Bounce
f(EaseToCurve(EaseInBounce), "ibounce", "inbounce");
f(EaseToCurve(EaseOutBounce), "obounce", "outbounce");
f(EaseToCurve(EaseInOutBounce), "iobounce", "inoutbounce");

// Elastic
f(EaseToCurve(EaseInElastic, undefined, true), "ielastic", "inelastic");
f(EaseToCurve(EaseOutElastic, undefined, true), "oelastic", "outelastic");
f(EaseToCurve(EaseInOutElastic, undefined, true), "ioelastic", "inoutelastic");


