if in_saveroom()
	instance_destroy()

if (get_panic() && !in_saveroom())
	add_saveroom()
