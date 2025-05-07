if (!scr_player_check_normal(other))
	exit

if !in_saveroom()
{
	with (other)
	{
		if (state != PlayerState.gotkey && sprite_index != spr_player_PZ_gotKey && sprite_index != spr_player_PZ_pileDriver_jump)
		{
			global.ComboTime = 60
			event_play_oneshot("event:/SFX/general/collectKey")
			image_index = 0
			
			if (grounded)
			{
				hsp = 0
				vsp = 0
				sprite_index = spr_player_PZ_gotKey
			}
			else
			{
				image_index = 0
				sprite_index = spr_player_PZ_freeFall_1
			}
			
			state = PlayerState.gotkey
			keyParticles = true
			alarm[7] = 30
			scr_queueTVAnimation(global.TvSprPlayer_KeyGot, 60)
			ds_list_add(global.KeyFollowerList, instance_create(x, y, obj_spookey))
			
			with (other)
			{
				add_saveroom()
				instance_destroy()
			}
		}
	}
}
