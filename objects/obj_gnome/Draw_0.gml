if (sprite_index == spr_gnomeMinerIdle && !in_saveroom())
	draw_sprite(spr_donutbubble, don, x, y - 35)

pal_swap_set(pal_gnome, colorID - 1, false)
draw_self()
pal_swap_reset()
