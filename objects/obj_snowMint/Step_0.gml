if (point_in_circle(x, y, obj_parent_player.x + ((75 * obj_parent_player.xscale) + inhaleStrength), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != EnemyStates.inhaled)
    state = EnemyStates.inhaled;

enemyAttackTimer = max(enemyAttackTimer - 1, 0);

if (((obj_parent_player.x > (x - 400) && obj_parent_player.x < (x + 400)) && (y <= (obj_parent_player.y + 60) && y >= (obj_parent_player.y - 60))) && obj_parent_player.state != States.cotton && obj_parent_player.state != States.cottondrill && obj_parent_player.state != States.door && obj_parent_player.state != States.cottonroll)
{
    if (state != States.titlescreen && enemyAttackTimer <= 0 && obj_parent_player.state != States.cotton)
    {
        if (state == States.frozen || state == States.frozen)
        {
            image_index = 0;
            state = States.titlescreen;
            
            if (x != obj_parent_player.x)
                image_xscale = sign(obj_parent_player.x - x);
            
            sprite_index = spr_throw;
        }
    }
}

if (state != States.stun)
    depth = 0;

if (state != States.charge && state != States.freezeframe)
    thrown = 0;

event_inherited();
scr_scareenemy();

