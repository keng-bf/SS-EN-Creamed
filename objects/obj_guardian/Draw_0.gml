var _x, _y, _dist, _dir, w, wto, drawX, drawY, i, _dist2;

warningx = lerp(warningx, targetx, warningspeed);
warningy = lerp(warningy, targety, warningspeed);

if (chaseActive && state != States.stun)
{
    _x = pathxstart;
    _y = pathystart;
    _dist = point_distance(_x, _y, warningx, warningy);
    _dir = point_direction(_x, _y, warningx, warningy);
    w = sprite_get_width(pathspr);
    wto = _dist / w;
    drawX = false;
    drawY = false;
    
    for (i = 0; i < floor(wto); i++)
    {
        drawX = (sign(warningx - pathxstart) == -1) ? (_x <= x) : (_x >= x);
        drawY = (sign(warningy - pathystart) == -1) ? (_y <= y) : (_y >= y);
        
        if (drawX && drawY)
            draw_sprite_ext(pathspr, 0, _x, _y, 1, 1, _dir, image_blend, image_alpha);
        
        _x += lengthdir_x(w, _dir);
        _y += lengthdir_y(w, _dir);
    }
    
    if (frac(wto) > 0 && drawX && drawY)
    {
        _dist2 = frac(wto) * w;
        draw_sprite_general(pathspr, 0, 0, 29, _dist2, 37, _x, _y, 1, 1, _dir, image_blend, image_blend, image_blend, image_blend, image_alpha);
    }
    
    draw_sprite(warningspr, -1, warningx, warningy);
}

draw_self();

