if !in_saveroom()
{
	var rep = 3 + round(sprite_width / 16)
	
	repeat (rep)
		create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_confecticage_debris)
	
	event_play_oneshot("event:/SFX/general/breakglass", x, y)
	add_saveroom()
}
