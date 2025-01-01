function p1Vibration(argument0, argument1)
{
    with (obj_inputController)
    {
        if (global.controllerVibration)
        {
            vibration1 = argument0 / 100;
            vibrationDecay1 = argument1;
        }
        else
        {
            vibration1 = 0;
            vibrationDecay1 = 0;
        }
    }
    
    gamepad_set_vibration(global.PlayerInputDevice, obj_inputController.vibration1, obj_inputController.vibration1);
}

function scr_initinput()
{
}

function scr_resetinput()
{
    var deadzoneSettings, i, set;
    
    deadzoneSettings = [];
    deadzoneSettings[Deadzones.Master] = ["deadzoneMaster", 0.4];
    deadzoneSettings[Deadzones.Vertical] = ["deadzoneVertical", 0.5];
    deadzoneSettings[Deadzones.Horizontal] = ["deadzoneHorizontal", 0.5];
    deadzoneSettings[Deadzones.Press] = ["deadzonePress", 0.5];
    deadzoneSettings[Deadzones.SJump] = ["deadzoneSJump", 0.8];
    deadzoneSettings[Deadzones.Crouch] = ["deadzoneCrouch", 0.65];
    ini_open("optionData.ini");
    ini_section_delete("Control");
    
    for (i = 0; i < array_length(deadzoneSettings); i++)
    {
        set = deadzoneSettings[i];
        ini_write_real("Settings", set[0], set[1]);
        global.deadzones[i] = set[1];
    }
    
    ini_close();
    scr_input_create();
}

function scr_input_create()
{
    var stickarr, i, s;
    
    if (!variable_global_exists("input_map"))
        global.input_map = ds_map_create();
    
    if (!variable_global_exists("stickpressed"))
    {
        global.stickpressed = ds_map_create();
        stickarr = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
        stickarr = array_concat(stickarr, stickarr);
        
        for (i = 0; i < array_length(stickarr); i++)
        {
            s = string(stickarr[i]);
            
            if (i >= ((array_length(stickarr) / 2) - 1))
                s += "_inv";
            
            ds_map_set(global.stickpressed, s, false);
        }
    }
    
    ini_open("optionData.ini");
    scr_input_ini_read("up", false, [38]);
    scr_input_ini_read("down", false, [40]);
    scr_input_ini_read("left", false, [37]);
    scr_input_ini_read("right", false, [39]);
    scr_input_ini_read("jump", false, [90]);
    scr_input_ini_read("slap", false, [88]);
    scr_input_ini_read("taunt", false, [67]);
    scr_input_ini_read("shoot", false, [65]);
    scr_input_ini_read("attack", false, [16]);
    scr_input_ini_read("superjump", false, []);
    scr_input_ini_read("groundpound", false, []);
    scr_input_ini_read("start", false, [27]);
    scr_input_ini_read("special", false, [86]);
    scr_input_ini_read("menuup", false, [38]);
    scr_input_ini_read("menudown", false, [40]);
    scr_input_ini_read("menuleft", false, [37]);
    scr_input_ini_read("menuright", false, [39]);
    scr_input_ini_read("menuconfirm", false, [90, 32]);
    scr_input_ini_read("menuback", false, [88]);
    scr_input_ini_read("menudelete", false, [67]);
    scr_input_ini_read("upC", true, [gp_padu, gp_axislv], true, true);
    scr_input_ini_read("downC", true, [gp_padd, gp_axislv], true, false);
    scr_input_ini_read("leftC", true, [gp_padl, gp_axislh], true, true);
    scr_input_ini_read("rightC", true, [gp_padr, gp_axislh], true, false);
    scr_input_ini_read("jumpC", true, [gp_face1], true);
    scr_input_ini_read("slapC", true, [gp_face3], true);
    scr_input_ini_read("tauntC", true, [gp_face4], true);
    scr_input_ini_read("shootC", true, [gp_face2], true);
    scr_input_ini_read("attackC", true, [gp_shoulderr, gp_shoulderrb], true);
    scr_input_ini_read("superjumpC", true, [], true);
    scr_input_ini_read("groundpoundC", true, [], true);
    scr_input_ini_read("startC", true, [gp_start], true);
    scr_input_ini_read("specialC", true, [gp_shoulderlb], true);
    scr_input_ini_read("menuupC", true, [gp_padu, gp_axislv], true, true);
    scr_input_ini_read("menudownC", true, [gp_padd, gp_axislv], true, false);
    scr_input_ini_read("menuleftC", true, [gp_padl, gp_axislh], true, true);
    scr_input_ini_read("menurightC", true, [gp_padr, gp_axislh], true, false);
    scr_input_ini_read("menuconfirmC", true, [gp_face1], true);
    scr_input_ini_read("menubackC", true, [gp_face3, gp_face2], true);
    scr_input_ini_read("menudeleteC", true, [gp_face4], true);
    ini_close();
}

