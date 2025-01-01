function directory_get_files(argument0, argument1)
{
    var fileArr, file;
    
    fileArr = [];
    file = file_find_first(string("{0}*{1}", argument0, argument1), 0);
    
    while (file != "")
    {
        array_push(fileArr, file);
        file = file_find_next();
    }
    
    file_find_close();
    return fileArr;
}

function scr_lang_make_struct(argument0)
{
    var filePath, b, text, json, i, l, c, res;
    
    filePath = string_concat(working_directory, "lang/", argument0);
    b = buffer_load(filePath);
    text = string_split(buffer_read(b, buffer_text), "\n", true);
    buffer_delete(b);
    json = "{\n";
    
    for (i = 0; i < array_length(text); i++)
    {
        l = text[i];
        
        for (c = 1; string_char_at(l, c) == "\t"; c++)
        {
        }
        
        if (string_char_at(l, c) != "#")
        {
            if (string_pos(":", l) != 0)
                l = string_replace(l, "\r", ",\n");
            
            json += l;
        }
    }
    
    json += "\n}";
    res = undefined;
    
    try
    {
        res = json_parse(json);
    }
    catch (_exception)
    {
        trace("Failed to parse lang json!");
        global.langError = "Could not parse lang file!";
        res = undefined;
    }
    
    if (variable_struct_exists(res, "langFolder"))
        res.langDictionary = scr_lang_get_dictionary(res.langFolder);
    else
        res.langDicitonary = {};
    
    return res;
}

function scr_lang_get_dictionary(argument0)
{
    var filePath, b, json;
    
    filePath = string_concat(working_directory, "lang/", argument0, "/", "Dictionary.json");
    
    if (!file_exists(filePath))
        return {};
    
    b = buffer_load(filePath);
    
    try
    {
        json = buffer_read(b, buffer_text);
        return json_parse(json);
    }
    catch (_ex)
    {
        global.langError = string("Unable to load sprite dictionary lang/{0}/Dictionary.json", argument0);
        return {};
    }
}

function scr_lang_dictionary_fonts_add(argument0, argument1)
{
    var fontDict, basePath, path, init, font_struct_default, font_struct, i, st, nm, map, _spr, sep, f, n, prop, pv, xo, xv, yo, yv, s, font, font_arr, fname, lang_font, default_font;
    
    trace("Creating lang font dictionary");
    fontDict = [];
    
    if (struct_exists(argument1, "Fonts"))
        fontDict = argument1.Fonts;
    
    if (array_length(fontDict) < 1)
    {
        trace("Could not find any defined fonts for current language");
        exit;
    }
    
    basePath = string("{0}lang/", working_directory);
    path = string_concat(basePath, argument0, "/Fonts");
    init = false;
    
    if (!instance_exists(obj_langSpriteLoader))
        instance_create(0, 0, obj_langSpriteLoader);
    
    if (is_undefined(ds_map_find_value(global.langFonts, global.langName)))
    {
        ds_map_set(global.langFonts, global.langName, {});
        init = true;
    }
    
    font_struct_default = ds_map_find_value(global.langFonts, "_DEFAULT_FONTS");
    font_struct = ds_map_find_value(global.langFonts, global.langName);
    
    if (init)
    {
        for (i = 0; i < array_length(fontDict); i++)
        {
            try
            {
                st = fontDict[i];
                
                if (!(is_struct(st) && struct_exists(st, "name") && struct_exists(st, "sprite") && struct_exists(st, "map") && struct_exists(st, "separation")))
                    continue;
                
                nm = struct_get(st, "name");
                map = struct_get(st, "map");
                _spr = struct_get(st, "sprite");
                sep = struct_get(st, "separation");
                f = string("{0}/{1}.png", path, _spr);
                
                if (!struct_exists(font_struct_default, nm) || _spr == "default")
                    continue;
                
                if (!file_exists(f))
                {
                    trace(string("Unable to find lang font {0}", f));
                    global.langError = string("Unable to find lang font {0}", f);
                    continue;
                }
                
                trace(string("Creating lang font {0}", f));
                n = string_length(map);
                prop = true;
                
                if (variable_struct_exists(st, "nonprop"))
                {
                    pv = variable_struct_get(st, "nonprop");
                    pv = string_lower(string(pv));
                    
                    if (pv == "t" || pv == "true" || pv == 1)
                        prop = false;
                }
                
                xo = 0;
                
                if (variable_struct_exists(st, "xoff"))
                {
                    xv = variable_struct_get(st, "xoff");
                    
                    if (is_real(xv))
                        xo = xv;
                }
                
                yo = 0;
                
                if (variable_struct_exists(st, "yoff"))
                {
                    yv = variable_struct_get(st, "yoff");
                    
                    if (is_real(yv))
                        yo = yv;
                }
                
                s = sprite_add(f, n, false, false, xo, yo);
                font = __scribble_font_add_sprite_ext(s, map, prop, sep);
                variable_struct_set(font_struct, nm, font);
            }
            catch (ex)
            {
                global.langError = string("Failed to implement font from {0}", global.langName);
                continue;
            }
        }
    }
    
    font_arr = struct_get_names(font_struct_default);
    
    for (i = 0; i < array_length(font_arr); i++)
    {
        fname = font_arr[i];
        lang_font = struct_get(font_struct, fname);
        default_font = struct_get(font_struct_default, fname);
        
        if (!variable_global_exists(fname))
            continue;
        
        if (is_undefined(lang_font))
            variable_global_set(fname, default_font);
        else
            variable_global_set(fname, lang_font);
    }
}

