 if (!place_meeting(x, y, obj_parent_player))
	alpha = approach(alpha, 0, 0.1)
else if (place_meeting(x, y, obj_parent_player))
	alpha = approach(alpha, 1, 0.1)

var arrow_condition = place_meeting(x, y, obj_parent_player) && obj_parent_player.state == PlayerState.normal && obj_parent_player.grounded

with (manage_up_arrow(arrow_condition))
	sprite_index = spr_uparrow

if global.playerCharacter == Characters.Peppino
	sprite_index = spr_player_PZ_idle
else
	sprite_index = spr_player_PP_idle