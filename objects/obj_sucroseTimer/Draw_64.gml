var timerx, timery, minsx, secx, minsy, timeinsecs, mins, secs, gaining_time, display_mins, display_secs;

timerx = 480;
timery = 490;
minsx = timerx - 65;
secx = timerx + 15;
minsy = timery - 15;
timeinsecs = floor(target_fill / 60);
mins = max(floor(timeinsecs / 60), 0);
secs = max(timeinsecs % 60, 0);
gaining_time = timer > target_fill;
display_mins = string(abs(mins));
display_secs = string(abs(secs));

if (secs < 10)
    display_secs = "0" + display_secs;

draw_set_font(global.timerfont);
draw_set_halign(fa_left);
draw_sprite_ext(gaining_time ? spr_timer_gain : spr_timer, secs % 2, 480, timery, 1, 1, 0, c_white, 1);

if (mins < 10)
    display_mins = "0" + display_mins;

draw_set_color(gaining_time ? #60D048 : #F80000);
draw_text(minsx, minsy, display_mins);
draw_text(secx, minsy + 1, display_secs);
draw_set_color(c_white);
