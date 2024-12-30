var i, input, inp, p, optional, in, inpArr, gpinput;

scr_getinput();

if (selected == -2)
{
    if (gamepad)
    {
        for (i = 0; i < array_length(inputs); i++)
        {
            input = inputs[i];
            input.name = string_concat(input.name, "C");
            input.isGP = true;
            input.update();
        }
    }
    
    selected = -1;
    reading = false;
}
else if (!reading)
{
    if (key_up2 && selected > 0)
    {
        selected--;
        event_play_oneshot("event:/SFX/ui/step");
    }
    
    if (key_down2 && selected < (array_length(inputs) - 1) && selected > -1)
    {
        selected++;
        event_play_oneshot("event:/SFX/ui/step");
    }
    
    if (selected == -1 && (key_right2 || key_down2))
        selected = 0;
    else if (-key_left2)
        selected = -1;
    
    if (key_jump && selected >= 0)
    {
        if (array_length(inputs[selected].currentInputs) < 9)
            reading = true;
    }
    
    if (!reading && ((key_jump && selected == -1) || key_slap2 || key_start2))
    {
        with (obj_option_keyconfig)
            instance_destroy();
        
        event_play_oneshot("event:/SFX/ui/confirm");
        exit;
    }
    
    if (key_taunt2)
    {
        if (selected != -1)
        {
            inp = inputs[selected].parentInput;
            
            if (gamepad)
                inp.gpInputs = [];
            else
                inp.keyInputs = [];
            
            input_save(inp);
        }
        
        inputs[selected].update();
    }
    
    if (keyboard_check_pressed(vk_f1))
    {
        scr_resetinput();
        
        for (i = 0; i < array_length(inputs); i++)
            inputs[i].update();
    }
    
    for (i = 0; i < array_length(inputs); i++)
    {
        p = inputs[i].name;
        optional = ["superjump", "superjumpC", "groundpound", "groundpoundC"];
        
        if (!array_contains(optional, p))
        {
            in = input_get(p);
            
            if ((!gamepad && array_length(in.keyInputs) < 1) || (gamepad && array_length(in.gpInputs) < 1))
                reading = true;
        }
    }
}
else
{
    inp = inputs[selected].parentInput;
    inpArr = [];
    
    if (!gamepad)
    {
        if (keyboard_check_pressed(vk_anykey) && keyboard_key != vk_f1)
        {
            inpArr = inp.keyInputs;
            
            if (!array_contains(inpArr, keyboard_key))
            {
                array_push(inpArr, keyboard_key);
                inp.keyInputs = inpArr;
                reading = false;
                input_save(inp);
            }
            else if (array_length(inpArr) > 0)
            {
                reading = false;
                input_save(inp);
            }
            
            inputs[selected].update();
        }
    }
    else
    {
        if (keyboard_check_pressed(vk_anykey))
        {
            reading = false;
            exit;
        }
        
        gpinput = scr_checkanygamepad(global.PlayerInputDevice);
        
        if (gpinput == -4)
            gpinput = scr_check_joysticks(global.PlayerInputDevice);
        
        if (gpinput != -4)
        {
            inpArr = inp.gpInputs;
            
            if (!array_contains(inpArr, gpinput))
            {
                array_push(inpArr, gpinput);
                inp.gpInputs = inpArr;
                reading = false;
                input_save(inp);
            }
            else if (array_length(inpArr) > 0)
            {
                reading = false;
                input_save(inp);
            }
            
            inputs[selected].update();
        }
    }
}
