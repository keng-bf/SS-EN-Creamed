if in_baddieroom()
	instance_destroy(id, false)

if (escapeEnemy)
	state = EnemyStates.panicWait
else
	scr_enemyDestroyableCheck()
