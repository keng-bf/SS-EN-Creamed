var target_player = get_nearestPlayer()

if (distance_to_object(target_player) <= 350 || global.LevelMinutes >= 1)
{
	if !in_saveroom()
	{
		add_saveroom()
		event_play_oneshot("event:/SFX/general/teleporterstart", x, y)
		create_particle(x, y, spr_teleportEffect)
	}
	
	instance_destroy()
}
