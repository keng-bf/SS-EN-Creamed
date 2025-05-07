if !in_saveroom()
{
	event_play_oneshot("event:/SFX/enemies/kill")
	event_play_oneshot("event:/SFX/player/punch", x, y)
	event_play_oneshot((object_index == obj_chocofrog_tumble) ? "event:/SFX/general/frogdeathbig" : "event:/SFX/general/frogdeath", x, y)
	obj_parent_player.superTauntBuffer++
	global.Combo++
	var _score = 10 * power(2, global.Combo - 1)
	_score = clamp(_score, 10, 80)
	create_small_number(x, y, string(_score))
	global.Collect += _score
	global.ComboTime = 60
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_bangEffect)
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_enemypuncheffect)
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), (object_index == obj_chocofrogsmall) ? spr_smallpoof : spr_poofeffect)
	
	with (instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_baddieDead))
		sprite_index = other.deadSpr
	
	add_saveroom()
}
