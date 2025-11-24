function calculate_final_volume(arg0, arg1 = false)
{
    var category_volume = arg1 ? global.musicVolume : global.soundVolume;
    return arg0 * category_volume * global.masterVolume;
}

function fmod_set_gain(arg0, arg1, arg2 = 0)
{
    if (is_undefined(arg0))
        exit;
    
    if (!is_struct(arg0))
    {
        if (audio_exists(arg0) && audio_is_playing(arg0))
            audio_sound_gain(arg0, calculate_final_volume(arg1, true), arg2);
        
        exit;
    }
    
    if (!is_undefined(arg0.instance) && audio_is_playing(arg0.instance))
    {
        var final_volume = calculate_final_volume(arg1, arg0.is_music);
        audio_sound_gain(arg0.instance, final_volume, arg2);
    }
    
    if (variable_struct_exists(arg0, "backing_instances") && !is_undefined(arg0.backing_instances))
    {
        for (var i = 0; i < array_length(arg0.backing_instances); i++)
        {
            if (!is_undefined(arg0.backing_instances[i]) && audio_is_playing(arg0.backing_instances[i]))
            {
                var backing_gain = arg0.backing_gains[i] * 1.3;
                var backing_volume = calculate_final_volume(backing_gain * arg1, arg0.is_music);
                audio_sound_gain(arg0.backing_instances[i], backing_volume, arg2);
            }
        }
    }
}

function fmod_createEventInstance(arg0, arg1 = true)
{
    if (is_undefined(arg0) || arg0 == -1 || arg0 == -4)
    {
        return undefined;
    }
    
    if (is_string(arg0))
    {
        var sound_asset = asset_get_index(arg0);
        
        if (sound_asset != -1)
        {
            return 
            {
                asset: sound_asset,
                instance: undefined,
                is_playing: false,
                state_config: undefined,
                current_state: 0,
                is_music: arg1,
                base_gain: 1
            };
        }
        else
        {
            return undefined;
        }
    }
    
    if (typeof(arg0) == "ref")
    {
        return 
        {
            asset: arg0,
            instance: undefined,
            is_playing: false,
            state_config: undefined,
            current_state: 0,
            is_music: arg1,
            base_gain: 1
        };
    }
    
    return undefined;
}

function fmod_create_layered_instance(arg0, arg1, arg2 = true)
{
    var struct = fmod_createEventInstance(arg0, arg2);
    
    if (!is_undefined(struct) && is_struct(struct))
    {
        struct.layer_sound = arg1;
        struct.layer_instance = undefined;
        struct.layer_gain = 0;
    }
    
    return struct;
}

function fmod_set_layer_volume(arg0, arg1, arg2 = 500)
{
    if (is_undefined(arg0) || !is_struct(arg0))
        exit;
    
    if (variable_struct_exists(arg0, "backing_layers") && !is_undefined(arg0.backing_layers))
    {
        var current_state = arg0.current_state;
        
        for (var i = 0; i < array_length(arg0.backing_layers); i++)
        {
            if (i != current_state && variable_struct_exists(arg0, "backing_instances") && !is_undefined(arg0.backing_instances[i]))
            {
                if (audio_is_playing(arg0.backing_instances[i]))
                    audio_sound_gain(arg0.backing_instances[i], 0, arg2);
            }
        }
        
        if (current_state < array_length(arg0.backing_layers))
        {
            arg0.backing_gains[current_state] = clamp(arg1, 0, 1);
            var backing_asset = arg0.backing_layers[current_state];
            
            if (!is_undefined(backing_asset))
            {
                if (arg0.backing_gains[current_state] > 0 && is_undefined(arg0.backing_instances[current_state]))
                {
                    arg0.backing_instances[current_state] = audio_play_sound(backing_asset, 0.5, true);
                    audio_sound_gain(arg0.backing_instances[current_state], 0, 0);
                    
                    if (!is_undefined(arg0.instance) && audio_is_playing(arg0.instance))
                    {
                        var main_position = audio_sound_get_track_position(arg0.instance);
                        audio_sound_set_track_position(arg0.backing_instances[current_state], main_position);
                    }
                }
                
                if (!is_undefined(arg0.backing_instances[current_state]) && audio_is_playing(arg0.backing_instances[current_state]))
                {
                    var boosted_gain = arg0.backing_gains[current_state] * 1.3;
                    var final_volume = calculate_final_volume(boosted_gain, arg0.is_music);
                    audio_sound_gain(arg0.backing_instances[current_state], final_volume, arg2);
                }
            }
        }
        
        exit;
    }
    
    if (!variable_struct_exists(arg0, "layer_sound"))
        exit;
    
    if (is_undefined(arg0.layer_sound))
        exit;
    
    arg0.layer_gain = clamp(arg1, 0, 1);
    
    if (arg0.layer_gain > 0 && is_undefined(arg0.layer_instance))
    {
        arg0.layer_instance = audio_play_sound(arg0.layer_sound, 1, true);
        audio_sound_gain(arg0.layer_instance, 0, 0);
    }
    
    if (!is_undefined(arg0.layer_instance) && audio_is_playing(arg0.layer_instance))
    {
        var final_volume = calculate_final_volume(arg0.layer_gain, arg0.is_music);
        audio_sound_gain(arg0.layer_instance, final_volume, arg2);
    }
    
    if (arg0.layer_gain <= 0 && !is_undefined(arg0.layer_instance) && audio_is_playing(arg0.layer_instance))
        audio_sound_gain(arg0.layer_instance, 0, arg2);
}

