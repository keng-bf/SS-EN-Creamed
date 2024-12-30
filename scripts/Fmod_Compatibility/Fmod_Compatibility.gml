function fmod_init(argument0, argument1 = FMOD_INIT.NORMAL, argument2 = FMOD_STUDIO_INIT.NORMAL)
{
    return fmod_studio_system_init(argument0, argument1, argument2);
}

function fmod_loadBank(argument0, argument1 = FMOD_STUDIO_LOAD_BANK.NORMAL)
{
    return fmod_studio_system_load_bank_file(argument0, argument1);
}

function fmod_createEventInstance(argument0)
{
    var event_description, event_instance;
    
    event_description = fmod_studio_system_get_event(argument0);
    event_instance = fmod_studio_event_description_create_instance(event_description);
    array_push(global.FMOD_EventInstances, [event_instance, fmod_studio_event_description_get_path(event_description)]);
    return event_instance;
}

function fmod_event_getParameter(argument0, argument1)
{
    var param;
    
    param = fmod_studio_event_instance_get_parameter_by_name(argument0, argument1);
    return param.value;
}

function fmod_event_set3DPosition(argument0, argument1, argument2, argument3 = 0)
{
    var attributes;
    
    attributes = global.FMOD_default3DAttributes;
    attributes.position = 
    {
        x: argument1,
        y: argument2,
        z: argument3
    };
    fmod_studio_event_instance_set_3d_attributes(argument0, attributes);
}

function fmod_global_getParameter(argument0)
{
    var param;
    
    param = fmod_studio_system_get_parameter_by_name(argument0);
    return param.value;
}

function fmod_getEventLength(argument0)
{
    var event_description;
    
    event_description = fmod_studio_system_get_event(argument0);
    return fmod_studio_event_description_get_length(event_description);
}

function fmod_event_setPause_all(argument0)
{
    var i;
    
    for (i = 0; i < array_length(global.FMOD_EventInstances); i++)
    {
        if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
            fmod_studio_event_instance_set_paused(global.FMOD_EventInstances[i][0], argument0);
    }
}

function fmod_event_release_all()
{
    var i;
    
    for (i = 0; i < array_length(global.FMOD_EventInstances); i++)
    {
        if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
            fmod_studio_event_instance_release(global.FMOD_EventInstances[i][0]);
    }
}

function fmod_event_stop_all(argument0)
{
    var i;
    
    for (i = 0; i < array_length(global.FMOD_EventInstances); i++)
    {
        if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
            fmod_studio_event_instance_stop(global.FMOD_EventInstances[i][0], argument0);
    }
}

function fmod_event_getEventPath(argument0)
{
    var event_description;
    
    event_description = fmod_studio_event_instance_get_description(argument0);
    return fmod_studio_event_description_get_path(event_description);
}