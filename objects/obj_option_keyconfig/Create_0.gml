scr_input_varinit();

if (instance_number(object_index) > 1)
    instance_destroy();

selected = -2;
reading = false;
gamepad = false;
depth = -500;

function inputDisplay(argument0, argument1) constructor
{
    static draw = function(argument0, argument1, argument2)
    {
        var i;
        
        inputText.blend(argument2, 1);
        inputText.draw(argument0, argument1);
        
        for (i = 0; i < array_length(keyname_arr); i++)
            keyname_arr[i].draw(argument0, argument1);
    };
    
    static update = function()
    {
        var txt, iconLen, i, ii, yy, xx, keyName, keytext, lh;
        
        parentInput = input_get(name);
        currentInputs = isGP ? parentInput.gpInputs : parentInput.keyInputs;
        inputIcons = scr_input_get_icon(name, true);
        lineCount = floor((array_length(inputIcons) - 1) / 3) + 1;
        txt = "";
        keyname_arr = [];
        iconLen = array_length(inputIcons);
        
        for (i = 0; i < iconLen; i++)
        {
            txt += string("[{0},{1}]", sprite_get_name(inputIcons[i][0]), inputIcons[i][1]);
            ii = i + 1;
            
            if ((ii % 3) == 0)
                txt += "\n";
            
            if (inputIcons[i][0] == spr_key_empty)
            {
                yy = floor(i / 3) * 32;
                xx = 32;
                
                if (iconLen >= (ii + 1) && (ii % 3) != 0)
                {
                    if ((ii % 3) == 1 && iconLen >= (ii + 2))
                        xx += 32;
                    
                    xx += 32;
                }
                
                keyName = string_copy(scr_keyname(inputIcons[i][2]), 1, 3);
                keytext = scribble(keyName).align(1, 1).origin(xx - 16, -yy).starting_format(font_get_name(global.keyDrawFont), 0);
                array_push(keyname_arr, keytext);
            }
        }
        
        lh = isGP ? 48 : 32;
        inputText = scribble(txt).align(2, 0).origin(0, 16).line_height(lh, lh);
        return self;
    };
    
    displayname = argument0;
    name = argument0;
    iconIndex = argument1;
    lineCount = 1;
    isGP = false;
    inputText = "";
    parentInput = input_get(argument0);
    currentInputs = [];
    inputIcons = [];
    keyname_arr = [];
    return update();
}

inputs = [new inputDisplay("up", 0), new inputDisplay("down", 1), new inputDisplay("left", 2), new inputDisplay("right", 3), new inputDisplay("jump", 4), new inputDisplay("slap", 5), new inputDisplay("taunt", 6), new inputDisplay("attack", 7), new inputDisplay("superjump", 8), new inputDisplay("groundpound", 9), new inputDisplay("start", 10)];
scroll_y = 0;
scroll_pos = 0;
scroll_pad = 64;