function fmod_configure_states(arg0, arg1)
{
    if (is_undefined(arg0) || !is_struct(arg0))
        exit;
    
    arg0.state_config = arg1;
}

function fmod_studio_event_instance_start(arg0, arg1 = false)
{
    if (is_undefined(arg0))
        exit;
    
    if (!is_struct(arg0))
    {
        if (audio_exists(arg0) && !audio_is_playing(arg0))
        {
            var inst = audio_play_sound(arg0, 1, arg1);
            audio_sound_gain(inst, calculate_final_volume(1, true), 0);
        }
        
        exit;
    }
    
    if (!is_undefined(arg0.instance) && audio_is_playing(arg0.instance))
        audio_stop_sound(arg0.instance);
    
    if (variable_struct_exists(arg0, "layer_instance") && !is_undefined(arg0.layer_instance) && audio_is_playing(arg0.layer_instance))
        audio_stop_sound(arg0.layer_instance);
    
    var asset_to_play = arg0.asset;
    
    if (!is_undefined(arg0.state_config) && array_length(arg0.state_config) > 0)
    {
        asset_to_play = arg0.state_config[0].asset;
        arg0.current_state = 0;
    }
    
    var use_3d = variable_struct_exists(arg0, "use_3d") && arg0.use_3d;
    
    if (use_3d)
    {
        var pos_x = arg0.pos_x;
        var pos_y = arg0.pos_y;
        arg0.instance = audio_play_sound_at(asset_to_play, pos_x, pos_y, 0, 300, 1000, 1, arg1, 1);
    }
    else
    {
        arg0.instance = audio_play_sound(asset_to_play, 1, arg1);
    }
    
    arg0.is_playing = true;
    var final_volume = calculate_final_volume(arg0.base_gain, arg0.is_music);
    audio_sound_gain(arg0.instance, final_volume, 0);
    
    if (variable_struct_exists(arg0, "backing_layers") && !is_undefined(arg0.backing_layers))
    {
        for (var i = 0; i < array_length(arg0.backing_layers); i++)
        {
            if (variable_struct_exists(arg0, "backing_instances") && !is_undefined(arg0.backing_instances[i]) && audio_is_playing(arg0.backing_instances[i]))
                audio_stop_sound(arg0.backing_instances[i]);
            
            if (!is_undefined(arg0.backing_layers[i]))
            {
                arg0.backing_instances[i] = audio_play_sound(arg0.backing_layers[i], 0.5, arg1);
                audio_sound_gain(arg0.backing_instances[i], 0, 0);
            }
        }
    }
}

function fmod_studio_event_instance_set_paused(arg0, arg1)
{
    if (is_undefined(arg0))
        exit;
    
    if (!is_struct(arg0))
    {
        if (audio_exists(arg0))
        {
            if (arg1 && audio_is_playing(arg0))
                audio_pause_sound(arg0);
            else
                audio_resume_sound(arg0);
        }
        
        exit;
    }
    
    if (is_undefined(arg0.instance))
        exit;
    
    if (arg1)
    {
        if (audio_is_playing(arg0.instance))
            audio_pause_sound(arg0.instance);
        
        if (variable_struct_exists(arg0, "backing_instances") && !is_undefined(arg0.backing_instances))
        {
            for (var i = 0; i < array_length(arg0.backing_instances); i++)
            {
                if (!is_undefined(arg0.backing_instances[i]) && audio_is_playing(arg0.backing_instances[i]))
                    audio_pause_sound(arg0.backing_instances[i]);
            }
        }
    }
    else
    {
        audio_resume_sound(arg0.instance);
        
        if (variable_struct_exists(arg0, "backing_instances") && !is_undefined(arg0.backing_instances))
        {
            for (var i = 0; i < array_length(arg0.backing_instances); i++)
            {
                if (!is_undefined(arg0.backing_instances[i]))
                    audio_resume_sound(arg0.backing_instances[i]);
            }
        }
    }
}

