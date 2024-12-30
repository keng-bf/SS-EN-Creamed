with (playerID)
{
    scr_taunt_setVariables();
    move = key_right + key_left;
    
    if (move != 0)
        xscale = sign(move);
}

ini_open(global.SaveFileName);
ini_write_string("Treasure", "mindpalace", "1");
ini_close();
obj_hudManager.saveAlpha = 10;
instance_destroy();
