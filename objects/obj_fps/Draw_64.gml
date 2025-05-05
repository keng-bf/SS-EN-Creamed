var fps_ = fps;
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(global.fontDefault)
draw_set_color((fps_ < 31) ? c_red : c_white);
draw_set_alpha(1);
if global.fps
    draw_text(0, 0, string(fps_));
if debug_mode
{
    draw_text(0, 30, "FUN " + string(global.GLOBAL_FUN));
    draw_text(0, 80, "COMBOTIME" + string(global.ComboTime));
}