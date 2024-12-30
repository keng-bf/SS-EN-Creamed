var i, _layer, _tex, _prefix, _height, _str_length, _xx;

if (disconnectScreen)
{
    for (i = 0; i < array_length(disconnected_bg); i++)
    {
        _layer = disconnected_bg[i];
        
        with (_layer)
        {
            if (custom_func != -4)
                custom_func();
            
            if (sprite_index == bg_controllerdisconnect)
                draw_sprite_tiled_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_blend, image_alpha);
            else
                draw();
        }
    }
    
    _tex = "";
    _prefix = "controller_connect";
    
    if (disconnectScreen || !device_found)
        _prefix = "controller_disconnect";
    
    _tex = string("{0} - {1} - ", lang_get(_prefix), lang_get("controller_prompt", ["start"]));
    _tex = string_upper(_tex);
    draw_set_font(global.font);
    _height = string_height("A");
    _str_length = string_width(_tex);
    draw_rectangle_color(0, camera_get_view_height(view_camera[0]), camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]) - _height - 2, c_black, c_black, c_black, c_black, false);
    disconnect_text_x -= 2;
    
    if (disconnect_text_x <= -_str_length)
        disconnect_text_x = 0;
    
    for (_xx = disconnect_text_x; _xx < camera_get_view_width(view_camera[0]); _xx += _str_length)
    {
        draw_set_valign(fa_bottom);
        draw_set_halign(fa_left);
        draw_text_color(_xx, camera_get_view_height(view_camera[0]), _tex, c_white, c_white, c_white, c_white, 1);
    }
}
