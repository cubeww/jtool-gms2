function draw_sprite_tiled_area(sprite, subimg, xx, yy, x1, y1, x2, y2) {
    var sw,sh,i,j,jj,left,top,width,height,X,Y;
    sw = sprite_get_width(sprite);
    sh = sprite_get_height(sprite);

    i = x1-((x1 mod sw) - (xx mod sw)) - sw*((x1 mod sw)<(xx mod sw));
    j = y1-((y1 mod sh) - (yy mod sh)) - sh*((y1 mod sh)<(yy mod sh)); 
    jj = j;

    for(i=i; i<=x2; i+=sw) {
        for(j=j; j<=y2; j+=sh) {

            if(i <= x1) left = x1-i;
            else left = 0;
            X = i+left;

            if(j <= y1) top = y1-j;
            else top = 0;
            Y = j+top;

            if(x2 <= i+sw) width = ((sw)-(i+sw-x2)+1)-left;
            else width = sw-left;

            if(y2 <= j+sh) height = ((sh)-(j+sh-y2)+1)-top;
            else height = sh-top;

            draw_sprite_part(sprite,subimg,left,top,width,height,X,Y);
        }
        j = jj;
    }
    return 0;
}

function draw_text_outline(textX, textY, textStr, textColor, outlineColor) {
	//draw the text outline
	draw_set_color(outlineColor);
	draw_text(textX-1,textY+1,textStr);
	draw_text(textX-1,textY,textStr);
	draw_text(textX-1,textY-1,textStr);
	draw_text(textX+1,textY+1,textStr);
	draw_text(textX+1,textY,textStr);
	draw_text(textX+1,textY-1,textStr);
	draw_text(textX,textY+1,textStr);
	draw_text(textX,textY-1,textStr);

	//draw the text itself
	draw_set_color(textColor);
	draw_text(textX,textY,textStr);
}

function draw_rectangle_wh(xx, yy, ww, hh, outline) {
    xx = round(xx);
    yy = round(yy);
    
    if (!outline) {
        draw_rectangle(xx, yy, xx + ww - 1, yy + hh - 1, false);
    } else {
        draw_rectangle(xx + 1, yy + 1, xx + ww - 2, yy + hh - 2, true);
    }
}