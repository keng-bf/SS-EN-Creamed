if !in_saveroom()
{
	var rep = 3 + round(sprite_width / 16)
	
	repeat (rep)
		create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_waferdestroyable_debris)
	
	event_play_multiple("event:/SFX/general/breakblock", (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2))
	add_saveroom()
}
