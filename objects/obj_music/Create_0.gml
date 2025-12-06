if (instance_number(obj_music) > 1)
{
	var first = instance_find(obj_music, 0)
	
	if (id != first)
	{
		instance_destroy()
		exit
	}
}

addRoomMusic = function(arg0, arg1, arg2, arg3, arg4, arg5)
{
	var temp_struct = {}
	
	with (temp_struct)
	{
		eventName = arg1
		secretEventName = arg2
		musicInst = undefined
		secretMusicInst = undefined
		musicFunc = undefined
        stateConfig = undefined;
        backingLayers = undefined;
        
        if (!is_undefined(eventName))
            musicInst = fmod_createEventInstance(eventName);
        
        if (!is_undefined(secretEventName))
            secretMusicInst = fmod_createEventInstance(secretEventName);
        
        if (!is_undefined(arg3) && is_callable(arg3))
            musicFunc = method(self, arg3);
        
        if (!is_undefined(arg4) && is_array(arg4))
        {
            stateConfig = arg4;
            
            if (!is_undefined(musicInst))
                fmod_configure_states(musicInst, arg4);
        }
        
        if (!is_undefined(arg5) && is_array(arg5))
        {
            backingLayers = arg5;
            
            if (!is_undefined(musicInst) && is_struct(musicInst))
            {
                musicInst.backing_layers = [];
                musicInst.backing_instances = [];
                musicInst.backing_gains = [];
                
                for (var i = 0; i < array_length(backingLayers); i++)
                {
                    if (!is_undefined(backingLayers[i]))
                    {
                        musicInst.backing_layers[i] = backingLayers[i];
                        musicInst.backing_instances[i] = undefined;
                        musicInst.backing_gains[i] = 0;
                    }
                }
            }
        }
	}
	
	ds_map_set(global.RoomMusicMap, arg0, temp_struct)
}

global.RoomMusicMap = ds_map_create()
global.EscapeMusicInst = fmod_createEventInstance(mu_PZ_lap1);
var escape_states = [
{
    asset: mu_PZ_lap1,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_PZ_lap1,
    seek_position: 158,
    fade_time: 500
}, 
{
    asset: mu_PZ_lap2,
    seek_position: 0,
    fade_time: 1000
},
{
    asset: mu_PZ_lap3, //by: dexiedoo_octo
    seek_position: 0,
    fade_time: 0
},
{
    asset: mu_PZ_lap4, //by: dexiedoo_octo
    seek_position: 0,
    fade_time: 0
},
{
    asset: mu_PZ_lap5, //by: key after key
    seek_position: 0,
    fade_time: 0
}];
fmod_configure_states(global.EscapeMusicInst, escape_states);
global.RankMusicInst = fmod_createEventInstance(mu_ranks_PZ, true);
var rank_states = [
{
    asset: mu_rankp_PZ,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_ranks_PZ,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_ranka_PZ,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_rankb_PZ,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_rankc_PZ,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_rankd_PZ,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: undefined,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: undefined,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: undefined,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: undefined,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_rank_loop,
    seek_position: 0,
    fade_time: 500
}, 
{
    asset: mu_rank_loopALT,
    seek_position: 0,
    fade_time: 500
}];
fmod_configure_states(global.RankMusicInst, rank_states);
global.HarryMusicInst = fmod_createEventInstance(mu_harry)
global.RoomMusic = undefined
global.RoomIsSecret = false
panicStart = false
currentSecretStatus = false
global.CurrentBeat = 0

