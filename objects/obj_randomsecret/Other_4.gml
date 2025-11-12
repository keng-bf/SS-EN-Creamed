if (room == rank_room)
    instance_destroy();

selected = false;
selected_level = -4;
minutes = 0;
seconds = 25;

if (room != secret_entrance)
    start = true;

alarm[0] = 60;
        with (obj_parent_player)
        {
            state = PlayerState.normal;
            sprite_index = spr_idle;
            movespeed = 0;
            hsp = 0;
        }