var _cam_x, _cam_y;

depth = -150;
fadealpha = 0;
AT = 0;
HAT = 0;
fadein = 0;
alarm[0] = 125;
_cam_x = camera_get_view_x(view_camera[0]);
_cam_y = camera_get_view_y(view_camera[0]);
PlayerX = x - _cam_x;
PlayerY = y - _cam_y;
