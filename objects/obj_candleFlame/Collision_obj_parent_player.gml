var _check

with (other)
	_check = movespeed >= 12 && sprite_index != spr_longJump && sprite_index != spr_longJump_intro && (state == PlayerState.mach2 || state == PlayerState.mach3 || (state == PlayerState.run && movespeed >= 12) || (state == PlayerState.machroll && mach3Roll > 0))

if (_check && !in_saveroom())
{
	visible = true
	add_saveroom()
}
