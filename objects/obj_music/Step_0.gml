if (global.gamePauseState)
	exit

if (event_instance_isplaying(global.RankMusicInst) && room != rank_room && !instance_exists(obj_endlevelfade) && !instance_exists(obj_rank))
	fmod_studio_event_instance_stop(global.RankMusicInst, true)

if (!global.panic && instance_exists(obj_gummyharry))
{
    var harry_close = bbox_in_camera(obj_gummyharry, view_camera[0], 35);
    
    if (!event_instance_isplaying(global.HarryMusicInst))
        fmod_studio_event_instance_start(global.HarryMusicInst, true);
    
    var target_harry_gain = harry_close ? 1 : 0;
    fmod_set_gain(global.HarryMusicInst, target_harry_gain, 500);
    
    if (!is_undefined(global.RoomMusic) && !is_undefined(global.RoomMusic.musicInst))
    {
        var target_room_gain = harry_close ? 0 : 1;
        fmod_set_gain(global.RoomMusic.musicInst, target_room_gain, 500);
    }
}
else
{
    if (!global.panic)
        fmod_studio_event_instance_stop(global.HarryMusicInst, true);
    
    if (!is_undefined(global.RoomMusic) && !is_undefined(global.RoomMusic.musicInst))
        fmod_set_gain(global.RoomMusic.musicInst, 1, 500);
}

if (global.panic)
{
	if (!panicStart)
	{
		panicStart = true
		fmod_studio_event_instance_start(global.EscapeMusicInst)
		fmod_studio_event_instance_set_paused(global.EscapeMusicInst, false)
		fmod_studio_event_instance_set_parameter_by_name(global.EscapeMusicInst, "state", 0, true)
		fmod_studio_system_set_parameter_by_name("pillarfade", 0, true)
		fmod_studio_event_instance_stop(global.HarryMusicInst, true)
		
		if (!is_undefined(global.RoomMusic))
		{
			fmod_studio_event_instance_stop(global.RoomMusic.musicInst, true)
			fmod_studio_event_instance_stop(global.RoomMusic.secretMusicInst, true)
		}
		
		fmod_studio_event_instance_set_callback(global.EscapeMusicInst, FMOD_STUDIO_EVENT_CALLBACK)
	}
	else if (event_instance_isplaying(global.EscapeMusicInst))
	{
		var event_state = 0
		
		if (global.EscapeTime <= time_in_frames(1, 0))
			event_state = 1
			
		if (global.lapcount >= 1)
			event_state = (1 + global.lapcount)
		
		fmod_studio_event_instance_set_parameter_by_name(global.EscapeMusicInst, "state", event_state, true)
	}
}
else
{
	if (panicStart)
	{
		panicStart = false
		fmod_studio_event_instance_stop(global.EscapeMusicInst, true)
	}
	
	if (!is_undefined(global.RoomMusic))
	{
		with (global.RoomMusic)
		{
			if (!is_undefined(musicFunc))
				musicFunc(room, musicInst, secretMusicInst)
		}
	}
}
