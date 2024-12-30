if (point_in_circle(x, y, obj_parent_player.x + (75 * obj_parent_player.xscale), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != EnemyStates.inhaled)
    state = EnemyStates.inhaled;

if (state != States.stun)
    depth = 0;

if (state != States.charge && state != States.freezeframe)
    thrown = 0;

enemyAttackTimer = max(enemyAttackTimer - 1, 0);

if (((obj_parent_player.x > (x - 50) && obj_parent_player.x < (x + 50)) && (y <= (obj_parent_player.y + 300) && y >= (obj_parent_player.y - 300))) && obj_parent_player.state != States.cotton && obj_parent_player.state != States.cottondrill && obj_parent_player.state != States.door && obj_parent_player.state != States.cottonroll)
{
    if (state != States.titlescreen && enemyAttackTimer <= 0 && obj_parent_player.state != States.cotton)
    {
        if (state == EnemyStates.float)
        {
            image_index = 0;
            state = States.titlescreen;
            
            if (x != obj_parent_player.x)
                image_xscale = sign(obj_parent_player.x - x);
            
            sprite_index = spr_throw;
        }
    }
}

if (state == States.charge)
    grav = 0.5;
else
    grav = 0;

if (state == States.frozen)
    state = EnemyStates.float;

event_inherited();

if (state != States.titlescreen)
    scr_scareenemy();