function event_instance_isplaying(arg0)
{
    if (is_undefined(arg0))
        return false;
    
    if (!is_struct(arg0))
    {
        if (audio_exists(arg0))
            return audio_is_playing(arg0);
        
        return false;
    }
    
    if (is_undefined(arg0.instance))
        return false;
    
    return audio_is_playing(arg0.instance);
}

function fmod_studio_event_instance_stop(arg0, arg1 = true)
{
    if (is_undefined(arg0))
        exit;
    
    if (!is_struct(arg0))
    {
        if (audio_exists(arg0) && audio_is_playing(arg0))
            audio_stop_sound(arg0);
        
        exit;
    }
    
    if (!is_undefined(arg0.instance) && audio_is_playing(arg0.instance))
    {
        audio_stop_sound(arg0.instance);
        arg0.instance = undefined;
        arg0.is_playing = false;
    }
    
    if (variable_struct_exists(arg0, "backing_instances") && !is_undefined(arg0.backing_instances))
    {
        for (var i = 0; i < array_length(arg0.backing_instances); i++)
        {
            if (!is_undefined(arg0.backing_instances[i]) && audio_is_playing(arg0.backing_instances[i]))
            {
                audio_stop_sound(arg0.backing_instances[i]);
                arg0.backing_instances[i] = undefined;
            }
        }
    }
}

function event_play_oneshot(arg0, arg1 = x, arg2 = y, arg3 = false, arg4 = 1)
{
    if (is_undefined(arg1))
        arg1 = x;
    
    if (is_undefined(arg2))
        arg2 = y;
    
    if (arg0 == "event:/SFX/player/wallKickLand")
    {
        event_play_oneshot(skateboardland, arg1, arg2, arg3, arg4);
        event_play_oneshot(playerstep, arg1, arg2, arg3, arg4);
        event_play_oneshot(machcancelland, arg1, arg2, arg3, arg4);
        exit;
    }
    
    if (arg0 == "event:/SFX/player/fireass")
    {
        event_play_oneshot(Fireass, arg1, arg2, arg3, arg4);
        event_play_oneshot(PizelleBossIntroScream, arg1, arg2, arg3, arg4);
        exit;
    }
    
    var sound_to_play = arg0;
    
    if (is_undefined(arg0) || arg0 == -1 || arg0 == -4)
        sound_to_play = sfx_temp;
    
    if (is_string(sound_to_play))
        sound_to_play = asset_get_index(sound_to_play);
    
    if (audio_exists(sound_to_play))
        var inst = audio_play_sound_at(sound_to_play, arg1, arg2, 0, 300, 1000, calculate_final_volume(arg4, false), arg3, 1);
}

function event_play_multiple(arg0, arg1 = x, arg2 = y, arg3 = false)
{
    var sound_to_play = arg0;
    
    if (is_undefined(arg0) || arg0 == -1 || arg0 == -4)
        sound_to_play = sfx_temp;
    
    if (is_string(sound_to_play))
        sound_to_play = asset_get_index(sound_to_play);
    
    if (audio_exists(sound_to_play))
        audio_play_sound_at(sound_to_play, arg1, arg2, 0, 100, 300, calculate_final_volume(1, false), arg3, 1);
}

function fmod_studio_event_instance_set_parameter_by_name(arg0, arg1, arg2, arg3)
{
    if (arg1 == "note" && is_struct(arg0))
    {
        var note_sounds = [sfx_bigcollect, C4, C_4, D4, D_4, E4, F4, F_4, G4, G_4, A4, A_4, B4, C5, C_5, D5, D_5, E5, F5, F_5, G5, G_5, A5, A_5, B5, C6, C_6, D6, D_6, E6, F6, F_6, G6, G_6, A6, A_6, B6, C7, C_7, D7, D_7, E7, F7, F_7, G7, G_7, A7, A_7, B7];
        var note_index = round(arg2);
        
        if (note_index >= 0 && note_index < array_length(note_sounds))
        {
            var note_asset = note_sounds[note_index];
            audio_play_sound(note_asset, 1, 0, 1.5);
        }
        
        exit;
    }
    
    if (arg1 == "state" && is_struct(arg0) && !is_undefined(arg0.state_config))
    {
        var target_state = round(arg2);
        
        if (target_state < 0 || target_state >= array_length(arg0.state_config))
        {
            exit;
        }
        
        if (arg0.current_state == target_state)
            exit;
        var state_info = arg0.state_config[target_state];
        var was_playing = event_instance_isplaying(arg0);
        var old_gain = 1;
        
        if (!is_undefined(arg0.instance) && audio_is_playing(arg0.instance))
            old_gain = audio_sound_get_gain(arg0.instance);
        
        if (!is_undefined(arg0.instance))
            audio_stop_sound(arg0.instance);
        
        var new_asset = state_info.asset;
        var should_loop = arg0.is_music;
        arg0.instance = audio_play_sound(new_asset, 1, should_loop);
        arg0.current_state = target_state;
        
        if (!is_undefined(state_info.seek_position) && state_info.seek_position > 0)
        {
            audio_sound_set_track_position(arg0.instance, state_info.seek_position);
        }
        
        if (!is_undefined(state_info.fade_time) && state_info.fade_time > 0)
        {
            audio_sound_gain(arg0.instance, 0, 0);
            audio_sound_gain(arg0.instance, 1, state_info.fade_time);
        }
        else
        {
            audio_sound_gain(arg0.instance, old_gain, 0);
        }
    }
}

