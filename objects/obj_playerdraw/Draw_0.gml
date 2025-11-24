with (obj_otherplayer)
{
    var col = image_blend;
    var alp = image_alpha;
    var pausedcolor = pause ? merge_colour(col, c_black, 0.75) : col;
    var sprit = sprite_index;
    
    if (!is_real(sprit) || !sprite_exists(sprit) || sprit == 0)
        sprit = spr_player_N_idle_breakdance;
    
    var _img = image_index;
    draw_sprite_ext(sprit, _img, x, y, xscale, yscale, img_angle, pausedcolor, alp);
    pal_swap_reset();
    var nickname = gms_other_get_string(player_id, "nickname");
    
    if (nickname == "")
        nickname = name;
    
    draw_set_colour(c_white);
    draw_set_font(global.font_small);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_alpha(alp);
    var yy = clamp((sprite_get_bbox_top(sprit) + y) - 75, 0, room_height - 16);
    draw_text(x, yy, nickname);
    draw_set_alpha(1);
    draw_set_colour(c_white);
    var typingy = (sprite_get_bbox_top(sprit) + y) - 95;
}
