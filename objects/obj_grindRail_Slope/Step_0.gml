with (obj_parent_player)
{
	if (state != PlayerState.noclip && state != PlayerState.cotton && state != PlayerState.cottondrill && state != PlayerState.cottonroll && state != PlayerState.tumble && state != PlayerState.taunt && state != PlayerState.bump && state != PlayerState.actor && state != PlayerState.frozen)
	{
		if (place_meeting_slopePlatform(x, y + 1, other) && vsp >= 0 && state != PlayerState.grind)
		{
            if (state == PlayerState.machcancel)
            {
                if (move != 0)
                    xscale = move;
                else if (savedmove != 0)
                    xscale = dir;
                else if (movespeed != 0)
                    xscale = sign(movespeed);
                
                movespeed = abs(hsp);
            }
            
			state = PlayerState.grind
			vsp = 0
		}
	}
}
