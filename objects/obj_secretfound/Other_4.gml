var room_name, secret_number, ordinals, _string, time;

if (ds_list_find_index(global.SaveRoom, id) == -1)
{
    room_name = room_get_name(room);
    secret_number = real(string_char_at(room_name, string_length(room_name))) - 1;
    
    if (secret_number >= 0 && secret_number < 3)
    {
        global.SecretsFound[secret_number] = true;
        global.secretfound++;
        event_play_oneshot("event:/SFX/general/secretfound");
        ordinals = ["prompt_ord_first", "prompt_ord_second", "prompt_ord_third"];
        
        with (obj_hudManager)
        {
            _string = string("{0}", lang_get("prompt_secret_found", [lang_get(ordinals[secret_number]), global.secretfound]));
            time = scr_queueToolTipPrompt(_string, 300);
            showtext = 1;
            scr_queueTVAnimation(global.TvSprPlayer_Secret, time);
        }
        
        ds_list_add(global.SaveRoom, id);
    }
}
