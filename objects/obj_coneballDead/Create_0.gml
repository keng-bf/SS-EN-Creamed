alarm[0] = 60
shake = 12
depth = -151
sprite_index = global.enmode ? spr_blotchsplotch_dead : spr_coneball_dead
if global.enmode
{
	for (var i = 0; i < 2; i += 1)
	{
		with (instance_create(x, y, obj_baddieDead))
		{
			canrotate = false
			sprite_index = spr_blotchsplotch_deadwing
			image_index = 0
			image_xscale = other.image_xscale
			vsp = -4
			hsp = (i == 1 ? 4 : -4)
			depth = -151
		}
	}
}
