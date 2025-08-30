with (other)
{
	var inp = input_check_pressed("up"),inpup = input_get("up").pressed || input_get("upC").pressed
	inp = inpup
	
	if (inp != 0 && grounded && state == PlayerState.normal)
	{
		create_particle(x, y, spr_genericPoofEffect)
		event_play_oneshot("event:/SFX/general/switchstart", x, y)
		switch global.playerCharacter
		{
			case Characters.Pizzelle:
				scr_player_changeCharacter(obj_parent_player, Characters.Pizzano)
				break
			case Characters.Pizzano:
				scr_player_changeCharacter(obj_parent_player, Characters.Gumbob)
				break
			case Characters.Gumbob:
				scr_player_changeCharacter(obj_parent_player, Characters.Coneboy)
				break
			case Characters.Coneboy:
				scr_player_changeCharacter(obj_parent_player, Characters.Peppino)
				break
			case Characters.Peppino:
				scr_player_changeCharacter(obj_parent_player, Characters.Noise)
				break
			case Characters.Noise:
				scr_player_changeCharacter(obj_parent_player, Characters.Vigilante)
				break
			case Characters.Vigilante:
				scr_player_changeCharacter(obj_parent_player, Characters.Pizzelle)
				break/*
			case Characters.Pizzelle:
				scr_player_changeCharacter(obj_parent_player, Characters.Pizzano)
				break
			case Characters.Pizzelle:
				scr_player_changeCharacter(obj_parent_player, Characters.Pizzano)
				break
			case Characters.Pizzelle:
				scr_player_changeCharacter(obj_parent_player, Characters.Pizzano)
				break*/
				
		}
	}
}
