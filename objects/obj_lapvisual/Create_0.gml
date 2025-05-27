y = -sprite_height
down = 1
movespeed = 2
depth = -100
sprite_index = lang_get_sprite(spr_lapbg)
if global.lapcount == 2
	sprite_index = spr_lapbg2
if global.lapcount == 3
	sprite_index = spr_lapbg3
