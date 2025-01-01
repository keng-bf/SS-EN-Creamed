var secretActivated, level_array, i, j, check, prompt;

with (playerID)
{
    scr_taunt_setVariables();
    move = key_right + key_left;
    
    if (move != 0)
        xscale = sign(move);
}

ini_open(global.SaveFileName);
secretActivated = true;
level_array = ["entryway", "steamy", "mineshaft", "molasses"];

for (i = 0; i < array_length(level_array); i++)
{
    for (j = 0; j < 3; j++)
    {
        check = ini_read_real("Secret", level_array[i] + string(j + 1), 0) ? true : false;
        
        if (!check)
        {
            secretActivated = false;
            break;
        }
    }
}

if (ini_read_string("Game", "Judgment", "none") == "none")
    secretActivated = false;

ini_write_string("Treasure", "mindpalace", "1");

if (secretActivated)
    ini_write_real("Game", "mixtape_prompt", true);

ini_close();
obj_hudManager.saveAlpha = 10;
prompt = secretActivated ? lang_get("prompt_mixtape_soundtest") : lang_get("prompt_mixtape_nosoundtest", [scr_getDialogIcon("INK", "c_white", "c_white")]);
scr_queueToolTipPrompt(prompt);
instance_destroy();
