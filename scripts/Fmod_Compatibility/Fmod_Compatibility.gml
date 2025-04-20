function fmod_init(arg0, arg1 = FMOD_INIT.NORMAL, arg2 = FMOD_STUDIO_INIT.NORMAL)
{
	return fmod_studio_system_init(arg0, arg1, arg2);
}

function fmod_loadBank(arg0, arg1 = FMOD_STUDIO_LOAD_BANK.NORMAL)
{
	return fmod_studio_system_load_bank_file(arg0, arg1);
}

function fmod_createEventInstance(arg0)
{
	var event_description = fmod_studio_system_get_event(arg0)
	var event_instance = fmod_studio_event_description_create_instance(event_description)
	array_push(global.FMOD_EventInstances, [event_instance, fmod_studio_event_description_get_path(event_description)])
	return event_instance;
}

function fmod_event_getParameter(arg0, arg1)
{
	var param = fmod_studio_event_instance_get_parameter_by_name(arg0, arg1)
	return param.value;
}

function fmod_event_set3DPosition(arg0, arg1, arg2, arg3 = 0)
{
	var attributes = global.FMOD_default3DAttributes
	attributes.position = 
	{
		x: arg1,
		y: arg2,
		z: arg3
	}
	fmod_studio_event_instance_set_3d_attributes(arg0, attributes)
}

function fmod_global_getParameter(arg0)
{
	var param = fmod_studio_system_get_parameter_by_name(arg0)
	return param.value;
}

function fmod_getEventLength(arg0)
{
	var event_description = fmod_studio_system_get_event(arg0)
	return fmod_studio_event_description_get_length(event_description);
}

function fmod_event_setPause_all(arg0)
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_set_paused(global.FMOD_EventInstances[i][0], arg0)
	}
}

function fmod_event_release_all()
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_release(global.FMOD_EventInstances[i][0])
	}
}

function fmod_event_stop_all(arg0)
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_stop(global.FMOD_EventInstances[i][0], arg0)
	}
}

function fmod_event_getEventPath(arg0)
{
	var event_description = fmod_studio_event_instance_get_description(arg0)
	return fmod_studio_event_description_get_path(event_description);
}
