function scr_playersounds_init()
{
    sndMach1 = fmod_createEventInstance(sfx_PZ_mach1, false);
    sndMach2 = fmod_createEventInstance(sfx_PZ_mach2, false);
    sndMach3 = fmod_createEventInstance(sfx_PZ_mach3, false);
    sndMach4 = fmod_createEventInstance(sfx_PZ_mach4, false);
	sndMachStart = fmod_createEventInstance("event:/SFX/player/machStart")
	sndGalloping = fmod_createEventInstance("event:/SFX/general/galloping")
	sndSpinning = fmod_createEventInstance("event:/SFX/player/spin")
	spinSoundBuffer = 0
	sndSuplex = fmod_createEventInstance("event:/SFX/player/suplexdash")
	sndKungFu = fmod_createEventInstance("event:/SFX/player/kungfu")
	sndJump = fmod_createEventInstance(sfx_PZ_jump, false)
    sndWallkick = fmod_createEventInstance(sfx_wallkick, false);
    sndWallkickCancel = fmod_createEventInstance(sfx_wallkickcancel, false);
	sndWallkickStart = fmod_createEventInstance("event:/SFX/player/wallKickIntro")
	sndWallkickLand = fmod_createEventInstance("event:/SFX/player/wallKickLand")
	sndFreefall = fmod_createEventInstance("event:/SFX/player/freefall")
	sndSuperjump = fmod_createEventInstance("event:/SFX/player/superjump")
	sndSuperjumpRelease = fmod_createEventInstance("event:/SFX/player/superjumprelease")
	sndCottonDigging = fmod_createEventInstance("event:/SFX/cotton/digging")
	sndTumble = fmod_createEventInstance("event:/SFX/player/tumble")
	sndRoll = fmod_createEventInstance("event:/SFX/player/machroll")
	sndGrind = fmod_createEventInstance("event:/SFX/player/grind")
	sndFireass = fmod_createEventInstance("event:/SFX/player/fireass")
	sndCrouchslide = fmod_createEventInstance("event:/SFX/player/crouchslide")
	sndRollGetUp = fmod_createEventInstance("event:/SFX/player/rollgetup")
	sndDive = fmod_createEventInstance("event:/SFX/player/dive")
	sndMinecart = fmod_createEventInstance("event:/SFX/minecart/minecart")
	sndMinecartJump = fmod_createEventInstance("event:/SFX/minecart/jump")
	voiceScream = fmod_createEventInstance("event:/SFX/player/voice/scream")
    voiceCollect = fmod_createEventInstance(choose(PZvoice6, PZvoice10, PZvoice12), false);
    voiceTransfo = fmod_createEventInstance(choose(PZvoice7, PZvoice18, PZvoice19, PZvoice20, PZvoice22), false);
    voiceDetransfo = fmod_createEventInstance(choose(PZvoice7, PZvoice18, PZvoice19, PZvoice20, PZvoice22), false);
    voiceIdle = fmod_createEventInstance(choose(PZvoice1, PZvoice2, PZvoice3, PZvoice4, PZvoice5, PZvoice6, PZvoice7, PZvoice8, PZvoice21), false);
    voiceHurt = fmod_createEventInstance(choose(PZvoice14, PZvoice15, PZvoice16, PZvoice17), false);
	transfoSound = undefined
	oldTransfoSound = undefined
	mySoundArray = [sndMach1, sndMach2, sndMach3, sndMach4, sndMachStart, sndSuplex, sndKungFu, sndGalloping, sndJump, sndWallkick, sndWallkickCancel, sndWallkickStart, sndWallkickLand, sndFreefall, sndSuperjump, sndSuperjumpRelease, sndCottonDigging, sndMinecart, sndTumble, sndRoll, sndGrind, sndFireass, sndCrouchslide, sndRollGetUp, sndDive, sndMinecart, sndMinecartJump, voiceScream, voiceCollect, voiceTransfo, voiceDetransfo, voiceIdle, voiceHurt]
    
    for (var i = 0; i < array_length(mySoundArray); i++)
    {
        var snd_id = mySoundArray[i];
        
        if (is_struct(snd_id))
            snd_id.base_gain = 1.5;
    }
}

