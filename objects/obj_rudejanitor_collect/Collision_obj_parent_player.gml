if !in_saveroom()
{
	with (instance_create(x, y, obj_rudejanitor))
		global.janitorRudefollow = true
	
	create_particle(x, y, spr_taunteffect).particle_depth(obj_rudejanitor.depth + 1)
	event_play_oneshot("event:/SFX/general/janitorGot", x, y)
	global.ComboTime = 60
	add_saveroom()
	instance_destroy()
	scr_queueTVAnimation(spr_tvHUD_janitorTreasure, 150)
}
