if (global.lapcount > (global.laphell ? 2 : 0))
{
	add_saveroom()
	instance_destroy()
	exit
}

with (instance_place(x, y, obj_parent_doortrigger))
	other.targetDoor = id_door

image_alpha = 0.5
ini_open(global.SaveFileName)

if (ini_read_string("Ranks", string(global.InternalLevelName), "none") == "none" && !ini_read_real("Misc", "lapunlockall", false))
	sprite_index = spr_lappingportal_inactive

ini_close()

if (global.panic && sprite_index != spr_lappingportal_inactive)
{
	image_alpha = 1
	
	with (obj_lapjanitor_CutscenePointer)
	{
		sprite_index = spr_janitor_summonIntro
		image_index = 0
		image_speed = 0
	}
}

if in_saveroom()
{
	if (instance_exists(obj_lapjanitor_CutscenePointer))
		instance_destroy(obj_lapjanitor_CutscenePointer)
	
	instance_destroy()
}
