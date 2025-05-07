if in_baddieroom()
	instance_destroy(id, false)

if (escapeEnemy)
	state = PlayerState.wallkick
else
	scr_enemyDestroyableCheck()
