if (global.modver != global.newmodver)
{
    sound_play(sfx_pephurt);
    show_message_async("Your version is outdated!");
    game_restart();
}
else
{
    sound_play(sfx_pizzacoin);
    instance_activate_object(obj_virtual_controller);
    
    with (obj_virtual_controller)
        visible = true;
    
    global.__xkb_open = false;
    //instance_create(0, 0, obj_chat);
	room_goto_fixed(hub_demohallway)
}
