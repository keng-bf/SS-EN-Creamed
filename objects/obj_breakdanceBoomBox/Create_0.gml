scr_collision_init()
sprite_index = scr_getCharacterSprite(spr_player_PZ_breakDanceBox)
grav = 0.5
depth = -4
event_play_oneshot(sfx_breakdance, x, y)
songInst = fmod_createEventInstance(mu_breakdance)
fmod_studio_event_instance_start(songInst)
fmod_studio_event_instance_set_paused(songInst, true)
fmod_quick3D(songInst)