function input_get(argument0)
{
    return ds_map_find_value(global.input_map, argument0);
}

function input_save(argument0)
{
    var gpCheck, key, str, i;
    
    gpCheck = false;
    key = string_replace(argument0.name, "C", "");
    
    if (string_length(key) < string_length(argument0.name))
        gpCheck = true;
    
    str = "";
    
    if (!gpCheck)
    {
        for (i = 0; i < array_length(argument0.keyInputs); i++)
        {
            if (str == "")
                str = argument0.keyInputs[i];
            else
                str = string_concat(str, ",", argument0.keyInputs[i]);
        }
        
        argument0.keyLen = array_length(argument0.keyInputs);
    }
    else
    {
        for (i = 0; i < array_length(argument0.gpInputs); i++)
        {
            if (str == "")
                str = argument0.gpInputs[i];
            else
                str = string_concat(str, ",", argument0.gpInputs[i]);
        }
        
        argument0.gpLen = array_length(argument0.gpInputs);
    }
    
    trace(string("Trace input_save: {0} = {1}", argument0.name, str));
    ini_open("optionData.ini");
    ini_write_string("Control", argument0.name, str);
    ini_close();
}

function scr_input_add(argument0, argument1)
{
    argument1.keyLen = array_length(argument1.keyInputs);
    argument1.gpLen = array_length(argument1.gpInputs);
    ds_map_set(global.input_map, argument0, argument1);
}

function scr_input_ini_read(argument0, argument1, argument2, argument3 = false, argument4 = false)
{
    var _inp, inputs, inputStrings, i;
    
    _inp = ini_read_string("Control", argument0, "");
    inputs = [];
    inputStrings = string_split(_inp, ",");
    
    if (_inp == "")
    {
        inputs = argument2;
    }
    else
    {
        for (i = 0; i < array_length(inputStrings); i++)
            array_push(inputs, real(inputStrings[i]));
    }
    
    show_debug_message(string("loaded input {0}: {1}", argument0, inputs));
    scr_input_add(argument0, new Input(argument0, argument1 ? [] : inputs, argument1 ? inputs : [], argument3, argument4));
}

function scr_setinput_init()
{
    ini_open("optionData.ini");
    global.deadzones[Deadzones.Master] = ini_read_real("Settings", "deadzoneMaster", 0.4);
    global.deadzones[Deadzones.Vertical] = ini_read_real("Settings", "deadzoneVertical", 0.5);
    global.deadzones[Deadzones.Horizontal] = ini_read_real("Settings", "deadzoneHorizontal", 0.5);
    global.deadzones[Deadzones.Press] = ini_read_real("Settings", "deadzonePress", 0.5);
    global.deadzones[Deadzones.SJump] = ini_read_real("Settings", "deadzoneSJump", 0.8);
    global.deadzones[Deadzones.Crouch] = ini_read_real("Settings", "deadzoneCrouch", 0.65);
    ini_close();
    scr_input_init_sprites();
}

function scr_gpinput_isaxis(argument0)
{
    var axes;
    
    axes = [gp_axisrh, gp_axisrv, gp_axislv, gp_axislh];
    
    if (array_contains(axes, argument0))
        return true;
    
    return false;
}

function scr_input_update(argument0 = -1)
{
    var dz, keys, i;
    
    dz = global.deadzones[Deadzones.Master];
    gamepad_set_axis_deadzone(argument0, dz);
    keys = ds_map_keys_to_array(global.input_map);
    
    for (i = 0; i < array_length(keys); i++)
        ds_map_find_value(global.input_map, array_get(keys, i)).update(object_index);
    
    scr_input_stickpressed_update();
}

function scr_input_stickpressed(argument0)
{
    var s;
    
    s = string(argument0);
    return ds_map_find_value(global.stickpressed, s) == StickPressed.Pressed;
}

function scr_input_stickpressed_update(argument0 = global.PlayerInputDevice, argument1 = global.deadzones[Deadzones.Master])
{
    var sticks, i, s, inv, val, pressState;
    
    sticks = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv];
    sticks = array_concat(sticks, sticks);
    
    for (i = 0; i < array_length(sticks); i++)
    {
        s = string(sticks[i]);
        inv = false;
        
        if (i >= ((array_length(sticks) / 2) - 1))
        {
            s += "_inv";
            inv = true;
        }
        
        val = gamepad_axis_value(argument0, sticks[i]);
        pressState = ds_map_find_value(global.stickpressed, s);
        
        if (pressState == StickPressed.Pressed && !((!inv && val >= argument1) || (inv && val <= -argument1)))
            ds_map_set(global.stickpressed, s, StickPressed.Released);
        
        if (pressState == StickPressed.JustPressed)
            ds_map_set(global.stickpressed, s, StickPressed.Pressed);
    }
}

