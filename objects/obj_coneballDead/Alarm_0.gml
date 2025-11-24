with (instance_create(x, y, obj_baddieDead))
{
	depth = -151
	canrotate = false
	sprite_index = other.sprite_index
	image_xscale = other.image_xscale
}

event_play_oneshot(sfx_killenemy)
instance_destroy()
