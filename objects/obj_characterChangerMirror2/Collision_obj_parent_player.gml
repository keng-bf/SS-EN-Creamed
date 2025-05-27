with (other)
{
	var inp = input_check_pressed("up") - input_check_pressed("down"),inpup = input_get("up").pressed || input_get("upC").pressed,inpdown = input_get("down").pressed || input_get("downC").pressed
	inp = inpup - inpdown
	
	if (inp != 0 && grounded && state == PlayerState.normal)
	{
		create_particle(x, y, spr_genericPoofEffect)
		event_play_oneshot("event:/SFX/general/switchstart", x, y)
		if global.playerCharacter == Characters.Peppino
			scr_player_changeCharacter(obj_parent_player, Characters.Pizzelle)
		else
			scr_player_changeCharacter(obj_parent_player, Characters.Peppino)
	}
}