function scr_checkdeadzone(argument0, argument1, argument2)
{
    var dz;
    
    dz = global.deadzones[Deadzones.Press];
    
    switch (argument0)
    {
        case gp_axislh:
        case gp_axisrh:
            dz = global.deadzones[Deadzones.Horizontal];
            break;
        
        case gp_axislv:
        case gp_axisrv:
            dz = global.deadzones[Deadzones.Vertical];
            break;
    }
    
    if (argument2.object_index == obj_parent_player)
    {
        switch (argument1)
        {
            case "upC":
                if (argument2.state == States.Sjumpprep)
                    dz = global.deadzones[Deadzones.SJump];
                
                break;
            
            case "downC":
                if (argument2.state == States.crouch)
                    dz = global.deadzones[Deadzones.Crouch];
                
                break;
        }
    }
    
    return dz;
}

function Input(argument0, argument1, argument2, argument3 = 0, argument4 = false) constructor
{
    static update = function(argument0)
    {
        if (global.PlayerInputDevice < 0)
        {
            checkheld(argument0);
            checkpressed(argument0);
            checkreleased(argument0);
        }
        else
        {
            checkheldC(argument0);
            checkpressedC(argument0);
            checkreleasedC(argument0);
        }
    };
    
    static checkheld = function(argument0)
    {
        var i;
        
        for (i = 0; i < keyLen; i++)
        {
            if (keyboard_check(keyInputs[i]))
            {
                held = true;
                exit;
            }
        }
        
        held = false;
    };
    
    static checkheldC = function(argument0)
    {
        var i, dz;
        
        for (i = 0; i < gpLen; i++)
        {
            if (scr_gpinput_isaxis(gpInputs[i]))
            {
                dz = scr_checkdeadzone(gpInputs[i], name, argument0);
                
                if ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz))
                {
                    held = true;
                    exit;
                }
            }
            else if (gamepad_button_check(global.PlayerInputDevice, gpInputs[i]))
            {
                held = true;
                exit;
            }
        }
        
        held = false;
    };
    
    static checkpressed = function(argument0)
    {
        var i;
        
        for (i = 0; i < keyLen; i++)
        {
            if (global.PlayerInputDevice != -1)
                break;
            
            if (keyboard_check_pressed(keyInputs[i]))
            {
                pressed = true;
                exit;
            }
        }
        
        pressed = false;
    };
    
    static checkpressedC = function(argument0)
    {
        var i, stickstr, dz;
        
        for (i = 0; i < gpLen; i++)
        {
            if (scr_gpinput_isaxis(gpInputs[i]))
            {
                stickstr = string(gpInputs[i]);
                
                if (gpAxisInvert)
                    stickstr += "_inv";
                
                dz = scr_checkdeadzone(gpInputs[i], name, argument0);
                
                if (!scr_input_stickpressed(stickstr) && ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz)))
                {
                    pressed = true;
                    ds_map_set(global.stickpressed, stickstr, StickPressed.JustPressed);
                    exit;
                }
            }
            else if (gamepad_button_check_pressed(global.PlayerInputDevice, gpInputs[i]))
            {
                pressed = true;
                exit;
            }
        }
        
        pressed = false;
    };
    
    static checkreleased = function(argument0)
    {
        var i;
        
        for (i = 0; i < keyLen; i++)
        {
            if (keyboard_check_released(keyInputs[i]))
            {
                released = true;
                exit;
            }
        }
        
        released = false;
    };
    
    static checkreleasedC = function(argument0)
    {
        var i, stickstr, dz;
        
        for (i = 0; i < gpLen; i++)
        {
            if (scr_gpinput_isaxis(gpInputs[i]))
            {
                stickstr = string(gpInputs[i]);
                
                if (gpAxisInvert)
                    stickstr += "_inv";
                
                dz = scr_checkdeadzone(gpInputs[i], name, argument0);
                
                if ((!gpAxisInvert && !scr_input_stickpressed(stickstr) && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= -dz))
                {
                    released = true;
                    exit;
                }
            }
            else if (gamepad_button_check_released(global.PlayerInputDevice, gpInputs[i]))
            {
                released = true;
                exit;
            }
        }
        
        released = false;
    };
    
    static clear_input = function()
    {
        held = false;
        pressed = false;
        released = false;
        return self;
    };
    
    name = argument0;
    held = false;
    pressed = false;
    released = false;
    keyInputs = argument1;
    gpInputs = argument2;
    gpInputDeadzone = argument3;
    gpAxisInvert = argument4;
    stickpressed = false;
    keyLen = 0;
    gpLen = 0;
}