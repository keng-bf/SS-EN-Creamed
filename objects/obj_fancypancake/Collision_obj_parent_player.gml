if (instance_exists(obj_fancypancake))
{
    if (!global.freezeframe || obj_parent_player.state == PlayerState.doughmountspin)
    {
        var _player = obj_parent_player;
        
        if (place_meeting(x + (5 * image_xscale), y - 1, _player) && _player.grounded && !_player.cutscene && _player.state == PlayerState.doughmount && _player.state != PlayerState.frozen && obj_fancypancake.sprite_index == spr_golfburger_golf && floor(obj_fancypancake.image_index) == 3 && obj_fancypancake.state == PlayerState.titlescreen)
        {
            if (obj_parent_player.state == PlayerState.doughmount || obj_parent_player.state == PlayerState.doughmountspin)
            {
                with (instance_create(x, y, obj_dogMount))
                {
                    image_xscale = obj_parent_player.xscale;
                    sprite_index = spr_dogMount_kick;
                    vsp = -16;
                    hsp = -image_xscale * 16;
                }
            }
            
            with (_player)
            {
                if (player_complete_invulnerability())
                    exit;
                
                image_index = 0;
                image_speed = 0.35;
                sprite_index = spr_player_PZ_slipSlide_intro;
                state = PlayerState.puddle;
                vsp = -7.5;
                movespeed = image_xscale * 12;
                grounded = 0;
                event_play_oneshot("event:/SFX/player/slip", x, y);
                slipped = 1;
                alarm[0] = 60;
            }
        }
    }
}
