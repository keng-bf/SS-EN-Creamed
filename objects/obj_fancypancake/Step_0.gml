if (point_in_circle(x, y, obj_parent_player.x + (75 * obj_parent_player.xscale), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != EnemyStates.inhaled)
    state = EnemyStates.inhaled;

if (state != States.stun)
    depth = 0;

if (state != States.charge && state != States.freezeframe)
    thrown = 0;

event_inherited();

if (state != States.titlescreen)
    scr_scareenemy();

enemyAttackTimer = max(enemyAttackTimer - 1, 0);
ragereset = max(ragereset - 1, 0);

if (point_in_rectangle(obj_parent_player.x, obj_parent_player.y, x - 100, y - 50, x + 100, y + 50) && obj_parent_player.state != States.door && obj_parent_player.state != States.comingoutdoor)
{
    if (state != States.titlescreen && state == States.frozen && (obj_parent_player.state == States.doughmount || obj_parent_player.state == States.doughmountspin) && enemyAttackTimer <= 0)
    {
        image_index = 0;
        flash = true;
        create_heat_afterimage(AfterImageType.plain);
        state = States.titlescreen;
        sprite_index = spr_golfburger_golf;
        enemyAttackTimer = 200;
    }
}

if (sprite_index == spr_golfburger_golf || invisFrames > 0)
    baddieInvincibilityBuffer = 1;
else
    baddieInvincibilityBuffer = 0;

if (invisFrames > 0)
    invisFrames--;

