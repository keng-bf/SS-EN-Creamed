function scr_startgate_draw_normal()
{
    var w, h, x_offset, y_offset, i, _layer, my_height;
    
    w = sprite_get_width(sprite_index);
    h = sprite_get_height(sprite_index);
    x_offset = sprite_get_xoffset(sprite_index);
    y_offset = sprite_get_yoffset(sprite_index);
    
    if (fade < 1)
    {
        if (!surface_exists(surf))
        {
            surf = surface_create(w, h);
        }
        else
        {
            surface_set_target(surf);
            draw_clear_alpha(c_black, 0);
            draw_set_color(c_white);
            i = array_length(details) - 1;
            
            while (i >= 0)
            {
                _layer = details[i];
                
                with (_layer)
                {
                    my_height = sprite_get_height(sprite_index);
                    x += hspeed;
                    y += vspeed;
                    image_index += image_speed;
                    
                    if (func != -4)
                        func();
                    
                    draw_sprite_tiled_ext(sprite_index, image_index, xstart + x, ystart + y + (h - my_height), image_xscale, image_yscale, image_blend, image_alpha);
                }
                
                i--;
            }
            
            if (isEasel)
                scr_startgate_draw_easel();
            
            gpu_set_blendmode(bm_subtract);
            draw_sprite(sprite_index, 1, sprite_xoffset, sprite_yoffset);
            gpu_set_blendmode(bm_normal);
            surface_reset_target();
            draw_surface(surf, x - x_offset, y - y_offset);
        }
    }
    
    if (fade > 0)
        draw_sprite_ext(sprite_index, 2, x, y, image_xscale, image_yscale, image_angle, image_blend, fade);
}

function scr_startgate_draw_easel()
{
    var w, h, u_resolution, u_offset, u_intensity, arrLast;
    
    w = sprite_get_width(sprite_index);
    h = sprite_get_height(sprite_index);
    
    if (!surface_exists(easelSurf))
    {
        easelSurf = surface_create(w, h);
    }
    else
    {
        surface_reset_target();
        surface_set_target(easelSurf);
        u_resolution = shader_get_uniform(shd_noise, "u_resolution");
        u_offset = shader_get_uniform(shd_noise, "u_offset");
        u_intensity = shader_get_uniform(shd_noise, "u_intensity");
        arrLast = array_length(details) - 1;
        shader_set(shd_noise);
        shader_set_uniform_f(u_intensity, 1 - fade);
        shader_set_uniform_f_array(u_resolution, [w / 100, h / 100]);
        shader_set_uniform_f_array(u_offset, [details[arrLast].x / 100, 0, global.CurrentTime / power(10, 6)]);
        draw_surface(surf, 0, 0);
        shader_reset();
        surface_reset_target();
        surface_set_target(surf);
        draw_surface(easelSurf, 0, 0);
    }
}