function fmod_studio_system_set_parameter_by_name(arg0, arg1, arg2 = false)
{
    switch (arg0)
    {
        case "masterVolume":
            global.masterVolume = clamp(arg1, 0, 1);
            update_all_music_volumes();
            break;
        
        case "musicVolume":
            global.musicVolume = clamp(arg1, 0, 1);
            update_all_music_volumes();
            break;
        
        case "sfxVolume":
            global.soundVolume = clamp(arg1, 0, 1);
            break;
        
        default:
            break;
    }
}

function update_all_music_volumes()
{
    if (!is_undefined(global.RoomMusic) && !is_undefined(global.RoomMusic.musicInst))
        update_instance_volume(global.RoomMusic.musicInst);
    
    if (!is_undefined(global.RoomMusic) && !is_undefined(global.RoomMusic.secretMusicInst))
        update_instance_volume(global.RoomMusic.secretMusicInst);
    
    if (!is_undefined(global.EscapeMusicInst))
        update_instance_volume(global.EscapeMusicInst);
    
    if (!is_undefined(global.RankMusicInst))
        update_instance_volume(global.RankMusicInst);
    
    if (!is_undefined(global.HarryMusicInst))
        update_instance_volume(global.HarryMusicInst);
}

function update_instance_volume(arg0)
{
    if (is_undefined(arg0))
        exit;
    
    if (!is_struct(arg0))
    {
        if (audio_exists(arg0) && audio_is_playing(arg0))
            audio_sound_gain(arg0, calculate_final_volume(1, true), 0);
        
        exit;
    }
    
    if (!is_undefined(arg0.instance) && audio_is_playing(arg0.instance))
    {
        var final_volume = calculate_final_volume(arg0.base_gain, arg0.is_music);
        audio_sound_gain(arg0.instance, final_volume, 100);
    }
    
    if (variable_struct_exists(arg0, "backing_instances") && !is_undefined(arg0.backing_instances))
    {
        for (var i = 0; i < array_length(arg0.backing_instances); i++)
        {
            if (!is_undefined(arg0.backing_instances[i]) && audio_is_playing(arg0.backing_instances[i]))
            {
                var backing_gain = arg0.backing_gains[i];
                var backing_volume = calculate_final_volume(backing_gain, arg0.is_music);
                audio_sound_gain(arg0.backing_instances[i], backing_volume, 100);
            }
        }
    }
}

function fmod_studio_system_get_parameter_by_name(arg0)
{
}

function fmod_studio_event_instance_set_callback(arg0, arg1)
{
}

function fmod_event_set3DPosition(arg0, arg1, arg2, arg3 = false)
{
    if (is_undefined(arg0))
        exit;
    
    if (is_struct(arg0))
    {
        arg0.pos_x = arg1;
        arg0.pos_y = arg2;
        arg0.use_3d = true;
    }
}

function fmod_studio_event_instance_get_paused(arg0)
{
}

function fmod_event_setPause_all(arg0)
{
    if (arg0 == true)
        audio_pause_all();
    else
        audio_resume_all();
}

function kill_sounds(arg0)
{
}

function fmod_quick3D(arg0, arg1 = x, arg2 = y)
{
    if (is_undefined(arg1))
        arg1 = x;
    
    if (is_undefined(arg2))
        arg2 = y;
    
    if (is_undefined(arg0) || arg0 == -1 || arg0 == -4)
        exit;
    
    if (is_struct(arg0))
    {
        if (!is_undefined(arg0.instance) && audio_is_playing(arg0.instance))
            audio_sound_set_track_position(arg0.instance, audio_sound_get_track_position(arg0.instance));
        
        exit;
    }
    
    if (audio_exists(arg0) && audio_is_playing(arg0))
    {
    }
}

function fmod_studio_event_instance_get_timeline_position(arg0)
{
    return 0;
}

function fmod_getEventLength(arg0)
{
    return 0;
}

function fmod_studio_event_instance_set_timeline_position(arg0, arg1)
{
}

function fmod_studio_event_instance_release(arg0)
{
}

function FMOD_STUDIO_EVENT_CALLBACK()
{
}

function TIMELINE_BEAT()
{
}

function NESTED_TIMELINE_BEAT()
{
}

function FMOD_STUDIO_STOP_MODE()
{
}
