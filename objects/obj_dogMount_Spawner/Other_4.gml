if (obj_milkdunk.sprite_index != spr_milkgoal_filled)
{
    if (obj_parent_player.state != PlayerState.doughmountspin && obj_parent_player.state != PlayerState.doughmount && obj_parent_player.state != PlayerState.doughmountballoon && !instance_exists(obj_dogMount))
    {
        with (instance_create(x + (11 * image_xscale), y, obj_dogMount))
            image_xscale = other.image_xscale;
    }
}
