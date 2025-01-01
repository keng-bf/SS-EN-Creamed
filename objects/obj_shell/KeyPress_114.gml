if (global.DebugMode == DebugType.None)
    exit;

if (obj_parent_player.state != States.noclip)
    obj_parent_player.state = States.noclip;
else
    obj_parent_player.state = States.normal;