var _st;

with (get_primaryPlayer())
{
    _st = state;
    
    if (state == States.actor && instance_exists(global.cutsceneManager) && variable_instance_exists(global.cutsceneManager, "storedState"))
        _st = global.cutsceneManager.storedState;
    
    if (scr_transformationCheck(_st) == "Werecotton")
        other.sprite_index = spr_cottonmakerzzz;
}

