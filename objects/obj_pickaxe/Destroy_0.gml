if !in_saveroom()
{
	for (var i = 0; i < sprite_get_number(spr_pickaxeDebris); i++)
	{
		var d = create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_pickaxeDebris, 0)
		d.image_index = i
	}
	
	create_particle(x, y, spr_bangEffect)
	add_saveroom()
}
