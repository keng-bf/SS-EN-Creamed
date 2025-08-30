event_inherited()
baddieSpriteIdle = spr_nullboy
baddieSpriteWalk = spr_nullboy
baddieSpriteStun = spr_nullboy
baddieSpriteScared = spr_nullboy
baddieSpriteTurn = undefined
baddieSpriteHit = undefined
baddieSpriteDead = spr_nullboy
defaultMovespeed = 0
canSpawnStunBird = false
canGetScared = false

enemyDeath_awardPoints = function()
{
	exit
}

enemyDeath_SpawnBody = function()
{
	var i = 0
	
	if chance(5)
		event_play_oneshot("event:/SFX/enemies/coneboyrareow", x, y)
	
	repeat (3)
	{
		with (instance_create(x, y, obj_juiceDebris))
		{
			paletteSprite = other.paletteSprite
			paletteSelect = other.paletteSelect
			vsp = random_range(-10, 10)
			hsp = random_range(-10, 10)
			image_angle = 0
			image_speed = 0
			sprite_index = spr_nullboydebris
			image_index = i
		}
		
		i++
	}
	instance_create(0, 0, obj_nullface)
}
