event_inherited()
onewayDeathSprite = spr_popcornowdead
onewayRank = 0
solidid = -4

if !in_saveroom()
{
	with (instance_create(x, y, obj_solid))
	{
		other.solidid = id
		image_xscale = other.image_xscale
		image_yscale = 1
		mask_index = spr_onewaysmallsolid
		sprite_index = spr_onewaysmallsolid
	}
}

image_speed = 0.35
