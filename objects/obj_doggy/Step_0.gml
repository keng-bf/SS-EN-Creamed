if (flash && alarm[2] <= 0)
{
}

if (state != States.stun)
    depth = 0;

if (state != States.charge && state != States.freezeframe)
    thrown = 0;

event_inherited();

if (state != States.titlescreen && state != States.frozen)
    scr_scareenemy();

enemyAttackTimer = max(enemyAttackTimer - 1, 0);
ragereset = max(ragereset - 1, 0);

if (state == States.frozen)
    enemyAttackTimer = 0;

if (point_in_rectangle(obj_parent_player.x, obj_parent_player.y, x - 300, y - 50, x + 300, y + 50) && obj_parent_player.state != States.door && obj_parent_player.state != States.comingoutdoor)
{
    if ((state == States.frozen || state == States.frozen) && enemyAttackTimer <= 0)
    {
        image_index = 0;
        flash = true;
        fmod_studio_event_instance_start(sndCharge);
        create_heat_afterimage(AfterImageType.plain);
        state = States.titlescreen;
        
        if (x != obj_parent_player.x)
            image_xscale = sign(obj_parent_player.x - x);
        
        sprite_index = spr_badmarsh_ragestart;
    }
}

