var i, _x, _y, check_x, check_y;

for (i = 0; i < trueYscale; i++)
{
    _x = x + lengthdir_x(32 * i, image_angle - 90);
    _y = y + lengthdir_y(32 * i, image_angle - 90);
    check_x = _x + lengthdir_x(1, image_angle + ((sign(image_xscale) == -1) ? 180 : 0));
    check_y = _y + lengthdir_y(1, image_angle + ((sign(image_xscale) == -1) ? 180 : 0));
    showCutoff[i] = false;
    
    if (!(place_meeting(check_x, check_y, obj_destructibles) || place_meeting(check_x, check_y, obj_metalblock) || place_meeting(check_x, check_y, obj_secret_brainBlock) || place_meeting(check_x, check_y, obj_secretTileDestroy)) && place_meeting_collision(_x, _y))
        showCutoff[i] = true;
}
