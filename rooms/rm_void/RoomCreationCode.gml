var _string, time;

with (obj_hudManager)
{
    _string = "[spr_promptfont]What now?";
    time = scr_queueToolTipPrompt(_string, -4, 99999999999999);
    showtext = 1;
    scr_queueTVAnimation(global.TvSprPlayer_HighCombo, time);
}
