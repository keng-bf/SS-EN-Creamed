if !in_saveroom()
{
	instance_create(x + (sprite_width / 2) + random_range(-3, 3), y + (sprite_height / 4) + random_range(-3, 3), obj_bombExplosionHarmful)
	add_saveroom()
}
