event_inherited();
baddieSpriteIdle = undefined;
baddieSpriteStun = spr_betonbacon_stun;
baddieSpriteWalk = spr_betonbacon;
baddieSpriteGrabbed = spr_betonbacon_stun;
baddieSpriteScared = spr_betonbacon_scared;
baddieSpriteTurn = undefined;
baddieSpriteDead = spr_betonbacon_dead;
baddieSpriteRage = spr_betonbacon_attack;
hurtboxID = -4;
ragereset = 0;
hitboxcreate = 0;
enemyAttackTimer = 300;

enemyAttack_TriggerEvent = function()
{
    if (scr_enemy_playerisnear(200, 50) && grounded && state == PlayerState.frozen)
    {
        if (enemyAttackTimer <= 0)
        {
            state = PlayerState.titlescreen;
            movespeed = 0;
            var _player = get_nearestPlayer();
            
            if (sprite_index != spr_betonbacon_attack)
                image_xscale = face_obj(_player);
            
            image_index = 0;
            enemyAttackTimer = 300;
            fmod_studio_event_instance_start(sndCharge);
        }
        else
        {
            enemyAttackTimer -= 1;
        }
    }
};

enemyState_Attack = function()
{
    sprite_index = spr_betonbacon_attack;
    
    if (sprite_index == spr_betonbacon_attack && sprite_animation_end())
    {
        state = PlayerState.frozen;
        sprite_index = spr_betonbacon;
        image_index = 0;
        
        if (instance_exists(hurtboxID))
            instance_destroy(hurtboxID);
    }
    
    image_speed = 0.35;
    hsp = 0;
};
