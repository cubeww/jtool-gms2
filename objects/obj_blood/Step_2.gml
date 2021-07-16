var dir;
if place_meeting(x, y, obj_block) {
    x = xprev;
    y = yprev;
     
	var dx = lengthdir_x(speed, direction) / abs(speed);
	var dy = lengthdir_y(speed, direction) / abs(speed);
    for (var i = 0; i < abs(speed); i++) {
		x += dx;
		y += dy;
		if (place_meeting(x+dx, y+dy, obj_block)) {
			break;
		}
	}
	speed = 0;
	gravity = 0;
    
    x += hspeed;
    y += vspeed;
    if (place_meeting(x, y, obj_block)) {
        x = xprev;
        y = yprev; 
    }
}