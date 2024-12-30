function scr_queueTVAnimation(argument0, argument1 = 150)
{
    var roomname, vocal_collectables;
    
    with (obj_hudManager.HUDObject_TV)
    {
        roomname = room_get_name(room);
        
        if (argument0 == global.TvSprPlayer_Secret && instance_exists(obj_secretfound))
            exit;
        
        if (tvExpressionSprite != argument0)
            tvForceTransition = true;
        
        tvExpressionSprite = argument0;
        tvExpressionBuffer = argument1;
        vocal_collectables = [spr_tvHUD_confecti1, spr_tvHUD_confecti2, spr_tvHUD_confecti3, spr_tvHUD_confecti4, spr_tvHUD_confecti5, spr_tvHUD_janitorLap, spr_tvHUD_janitorTreasure, global.TvSprPlayer_KeyGot, global.TvSprPlayer_Happy];
        
        if (chance(50) && array_contains(vocal_collectables, argument0))
            fmod_studio_event_instance_start(get_primaryPlayer().voiceCollect);
    }
}

function scr_queueToolTipPrompt(argument0 = "", argument1 = argument0, argument2 = string_length(argument0) * 15)
{
    var type;
    
    argument2 = clamp(argument2, 60, 450);
    type = 0;
    
    if (argument1 == -4)
        type = 1;
    else if (argument1 == -1)
        type = 2;
    
    with (obj_hudManager)
    {
        if (type != 2)
        {
            if (!ds_list_find_index(global.SaveRoom, argument1) || type == 1)
            {
                global.TooltipPrompt = argument0;
                HUDObject_tooltipPrompts.promptTimer = argument2;
                ds_list_add(global.SaveRoom, argument1);
            }
        }
        else
        {
            global.TooltipPrompt = argument0;
            HUDObject_tooltipPrompts.promptTimer = 2;
        }
    }
    
    return argument2;
}
