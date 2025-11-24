if (global.InternalLevelName != "none")
{
	pausecount = -1
	
	if (surface_exists(pauseSurface))
		surface_free(pauseSurface)
	
	fmod_event_setPause_all(false)
	scr_unpause_instances(true)
	audio_stop_all()
	scr_levelSet()
	room = global.LevelFirstRoom
	global.gamePauseState = 0
	
	with (obj_parent_player)
		targetDoor = "A"
	
	with (instance_create(x, y, obj_fadeoutTransition))
	{
		fadealpha = 1
		fadein = true
	}
}
else
{
	event_play_oneshot(sfx_enemyprojectile)
}
