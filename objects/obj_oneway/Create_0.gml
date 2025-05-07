event_inherited()
onewayDeathSprite = spr_lemonheadblockdead
onewayRank = 1
solidid = -4

if !in_saveroom()
{
	with (instance_create(x, y, obj_solid))
	{
		other.solidid = id
		image_xscale = other.image_xscale
		image_yscale = (other.bbox_bottom - other.bbox_top) / 64
		sprite_index = spr_onewaysolidMASK
		mask_index = spr_onewaysolidMASK
	}
}

image_speed = 0.35
