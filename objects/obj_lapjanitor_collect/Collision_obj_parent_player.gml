if !in_saveroom()
{
	instance_create(x, y, obj_lapjanitor)
	
	with (instance_create(x, y, obj_mushroomCloudEffect))
	{
		sprite_index = spr_taunteffect
		depth = -2
	}
	
	event_play_oneshot("event:/SFX/general/collectfollower")
	global.ComboTime = 60
	add_saveroom()
	instance_destroy()
}