function scr_lang_fonts_init()
{
    var st, fnt_arr, i;
    
    st = {};
    fnt_arr = [["font", global.font], ["smallfont", global.smallfont], ["creditsfont", global.creditsfont], ["collectfont", global.collectfont], ["candlefont", global.candlefont], ["rankcombofont", global.rankcombofont], ["bubblefont", global.bubblefont], ["timerfont", global.timerfont], ["combofont", global.combofont], ["lapfont", global.lapfont], ["dialogfont", global.dialogfont], ["buttonfont", global.buttonfont], ["promptfont", global.promptfont], ["npcfont", global.npcfont], ["npcsmallfont", global.npcsmallfont], ["keyDrawFont", global.keyDrawFont]];
    
    for (i = 0; i < array_length(fnt_arr); i++)
        variable_struct_set(st, fnt_arr[i][0], fnt_arr[i][1]);
    
    ds_map_set(global.langFonts, "_DEFAULT_FONTS", st);
}

function scr_lang_dictionary_keys_add(argument0, argument1)
{
    var keyDict, define_keys, basePath, path, init, arr, i, st, nm, map, f, n, s, infoArr, keyName, keySprite, keyMap, j, k;
    
    trace("Creating lang specific key sprites");
    keyDict = [];
    
    if (struct_exists(argument1, "Keys"))
        keyDict = argument1.Keys;
    
    if (array_length(keyDict) < 1)
    {
        trace("Could not find any defined keys for current language");
        exit;
    }
    
    define_keys = false;
    basePath = string("{0}lang/", working_directory);
    path = string_concat(basePath, argument0, "/Keys");
    init = false;
    
    if (!instance_exists(obj_langSpriteLoader))
        instance_create(0, 0, obj_langSpriteLoader);
    
    if (is_undefined(ds_map_find_value(global.langKeySprites, global.langName)))
    {
        ds_map_set(global.langKeySprites, global.langName, []);
        init = true;
    }
    
    arr = ds_map_find_value(global.langKeySprites, global.langName);
    
    if (init)
    {
        for (i = 0; i < array_length(keyDict); i++)
        {
            st = keyDict[i];
            
            if (!(is_struct(st) && struct_exists(st, "name") && struct_exists(st, "map")))
                continue;
            
            nm = struct_get(st, "name");
            map = struct_get(st, "map");
            f = string("{0}/{1}.png", path, nm);
            
            if (!file_exists(f))
            {
                trace(string("Unable to find lang key {0}", f));
                global.langError = string("Unable to find lang key {0}", f);
            }
            else
            {
                trace(string("Creating keysprite {0}", f));
                n = string_length(map);
                s = sprite_add(f, n, false, false, 16, 16);
                array_push(arr, [nm, s, map]);
            }
        }
    }
    
    for (i = 0; i < array_length(arr); i++)
    {
        infoArr = arr[i];
        keyName = infoArr[0];
        keySprite = infoArr[1];
        keyMap = infoArr[2];
        
        for (j = 0; j < string_length(keyMap); j++)
        {
            k = string_upper(string_char_at(keyMap, j + 1));
            scr_input_icon_add([ord(k)], keySprite, j);
        }
    }
}

