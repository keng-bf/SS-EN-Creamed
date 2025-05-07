with (instance_place(x, y, obj_collectablebox))
{
	if (!in_saveroom() && !activated)
	{
		other.collectvanish = true
		other.collectboxid = id
		other.x = -200
		other.y = -200
		in_the_void = true
	}
}

if in_saveroom()
	instance_destroy()
