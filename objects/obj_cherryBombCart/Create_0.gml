canCollide = function(stpl, player = obj_parent_player)
{
	switch (player.object_index)
	{
		case obj_parent_player:
		case obj_player1:
			var _state = global.freezeframe ? player.frozenState : player.state
			return _state == PlayerState.mach3 || (_state == PlayerState.run && player.movespeed >= 12) || _state == PlayerState.frostburnslide || (_state == PlayerState.frostburnjump && player.movespeed > 5) || _state == PlayerState.puddle || (_state == PlayerState.machroll && player.mach3Roll > 0) || _state == PlayerState.minecart || (_state == PlayerState.bottlerocket && player.substate == 0);
			break
		
		default:
			return true;
			break
	}
}

hsp = 0
