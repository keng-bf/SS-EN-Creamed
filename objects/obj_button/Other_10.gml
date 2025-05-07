if (currentState == PlayerState.frozen)
{
	currentState = PlayerState.titlescreen
	sprite_index = spr_Lowering
	
	if (save_trigger && !in_saveroom())
		add_saveroom()
}
