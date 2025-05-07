if !in_baddieroom()
{
	if (wasInAir)
		scr_task_notify("task_sm_slug", [room])
}

event_inherited()
