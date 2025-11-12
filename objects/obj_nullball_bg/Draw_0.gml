xx = __view_get(0, 0);
yy = __view_get(1, 0);

if (image_alpha < 0.8)
    image_alpha += 0.008;

siner += 1;
image_angle += 0.2;
draw_sprite_ext(spr_nullball_bg, 0, xx + 640, yy + 480, 4, 4, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_nullball_bg, 0, xx + 640, yy + 480, 8 + (sin(siner / 65) * 4), 8 + (sin(siner / 65) * 4), image_angle, image_blend, image_alpha - 0.4);