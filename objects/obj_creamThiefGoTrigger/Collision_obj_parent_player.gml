if (instance_exists(obj_creamThief) && !in_saveroom())
{
	with (obj_creamThief)
	{
		movespeed = 0
		hsp = 0
		state = PlayerState.stun
		sprite_index = spr_creamthief_startRace
		image_index = 0
	}
	
	add_saveroom()
}
