event_inherited();
defaultMovespeed = 0;
canRoam = false;
baddieSpriteIdle = spr_badmarsh_sleep;
baddieSpriteStun = spr_badmarsh_stun;
baddieSpriteWalk = spr_badmarsh_walk;
baddieSpriteTurn = undefined;
baddieSpriteGrabbed = spr_badmarsh_stun;
baddieSpriteScared = spr_badmarsh_scared;
baddieSpriteDead = spr_badmarsh_dead;
lunged = 0;
tweaktoggle = false;

enemyAttack_TriggerEvent = function()
{
    if (scr_enemy_playerisnear(300, 50) && grounded && state == PlayerState.frozen)
    {
        if (enemyAttackTimer <= 0)
        {
            state = PlayerState.titlescreen;
            movespeed = 0;
            
            if (tweaktoggle == true)
                hsp = 0;
            
            var _player = get_nearestPlayer();
            
            if (sprite_index != spr_badmarsh_ragestart && sprite_index != spr_badmarsh_rage && sprite_index != spr_badmarsh_rageend)
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
    if (lunged <= 0 && sprite_index != spr_badmarsh_ragestart && sprite_index != spr_badmarsh_rageend && sprite_index != spr_badmarsh_rage)
    {
        sprite_index = spr_badmarsh_ragestart;
        movespeed = 0;
    }
    
    image_speed = 0.35;
    
    if (sprite_index == spr_badmarsh_ragestart && sprite_animation_end() && lunged <= 0)
    {
        sprite_index = spr_badmarsh_rage;
        hsp = image_xscale * 5;
        lunged = 50;
    }
    
    if (sprite_index == spr_badmarsh_rage)
    {
        hsp = approach(hsp, image_xscale * 8, 0.3);
        lunged--;
    }
    
    if (sprite_index == spr_badmarsh_rage && lunged <= 0 && (tweaktoggle == false || grounded))
    {
        hsp = image_xscale * 4;
        movespeed = 4;
        sprite_index = spr_badmarsh_rageend;
    }
    
    if (place_meeting_solid(x + image_xscale, y) && !place_meeting_slope(x, y + 1) && sprite_index == spr_badmarsh_rage)
    {
        lunged = 0;
        hsp = image_xscale * 4;
        movespeed = 4;
        sprite_index = spr_badmarsh_rageend;
    }
    
    if (sprite_index == spr_badmarsh_rageend)
        hsp = approach(hsp, 0, 0.1);
    
    if (sprite_index == spr_badmarsh_rageend && sprite_animation_end())
    {
        state = PlayerState.frozen;
        defaultMovespeed = 1;
        enemyAttackTimer = 200;
        tweaktoggle = true;
    }
};
