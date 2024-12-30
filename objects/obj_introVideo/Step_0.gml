scr_getinput();
video_set_volume((!global.unfocusedMute || window_has_focus()) ? real_volume : 0);

if (!showText && key_jump)
{
    showText = true;
    alarm[0] = 120;
}
else if (showText && key_jump)
{
    event_user(0);
    alarm[0] = -1;
}