addRoomMusic(rm_mainmenu, mu_title, undefined, undefined)
addRoomMusic(rm_disclaimer, mu_disclaimer, undefined, undefined)
addRoomMusic(rm_credits, mu_credits, undefined, undefined)
addRoomMusic(rm_devroom, mu_credits, undefined, undefined)
addRoomMusic(rm_missing, mu_missing, undefined, undefined)
addRoomMusic(tutorial_1, mu_tutorial, undefined, undefined)
addRoomMusic(hub_paintstudio, mu_hubw1, undefined, undefined)
addRoomMusic(hub_soundTest, undefined, undefined, undefined)
addRoomMusic(hub_demohallway, mu_hubw1, undefined, undefined)
addRoomMusic(hub_mindpalace, mu_painterBrain, undefined, undefined)
addRoomMusic(hub_mindvault, mu_harry, undefined, undefined)
addRoomMusic(hub_molasses, mu_hubw1, undefined, undefined)
addRoomMusic(internship_floor1, mu_hubw2, undefined, undefined)
addRoomMusic(internship_floor1, mu_hubw2, undefined, undefined)
addRoomMusic(tower_1, mu_hubw2, undefined, undefined)
addRoomMusic(tower_2, mu_hubw2, undefined, undefined)
addRoomMusic(tower_3, mu_hubw2, undefined, undefined)
addRoomMusic(tower_4, mu_hubw2, undefined, undefined)
addRoomMusic(tower_5, mu_hubw2, undefined, undefined)
addRoomMusic(tower_entrancehall, mu_hubw2, undefined, undefined)
addRoomMusic(tower_johngutterhall, mu_hubw2, undefined, undefined)
addRoomMusic(entryway_1, mu_entryway, mu_entrywaysecret, undefined)
addRoomMusic(entrance_1, mu_entryway, mu_entrywaysecret, undefined)
addRoomMusic(rooftop_1, mu_rooftop, mu_rooftopsecret, undefined)
addRoomMusic(steamy_1, mu_steamy, mu_steamysecret, function(arg0, arg1, arg2)
{
    var event_state = undefined;
    
    switch (arg0)
    {
		case steamy_1:
		case steamy_7:
			event_state = 0
			break
		
		case steamy_8:
			event_state = 1
			break
		
		case steamy_sideroom:
			event_state = 2
			break
	}
	
	if (!is_undefined(event_state))
		fmod_studio_event_instance_set_parameter_by_name(arg1, "state", event_state, true)
    
    var cotton_volume = 0;
    
    if (instance_exists(obj_player1))
    {
        var transfo = scr_transformationCheck(obj_player1.state);
        
        if (transfo == "Werecotton")
            cotton_volume = 1;
    }
    
    fmod_set_layer_volume(arg1, cotton_volume, 500);
}, [
{
    asset: mu_steamy,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_steamy2,
    seek_position: 0,
    fade_time: 800
}, 
{
    asset: mu_harry,
    seek_position: 0,
    fade_time: 1000
}], [mu_steamy2_1, mu_steamy2_2, undefined]);
addRoomMusic(molasses_1, mu_molasses, mu_molassessecret, function(arg0, arg1, arg2)
{
	var event_state = undefined
	
	switch (arg0)
	{
		case molasses_1:
		case molasses_6:
			event_state = 0
			break
		
		case molasses_7:
			event_state = 1
			break
	}
	
	if (!is_undefined(event_state))
		fmod_studio_event_instance_set_parameter_by_name(arg1, "state", event_state, false)
	
	var frog = false
	
	with (obj_flingFrog)
	{
		if (bbox_in_camera(self, view_camera[0], 100))
		{
			frog = true
			break
		}
	}
	
	var player_state = get_playerState()
	
	if (player_state == PlayerState.fling || player_state == PlayerState.fling_launch)
		frog = true
	
	fmod_studio_event_instance_set_parameter_by_name(arg1, "frog", frog, false)
}, [
{
    asset: mu_molasses,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_molasses_found,
    seek_position: 0,
    fade_time: 600
}]);
addRoomMusic(mineshaft_1, mu_mineshaft, mu_mineshaftsecret, function(arg0, arg1, arg2)
{
	var event_state = global.minesProgress
	
	if (!is_undefined(event_state))
		fmod_studio_event_instance_set_parameter_by_name(arg1, "state", event_state, false)
})
addRoomMusic(mountain_intro, mu_mountain1, mu_mountainsecret, function(arg0, arg1, arg2)
{
	var event_state = undefined
	
	switch (arg0)
	{
		case mountain_intro:
		case mountain_1:
		case mountain_5:
			event_state = 0
			break
		
		case mountain_6:
			event_state = 1
			break
	}
	
	if (!is_undefined(event_state))
		fmod_studio_event_instance_set_parameter_by_name(arg1, "state", event_state, false)
}, [
{
    asset: mu_mountain1,
    seek_position: 0,
    fade_time: 0
}, 
{
    asset: mu_mountain2,
    seek_position: 0,
    fade_time: 700
}]);
addRoomMusic(cafe_1, mu_cafe, mu_entrywaysecret, undefined);
addRoomMusic(secret_entrance, mu_secretworld, undefined, undefined);
