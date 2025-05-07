if (global.panic || !panicmode)
{
	if (!in_saveroom() && can_activate && !activated)
	{
		with (obj_collectablebox)
		{
			if (unid == other.unid)
				alarm[1] = 16
		}
		
		with (obj_collectableboxtrigger)
		{
			if (trigger == other.trigger)
				can_activate = true
		}
		
		activated = true
		add_saveroom()
		instance_destroy()
	}
}
