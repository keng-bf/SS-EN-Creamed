if !in_saveroom()
{
	with (instance_create(x + (32 * image_xscale), y + (32 * image_yscale), obj_baddieDead))
		sprite_index = spr_milkblock_dead
	
	camera_shake_add(20, 40)
	event_play_oneshot("event:/SFX/enemies/killingblow", x, y)
	add_saveroom()
}
