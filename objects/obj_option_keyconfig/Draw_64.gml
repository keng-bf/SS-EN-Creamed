var s, c_hover, dx, pady, target_scroll, i, ci, dy, ty, f1_text_offset;

draw_set_font(global.font);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(c_white);
s = selected;
c_hover = (s == -1) ? 16777215 : 8421504;
draw_text_color(32, 50, lang_get("opt_back"), c_hover, c_hover, c_hover, c_hover, 1);
dx = 352;
pady = 0;
target_scroll = 0;

for (i = 0; i < array_length(inputs); i++)
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    ci = inputs[i];
    c_hover = (s == i) ? 16777215 : 8421504;
    dy = (128 + (i * scroll_pad) + pady) - scroll_y;
    pady += ((gamepad ? 48 : 32) * (ci.lineCount - 1));
    
    if (i == s)
        target_scroll = (dy + pady) - 64;
    
    draw_sprite_ext(spr_optionBindings, ci.iconIndex, dx, dy, 1, 1, 0, c_hover, 1);
    ci.draw(928, dy, c_hover);
}

scroll_y = round(lerp(scroll_y, target_scroll, 0.1));

if (reading)
{
    draw_set_alpha(0.5);
    draw_rectangle_color(0, 0, 960, 540, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_color(480, 270, lang_get("opt_keyconfig_inputprompt"), c_white, c_white, c_white, c_white, 1);
}
else
{
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_set_alpha(1);
    ty = 348;
    draw_text_scribble(32, ty, string("{0}: {1}", lang_get("opt_keyconfig_bind"), get_control_sprite(gamepad ? "jumpC" : "jump")));
    ty += 50;
    draw_text_scribble(32, ty, string("{0}: {1}", lang_get("opt_keyconfig_clear"), get_control_sprite(gamepad ? "tauntC" : "taunt")));
    ty += 50;
    draw_text_scribble(32, ty, string("{0}: [spr_keyDrawFont][spr_key_empty]", lang_get("opt_keyconfig_reset")));
    f1_text_offset = 32 + string_width_scribble(string("{0}: ", lang_get("opt_keyconfig_reset"))) + (string_width_scribble("[spr_keyDrawFont][spr_key_empty]") / 2);
    draw_text_scribble(f1_text_offset, ty, "[fa_center][spr_npcsmallfont]F1");
}
