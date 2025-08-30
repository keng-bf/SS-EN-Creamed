if (point_in_circle(x, y, obj_parent_player.x + (75 * obj_parent_player.xscale), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != EnemyStates.inhaled)
	state = EnemyStates.inhaled

if (state != PlayerState.stun)
	depth = 0

if (state != PlayerState.charge && state != PlayerState.freezeframe)
	thrown = 0

event_inherited()

if (state != PlayerState.titlescreen)
	scr_scareenemy()

enemyAttackTimer = max(enemyAttackTimer - 1, 0)

if ((place_meeting(x + 1, y, obj_parent_player) && image_xscale == 1) || (place_meeting(x - 1, y, obj_parent_player) && image_xscale == -1))
{
	if (state != PlayerState.titlescreen && state == PlayerState.frozen && (obj_parent_player.state == PlayerState.doughmount || obj_parent_player.state == PlayerState.doughmountspin) && enemyAttackTimer <= 0)
	{
		image_index = 0
		create_heat_afterimage(AfterImageType.plain)
		state = PlayerState.titlescreen
		sprite_index = spr_golfburger_golf
	}
}

baddieInvincibilityBuffer = (sprite_index == spr_golfburger_golf || invisFrames > 0) ? 1 : 0

if (invisFrames > 0)
	invisFrames--

if (hitboxcreate == 0 && sprite_index == spr_golfburger_golf)
{
    hitboxcreate = 1;
    
    with (instance_create(x, y, obj_crackerkicker_kickhitbox, 
    {
        ID: other.id
    }))
    {
        ID = other.id;
        image_xscale = other.image_xscale;
        image_index = other.image_index;
        depth = -1;
    }
}

if (state == PlayerState.titlescreen && obj_parent_player.state != PlayerState.doughmount && obj_parent_player.state != PlayerState.doughmountspin && !place_meeting(x + (5 * image_xscale), y, obj_parent_player))
    state = PlayerState.frozen;
