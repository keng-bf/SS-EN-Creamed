if !in_saveroom()
{
	with (instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_baddieDead))
		sprite_index = spr_molassescorkpopped
	
	repeat (3)
	{
		instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_slapstar)
		instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_baddieGibs)
	}
	
	create_particle(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_bangEffect)
	event_play_oneshot("event:/SFX/general/bottlepop", (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2))
	add_saveroom()
}
