function scr_setTransfoTip(argument0)
{
    switch (argument0)
    {
        case States.cotton:
        case States.cottondrill:
        case States.cottonroll:
        case States.cottondig:
            global.TransfoPrompt = string("{0}{1}[spr_promptfont] {2} {3}{4}{5}{6}{7}[spr_promptfont] {8}", get_control_sprite("jump"), get_control_sprite("jump"), lang_get("prompt_doublejump"), get_control_sprite("slap"), get_control_sprite("up"), get_control_sprite("down"), get_control_sprite("left"), get_control_sprite("right"), lang_get("prompt_dash"));
            break;
        
        case States.minecart:
        case States.minecart_bump:
        case States.minecart_launched:
            global.TransfoPrompt = string("{0}[spr_promptfont] {1} {2}[spr_promptfont] {3}", get_control_sprite("jump"), lang_get("prompt_jump"), get_control_sprite("down"), lang_get("prompt_crouch"));
            break;
        
        case States.fling:
            global.TransfoPrompt = string("{0}{1}{2}{3}[spr_promptfont] {4}", get_control_sprite("up"), get_control_sprite("down"), get_control_sprite("left"), get_control_sprite("right"), lang_get("prompt_pullback"));
            break;
        
        case States.fireass:
        case States.fireassdash:
            global.TransfoPrompt = string("{0}[spr_promptfont] {1}", get_control_sprite("slap"), lang_get("prompt_dash"));
            break;
        
        default:
            global.TransfoPrompt = "";
            break;
    }
    
    global.TransfoState = argument0;
    return global.TransfoPrompt;
}

function scr_transformationCheck(argument0)
{
    var transfo;
    
    transfo = undefined;
    
    if (argument0 == States.oldtaunt)
        argument0 = tauntStored.state;
    
    switch (argument0)
    {
        default:
            transfo = undefined;
            break;
        
        case States.tumble:
            transfo = "Ball";
            break;
        
        case States.cotton:
        case States.cottondrill:
        case States.cottonroll:
        case States.cottondig:
            transfo = "Werecotton";
            break;
        
        case States.fling:
        case States.fling_launch:
            transfo = "Fling";
            break;
        
        case States.minecart:
        case States.minecart_bump:
        case States.minecart_launched:
            transfo = "Minecart";
            break;
        
        case States.frostburnnormal:
        case States.frostburnjump:
        case States.frostburnslide:
        case States.frostburnstick:
            transfo = "Frostburn";
            break;
        
        case States.doughmount:
        case States.doughmountspin:
        case States.doughmountjump:
        case States.doughmountballoon:
            transfo = "Marshdog";
            break;
        
        case States.bottlerocket:
            transfo = "Rocket";
            break;
    }
    
    return transfo;
}