function scr_lang_dictionary_sprites_add(argument0, argument1)
{
    var spriteArr, spriteDict, basePath, ld, i, s, p, spr;
    
    trace("Creating sprite dictionary");
    scr_lang_dictionary_sprites_clear();
    spriteArr = [];
    spriteDict = undefined;
    
    if (struct_exists(argument1, "Sprites"))
    {
        spriteDict = argument1.Sprites[0];
        spriteArr = struct_get_names(spriteDict);
    }
    
    if (is_undefined(spriteDict))
        exit;
    
    basePath = string("{0}lang/", working_directory);
    
    if (!instance_exists(obj_langSpriteLoader))
        ld = instance_create(0, 0, obj_langSpriteLoader);
    
    for (i = 0; i < array_length(spriteArr); i++)
    {
        s = spriteArr[i];
        p = struct_get(spriteDict, s);
        
        if (string_lower(p) == "default")
            continue;
        
        spr = scr_lang_sprite_add(s, p, string_concat(basePath, argument0, "/Sprites"));
        
        if (spr != "default")
            ds_map_set(global.langSpritesAsync, spr, s);
    }
}

function scr_lang_sprite_add(argument0, argument1, argument2)
{
    var f, s, n, _xo, _yo;
    
    f = string("{0}/{1}.png", argument2, argument1);
    s = asset_get_index(argument0);
    
    if (!file_exists(f) || !sprite_exists(s))
    {
        trace(string("Unable to find lang sprite {0}", f));
        global.langError = string("Unable to find lang sprite {0}", f);
        return "default";
    }
    
    trace(string("Creating sprite {0} for {1}", f, argument0));
    n = sprite_get_number(s);
    _xo = sprite_get_xoffset(s);
    _yo = sprite_get_yoffset(s);
    return sprite_add_ext(f, n, _xo, _yo, true);
}

function scr_lang_dictionary_sprites_clear()
{
    var keys, i, key, s;
    
    keys = ds_map_keys_to_array(global.langSprites);
    
    for (i = 0; i < array_length(keys); i++)
    {
        key = keys[i];
        s = ds_map_find_value(global.langSprites, key);
        lang_sprite_check_persistence(key, key);
        array_push(global.langSpritesTemp, s);
        ds_map_delete(global.langSprites, key);
    }
    
    trace("Cleared lang sprite dictionary");
}

function scr_lang_set_file(argument0)
{
    var prev_lang_struct;
    
    prev_lang_struct = global.langStruct;
    global.langStruct = scr_lang_make_struct(argument0);
    
    if (is_undefined(global.langStruct))
        global.langStruct = prev_lang_struct;
    
    global.langName = string_copy(argument0, 1, string_length(argument0) - 4);
    scr_lang_dictionary_sprites_add(global.langStruct.langFolder, global.langStruct.langDictionary);
    scr_lang_dictionary_fonts_add(global.langStruct.langFolder, global.langStruct.langDictionary);
    scr_lang_dictionary_keys_add(global.langStruct.langFolder, global.langStruct.langDictionary);
    scr_initKeyNameMap();
    trace(string("Loaded new lang file ({0})", argument0));
    return true;
}

function scr_lang_reload()
{
    scr_lang_dictionary_sprites_clear();
    scr_lang_init();
}

function scr_lang_init()
{
    var _dir;
    
    global.langStruct = {};
    global.langFiles = [];
    global.langError = "";
    
    if (!variable_global_exists("langSpritesAsync"))
        global.langSpritesAsync = ds_map_create();
    
    if (!variable_global_exists("langSprites"))
        global.langSprites = ds_map_create();
    
    if (!variable_global_exists("langFonts"))
    {
        global.langFonts = ds_map_create();
        scr_lang_fonts_init();
    }
    
    if (!variable_global_exists("langKeySprites"))
        global.langKeySprites = ds_map_create();
    
    if (!variable_global_exists("langSpritesTemp"))
        global.langSpritesTemp = [];
    
    global.langDefault = scr_lang_make_struct("EN.txt");
    
    if (is_undefined(global.langDefault))
        global.langDefault = {};
    
    scr_lang_initvals();
    ini_open("optionData.ini");
    global.langName = ini_read_string("Settings", "lang", "EN");
    ini_close();
    _dir = string_concat(working_directory, "lang/");
    global.langFiles = directory_get_files(_dir, ".txt");
    trace("Found Lang Files: ", json_stringify(global.langFiles, true));
    
    if (array_contains(global.langFiles, string("{0}.txt", global.langName)))
        scr_lang_set_file(string("{0}.txt", global.langName));
    else if (array_length(global.langFiles) > 0)
        scr_lang_set_file(global.langFiles[0]);
    else
        global.langError = "Could not find any files in lang folder!";
    
    trace("Initiated language: ", lang_get("language"));
}

