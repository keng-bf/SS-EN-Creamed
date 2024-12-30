if (place_meeting(x + 4, y, obj_parent_player) && (obj_parent_player.state == States.doughmount || obj_parent_player.state == States.doughmountspin || obj_parent_player.state == States.doughmountballoon))
{
    instance_destroy();
    ds_list_add(global.SaveRoom, id);
}

