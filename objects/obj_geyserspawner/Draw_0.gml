var gspr, xs, sy, sh, wys, wxs, yw, waterInst;

gspr = spr_geyserIdle;
xs = (sprite_width + 64) / sprite_get_width(gspr);

if (instance_exists(SpoutID))
{
    sy = y;
    sh = 0;
    
    with (SpoutID)
    {
        sy = y - sprite_height;
        sh = other.y - sy;
        draw_sprite_ext(sprite_index, other.imageIndex, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
    }
    
    wys = abs((sh - 32) / sprite_get_height(spr_geyserWaves));
    wxs = (sprite_width - 6) / (2 * sprite_get_width(sprite_index));
    draw_sprite_ext(spr_geyserWaves, imageIndex, x + 3, y - 32, wxs, wys, image_angle, image_blend, image_alpha);
    draw_sprite_ext(spr_geyserCloudtop, imageIndex, x - 32, sy, xs, 1, image_angle, image_blend, image_alpha);
    yw = y - 32;
    waterInst = collision_line(x, y, x, sy, obj_molasseswater, false, true);
    
    if (waterInst != -4)
        yw = waterInst.y;
    
    draw_sprite_ext(spr_geyserSplash, imageIndex, x - 32, yw, xs, 1, image_angle, image_blend, image_alpha);
}

if (!place_meeting(x, y, obj_molasseswater))
    draw_sprite_ext(gspr, imageIndex, x - 32, y - 32, xs, 1, image_angle, image_blend, image_alpha);
