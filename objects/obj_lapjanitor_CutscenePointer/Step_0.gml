if (image_speed != 0.35 && sprite_index == spr_janitor_summonIntro && point_distance(xstart, ystart, obj_parent_player.x, obj_parent_player.y) <= 500)
{
	image_index = 0
	image_speed = 0.35
}

if (sprite_animation_end())
{
	switch (sprite_index)
	{
		case spr_janitor_summonIntro:
			sprite_index = spr_janitor_summonIdle
			break
		
		case spr_janitor_summonIdle:
			sprite_index = spr_janitor_summonPresent
			break
		
		case spr_janitor_summonPresent:
			image_speed = 0
			break
	}
}