function scr_playersounds()
{
	var saved_state = global.freezeframe ? frozenState : state
	
	if (saved_state != PlayerState.actor)
	{
		transfoSound = scr_transformationCheck(saved_state)
		var _has_transfo = !is_undefined(transfoSound)
		fmod_studio_system_set_parameter_by_name("transfo", _has_transfo, false)
		
		if (oldTransfoSound != transfoSound && transfoSound != "Ball")
		{
			oldTransfoSound = transfoSound
			
			if (chance(50))
				fmod_studio_event_instance_start(_has_transfo ? voiceTransfo : voiceDetransfo)
			
			event_play_oneshot(_has_transfo ? "event:/SFX/general/transfo" : "event:/SFX/general/detransfo", x, y)
			
			switch (_has_transfo ? transfoSound : oldTransfoSound)
			{
				case "Werecotton":
					if (!_has_transfo)
						event_play_oneshot("event:/SFX/cotton/lose", x, y)
					
					break
			}
		}
	}
	
	if (sprite_index == spr_tumble)
	{
		if (!event_instance_isplaying(sndTumble))
		{
			fmod_studio_event_instance_set_parameter_by_name(sndTumble, "state", 1, true)
			fmod_studio_event_instance_start(sndTumble)
		}
	}
	else if (event_instance_isplaying(sndTumble))
	{
		fmod_studio_event_instance_stop(sndTumble, false)
	}
	
	if (event_instance_isplaying(sndSuplex) && saved_state != PlayerState.grabdash)
		fmod_studio_event_instance_stop(sndSuplex, true)
	
	if (saved_state == PlayerState.wallkick && (sprite_index == spr_wallJumpIntro || sprite_index == spr_wallJump))
	{
		if (!event_instance_isplaying(sndWallkick))
			fmod_studio_event_instance_start(sndWallkick)
	}
	else
	{
		fmod_studio_event_instance_stop(sndWallkick, false)
	}
	
	if (saved_state == PlayerState.minecart && grounded && vsp > 0 && sprite_index != spr_player_PZ_minecart_spinOut)
	{
		if (!event_instance_isplaying(sndMinecart))
			fmod_studio_event_instance_start(sndMinecart)
	}
	else
	{
		fmod_studio_event_instance_stop(sndMinecart, false)
	}
	
	if ((saved_state == PlayerState.grind && grounded && vsp > 0) || saved_state == PlayerState.hang)
	{
		if (!event_instance_isplaying(sndGrind))
			fmod_studio_event_instance_start(sndGrind)
	}
	else
	{
		fmod_studio_event_instance_stop(sndGrind, false)
	}
	
	if (saved_state == PlayerState.charge)
	{
		if (spinSoundBuffer-- < 0)
		{
			fmod_studio_event_instance_start(sndSpinning)
			fmod_event_set3DPosition(sndSpinning, x, y, 0)
			spinSoundBuffer = 14
		}
	}
	else
	{
		spinSoundBuffer = 0
		fmod_studio_event_instance_stop(sndSpinning, true)
	}
	
	if (saved_state == PlayerState.cottondig && place_meeting(x, y, obj_cottonsolid))
	{
		if (!event_instance_isplaying(sndCottonDigging))
		{
			fmod_studio_event_instance_start(sndCottonDigging)
			event_play_oneshot("event:/SFX/cotton/digIn", x, y)
		}
	}
	else if (event_instance_isplaying(sndCottonDigging))
	{
		fmod_studio_event_instance_stop(sndCottonDigging, false)
		event_play_oneshot("event:/SFX/cotton/digOut", x, y)
	}
	
	if (saved_state == PlayerState.machroll)
	{
		if (!event_instance_isplaying(sndRoll))
			fmod_studio_event_instance_start(sndRoll)
		else
			fmod_studio_event_instance_set_parameter_by_name(sndRoll, "state", mach3Roll > 0, true)
	}
	else
	{
		fmod_studio_event_instance_stop(sndRoll, true)
	}
	
	if (grounded && saved_state == PlayerState.doughmount && movespeed >= 12 && sprite_index != spr_player_PZ_dogMount_skid)
	{
		if (!event_instance_isplaying(sndGalloping))
			fmod_studio_event_instance_start(sndGalloping)
	}
	else if (event_instance_isplaying(sndGalloping))
	{
		fmod_studio_event_instance_stop(sndGalloping, true)
	}
	
	if (saved_state == PlayerState.freefall || saved_state == PlayerState.freefallprep || saved_state == PlayerState.superslam)
	{
		if (!event_instance_isplaying(sndFreefall))
			fmod_studio_event_instance_start(sndFreefall)
	}
	else
	{
		fmod_studio_event_instance_stop(sndFreefall, true)
	}
	
	if (saved_state == PlayerState.Sjumpprep)
	{
		if (!event_instance_isplaying(sndSuperjump))
			fmod_studio_event_instance_start(sndSuperjump)
	}
	else if (event_instance_isplaying(sndSuperjump))
	{
		fmod_studio_event_instance_stop(sndSuperjump, true)
		fmod_studio_event_instance_start(sndSuperjumpRelease)
	}
	
	if ((saved_state != PlayerState.Sjump || sprite_index == spr_superjumpCancelIntro) && event_instance_isplaying(sndSuperjumpRelease))
		fmod_studio_event_instance_stop(sndSuperjumpRelease, true)
	
	if (saved_state == PlayerState.mach2 || saved_state == PlayerState.run || saved_state == PlayerState.mach3 || saved_state == PlayerState.climbwall)
	{
        var machsnd = 0;
        var current_mach_sound = undefined;
		
		if ((saved_state == PlayerState.mach2 && sprite_index == spr_mach1) || (saved_state == PlayerState.run && sprite_index == spr_mach1))
        {
            machsnd = 1;
            current_mach_sound = sndMach1;
        }
		else if ((saved_state == PlayerState.mach2 && sprite_index == spr_mach2) || (saved_state == PlayerState.run && movespeed < 12) || (saved_state == PlayerState.climbwall && verticalMovespeed < 12))
        {
            machsnd = 2;
            current_mach_sound = sndMach2;
        }
		else if ((saved_state == PlayerState.mach3 && sprite_index != spr_crazyrun) || saved_state == PlayerState.run || (saved_state == PlayerState.climbwall && verticalMovespeed >= 12))
        {
            machsnd = 3;
            current_mach_sound = sndMach3;
        }
		else if (sprite_index == spr_crazyrun)
        {
            machsnd = 4;
            current_mach_sound = sndMach4;
        }
        
        if (machsnd > 0 && !event_instance_isplaying(current_mach_sound))
            fmod_studio_event_instance_start(current_mach_sound, true);
        
        if (event_instance_isplaying(sndMach1) && machsnd != 1)
            fmod_studio_event_instance_stop(sndMach1, true);
        
        if (event_instance_isplaying(sndMach2) && machsnd != 2)
            fmod_studio_event_instance_stop(sndMach2, true);
        
        if (event_instance_isplaying(sndMach3) && machsnd != 3)
            fmod_studio_event_instance_stop(sndMach3, true);
        
        if (event_instance_isplaying(sndMach4) && machsnd != 4)
            fmod_studio_event_instance_stop(sndMach4, true);
	}
	else
	{
        fmod_studio_event_instance_stop(sndMach1, true);
        fmod_studio_event_instance_stop(sndMach2, true);
        fmod_studio_event_instance_stop(sndMach3, true);
        fmod_studio_event_instance_stop(sndMach4, true);
	}
	
	for (var i = 0; i < array_length(mySoundArray); i++)
	{
		var snd_id = mySoundArray[i]
		
		if (event_instance_isplaying(snd_id))
			fmod_quick3D(snd_id)
	}
}
