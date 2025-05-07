if !in_saveroom()
{
	var rep = 3 + round(sprite_width / 16)
	
	repeat (rep)
		create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_blockdebris)
	
	create_destroyable_smoke(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), array_get_any(smokeColor))
	event_play_multiple("event:/SFX/general/breakblock", x, y)
	add_saveroom()
}
