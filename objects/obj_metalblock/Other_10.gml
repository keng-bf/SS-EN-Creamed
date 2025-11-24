if (DestroyedBy.object_index == obj_parent_player || DestroyedBy.object_index == obj_player1)
{
	with (DestroyedBy)
	{
		if (state == PlayerState.freefall || state == PlayerState.freefallland)
		{
			event_play_oneshot(sfx_groundpound, x, y)
			image_index = 0
			state = PlayerState.freefallland
			jumpAnim = true
			jumpStop = false
			
			with (obj_parent_enemy)
			{
				if (bbox_in_camera(id, view_camera[0]) && grounded)
				{
					vsp = -7
					hsp = 0
				}
			}
			
			camera_shake_add(10, 30)
			combo = 0
			bounce = 0
			instance_create(x, y, obj_landcloud)
			freefallstart = 0
			image_index = 0
            var landing_sprite_transitions = 
			[
				[spr_groundPoundfall, spr_groundPoundland], 
				[spr_groundPoundstart, spr_groundPoundland], 
				[spr_diveBombfall, spr_diveBombland], 
				[spr_diveBombstart, spr_diveBombland], 
				[spr_player_N_crusherFall, spr_player_N_crusherLand], 
				[spr_player_N_crusherIntro, spr_player_N_crusherLand]
			];
            
            for (var i = 0; i < array_length(landing_sprite_transitions); i++)
            {
                if (sprite_index == landing_sprite_transitions[i][0])
                    sprite_index = landing_sprite_transitions[i][1];
            }
			
			hsp = 0
			vsp = 0
		}
		else if (state == PlayerState.superslam)
		{
			sprite_index = spr_piledriverland
			event_play_oneshot(sfx_groundpound, x, y)
			jumpAnim = true
			jumpStop = false
			image_index = 0
			camera_shake_add(20, 40)
			hsp = 0
			vsp = 0
			bounce = 0
			create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_bangEffect, xscale, 1)
			freefallstart = 0
			
			with (obj_parent_enemy)
			{
				if (bbox_in_camera(id, view_camera[0]) && grounded)
				{
					image_index = 0
					vsp = -7
					hsp = 0
				}
			}
			
			with (baddieGrabbedID)
			{
				x = other.x
				y = other.y
				scr_instakillEnemy(id, other.id)
			}
			
			baddieGrabbedID = -4
		}
		else if (state == PlayerState.mach3 && sprite_index != spr_mach3hit)
		{
			sprite_index = spr_mach3hit
			image_index = 0
		}
		else if (state == PlayerState.machroll)
		{
			mach3Roll = mach3RollMax
			flash = false
			
			if (grounded)
			{
				sprite_index = spr_machroll3intro
				image_index = 0
			}
		}
	}
}

instance_destroy()
