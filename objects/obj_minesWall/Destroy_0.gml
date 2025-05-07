if !in_saveroom()
{
	instance_create(x, y, obj_bombExplosion)
	
	repeat (5)
	{
		for (var i = 0; i < (sprite_get_number(spr_minecartdebris) - 1); i++)
		{
			with (create_debris(x + random_range(-10, 10), y + random_range(-10, 10), spr_gnomewalldebris))
				image_index = i
		}
	}
	
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_bangEffect)
	camera_shake_add(20, 40)
	event_play_oneshot("event:/SFX/general/breakmetal", x, y)
	add_saveroom()
	scr_sleep()
}
