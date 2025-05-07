var target_player = get_nearestPlayer()

if (distance_to_object(target_player) <= 350)
{
	if !in_saveroom()
	{
		add_saveroom()
		moving = true
		image_xscale *= -1
	}
}

if (moving)
{
	sprite_index = spr_thewalker_move
	x += (30 * image_xscale)
}

if (global.gamePauseState == 1)
	instance_destroy()
