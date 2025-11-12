function __view_get(argument0, argument1){
var __prop = argument0;
var __index = argument1;
var __res = -1;

switch (__prop)
{
    case 0:
        var __cam = view_get_camera(__index);
        __res = camera_get_view_x(__cam);
        break;
    
    case 1:
        var __cam = view_get_camera(__index);
        __res = camera_get_view_y(__cam);
        break;
}

return __res;}
