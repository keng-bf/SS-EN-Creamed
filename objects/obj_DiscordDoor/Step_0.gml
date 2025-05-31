var arrow_condition = place_meeting(x, y, obj_parent_player) && obj_parent_player.state == PlayerState.normal && obj_parent_player.grounded

with (manage_up_arrow(arrow_condition))
	sprite_index = spr_uparrow