function lang_key_exists(argument0)
{
    if (is_undefined(global.langDefault) || !variable_struct_exists(global.langDefault, argument0))
        return false;
    
    return true;
}

function lang_get(argument0, argument1 = undefined)
{
    var content, i, c, s, digit;
    
    content = "";
    
    if (is_undefined(global.langStruct) || !variable_struct_exists(global.langStruct, argument0))
    {
        if (!is_undefined(global.langDefault) && variable_struct_exists(global.langDefault, argument0))
        {
            content = variable_struct_get(global.langDefault, argument0);
            
            if (string_length(global.langError) < 1)
                global.langError = string("Could not find value \"{0}\" for lang {1}!", argument0, global.langName);
        }
        else if (string_length(global.langError) < 1)
        {
            global.langError = string("No such lang key exists \"{0}\"!", argument0);
        }
    }
    else
    {
        content = variable_struct_get(global.langStruct, argument0);
    }
    
    if (!is_undefined(argument1))
    {
        for (i = 0; i < array_length(argument1); i++)
        {
            c = 1;
            s = string(argument1[i]);
            
            while (c <= string_length(content))
            {
                if (string_char_at(content, c) == "/")
                {
                    digit = string_digits(string_copy(content, c + 1, 1));
                    
                    if (real(digit) == (i + 1))
                    {
                        content = string_delete(content, c, 2);
                        content = string_insert(s, content, c);
                    }
                    else
                    {
                        c++;
                    }
                }
                else
                {
                    c++;
                }
            }
        }
    }
    
    return content;
}

function lang_group_replace(argument0, argument1 = ["{", "}"], argument2 = global.lang_values)
{
    var result, len, captured, buffer, delimOpen, len_open, delimClose, len_close, i;
    
    result = "";
    len = string_length(argument0);
    captured = false;
    buffer = "";
    delimOpen = argument1[0];
    len_open = string_length(delimOpen);
    delimClose = argument1[1];
    len_close = string_length(delimClose);
    
    for (i = 1; i <= len; i++)
    {
        if (!captured && string_copy(argument0, i, len_open) == delimOpen)
        {
            captured = true;
            i += (len_open - 1);
        }
        else if (captured && string_copy(argument0, i, len_close) == delimClose)
        {
            captured = false;
            
            if (ds_map_exists(argument2, buffer))
                result += ds_map_find_value(argument2, buffer);
            else
                result += (delimOpen + buffer + delimClose);
            
            buffer = "";
            i += (len_close - 1);
        }
        else if (captured)
        {
            buffer += string_char_at(argument0, i);
        }
        else
        {
            result += string_char_at(argument0, i);
        }
    }
    
    return result;
}

function lang_transform_string(argument0)
{
    var result;
    
    result = lang_group_replace(argument0, ["{", "}"], global.lang_values);
    return result;
}

function lang_get_sprite(argument0)
{
    var s;
    
    if (!variable_struct_exists(global.langStruct, "langDictionary"))
    {
        trace("Requested sprite from a language with no dictionary!");
        return argument0;
    }
    
    s = ds_map_find_value(global.langSprites, argument0);
    
    if (!is_undefined(s))
        return s;
    
    return argument0;
}

function lang_sprite_check_persistence(argument0, argument1)
{
    switch (argument0)
    {
        case spr_newpause_border:
            with (obj_pause)
                pauseBorder = argument1;
            
            break;
    }
}

function scr_lang_initvals()
{
    var initArr, i, pair;
    
    if (!variable_global_exists("lang_values"))
        global.lang_values = ds_map_create();
    
    initArr = [["s", "[shake]"], ["u", "[wave]"]];
    
    for (i = 0; i < array_length(initArr); i++)
    {
        pair = initArr[i];
        ds_map_set(global.lang_values, array_get(pair, 0), pair[1]);
    }
}

function font_get_sprite(argument0, argument1 = false)
{
    var res;
    
    res = font_get_info(argument0).spriteIndex;
    
    if (res != -1 && argument1)
        return sprite_get_name(res);
    
    return res;
}
