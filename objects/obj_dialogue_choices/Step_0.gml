var setChoice, _func;

if (obj_parent_player.key_jump)
{
    setChoice = global.dialogchoices[choice_selected];
    _func = setChoice[1];
    show_debug_message(string("Dialogue Choices Function: {0}", _func));
    
    if (_func != -4)
        _func();
    
    instance_destroy();
}
