if !in_saveroom()
{
	event_play_multiple("event:/SFX/general/collect", x, y)
	
	with (instance_create(0, 540 + sprite_get_height(spr_caferank1), obj_caferank))
		collect = 400
	
	instance_destroy(obj_milkblock)
	global.CafeDrawer.dunk = true
	add_saveroom()
}

sprite_index = spr_milkgoal_filled
