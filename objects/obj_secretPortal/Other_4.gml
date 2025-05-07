visible = secretActivated

with (instance_place(x, y, obj_parent_doortrigger))
	other.targetDoor = id_door

if (in_saveroom() && object_index == obj_secretPortal)
{
	instance_destroy()
	instance_create(x, y, obj_tilePaintSplatter, 
	{
		createSplash: false,
		blendColor: #6F5BAB
	})
}
