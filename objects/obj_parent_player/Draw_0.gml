
    var drawspr = sprite_index;
    var nick = /*(*/nickname/* == "") ? gms_self_name() : nickname*/;
    draw_set_colour(c_white);
    draw_set_font(global.smallfont);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    var yy = clamp((sprite_get_bbox_top(drawspr) + y) - 75, 0, room_height - 16);
    draw_text(x, yy, nick);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_colour(c_white);