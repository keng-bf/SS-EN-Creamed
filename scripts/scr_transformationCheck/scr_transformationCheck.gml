function scr_setTransfoTip(argument0)
{
    switch (argument0)
    {
        case States.cotton:
        case States.cottondrill:
        case States.cottonroll:
        case States.cottondig:
            global.TransfoPrompt = "prompt_werecotton";
            break;
        
        case States.minecart:
        case States.minecart_bump:
        case States.minecart_launched:
            global.TransfoPrompt = "prompt_minecart";
            break;
        
        case States.fling:
            global.TransfoPrompt = "prompt_fling";
            break;
        
        case States.fireass:
        case States.fireassdash:
            global.TransfoPrompt = "prompt_fireass";
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