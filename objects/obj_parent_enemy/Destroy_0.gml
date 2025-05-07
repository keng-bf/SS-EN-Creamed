if in_baddieroom()
	exit

enemyDeath_SpawnDeathFX()
enemyDeath_awardPoints(importantEnemy)

if (!importantEnemy)
{
	add_baddieroom()
	
	if (escapeEnemy)
		add_escaperoom()
}
