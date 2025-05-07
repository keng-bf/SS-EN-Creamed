with (instance_place(x, y, obj_parent_doortrigger))
	other.targetDoor = id_door

if (place_meeting(x, y, obj_parent_player) && !in_saveroom())
{
	add_saveroom()
	showDoorLight = false
}

if in_saveroom()
	showDoorLight = false

if (!useCustomSprite)
{
	sprite_index = spriteDoorDefault
	image_index = global.doorindex
}
else
{
	spriteDoorDefault = sprite_index
	showDoorSprite = true
}

if (is_tutorial())
{
	sprite_index = spr_tutorialdoor
	image_index = 0
	spriteDoorEscape = spr_tutorialdoor
	depth = 110
}
