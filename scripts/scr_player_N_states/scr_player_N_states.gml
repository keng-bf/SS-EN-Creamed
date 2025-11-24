function state_noise_machcancel()
{
	noisemachcancelbuffer = 10;
	hsp = movespeed;
	move = key_right + key_left;
	
	if move != 0
		dir = move;
		
	if sprite_index == spr_player_N_divebomb || sprite_index == spr_player_N_divebomb_fall || sprite_index == spr_player_N_divebomb_land
	{
		if move != 0
		{
			if (abs(movespeed) < 12)
				movespeed = approach(movespeed, move * 12, 1);
			else
				movespeed = approach(movespeed, move * abs(movespeed), 1);
		}
		else
			movespeed = approach(movespeed, 0, 0.25);
			
		var xx = movespeed;
		
		if xx == 0
			xx = xscale;
			
		if (grounded && vsp > 0 && place_meeting(x + xx, y, obj_solid))
		{
			mask_index = spr_crouchmask;
			if (!place_meeting(x + xx, y, obj_solid) || place_meeting(x + xx, y, obj_destructibles))
			{
				state = PlayerState.machroll;
				sprite_index = spr_machroll;
				check_and_destroy(x + xx, y, obj_destructibles);
				if movespeed != 0
					xscale = sign(movespeed);
				movespeed = abs(movespeed);
				if movespeed < 6
					movespeed = 6;
			}
			mask_index = spr_player_mask;
		}
	}
	else if move != 0
		movespeed = approach(movespeed, move * 8, 1);
	else
		movespeed = approach(movespeed, 0, 0.5);

    if (scr_noise_machcancel_grab())
		exit;
    
    if (!can_jump && global.playerCharacter == Characters.Noise && key_up && inputBufferJump > 0 && !key_down)
    {
		inputBufferJump = 0;
		movespeed = hsp * xscale;
		state = PlayerState.freefallprep;
		sprite_index = spr_player_N_crusherIntro;
		image_index = 0;
		vsp = -16;
    }
	
	if (scr_checkgroundpound_held() && sprite_index != spr_player_N_divebomb_fall && !grounded)
	{
		sprite_index = spr_player_N_divebomb_fall;
		state = PlayerState.machcancel;
		vsp = 20;
		inputBufferSlap = 0;
		inputBufferJump = 0;
		image_index = 0;
		exit;
	}
	if grounded && sprite_index == spr_player_N_divebomb_fall
	{
		image_index = 0;
		sprite_index = spr_player_N_divebomb_land;
	}
	if (floor(image_index) == image_number - 1 && sprite_index == spr_player_N_divebomb_land)
	{
		image_index = 0;
		sprite_index = spr_player_N_divebomb;
	}
	if (grounded && !scr_checkgroundpound_held() && vsp >= 0 && sprite_index != spr_player_N_wallbounce)
	{
		vsp = -7;
		if move != 0
			xscale = move;
		with instance_create(x, y + 20, obj_puffEffect)
			sprite_index = spr_noisewalljumpeffect;
		sprite_index = spr_player_N_wallbounce;
	}
	if grounded && key_attack && vsp >= 0 && sprite_index == spr_player_N_wallbounce
	{
		inputBufferSlap = 0;
		if move != 0
			xscale = move;
		else if dir != 0
			xscale = dir;
		jumpStop = true;
		state = PlayerState.mach3;
		movespeed = 12;
		sprite_index = spr_mach3player;
		with instance_create(x, y, obj_puffEffect)
		{
			sprite_index = spr_noisegrounddasheffect;
			image_xscale = other.xscale;
		}
		flash = true;
		image_index = 0;
		with instance_create(x, y, obj_crazyRunEffect)
			image_xscale = other.xscale;
	}
	noisedoublejump = true;
	if (inputBufferSlap > 0 && key_up)
	{
		do_uppercut()
	}
	if (key_up && inputBufferJump > 0 && !scr_checkgroundpound())
	{
		freefallstart = 0;
		railmomentum = false;
	}
	if grounded && !key_attack && vsp >= 0 && sprite_index == spr_player_N_wallbounce
	{
		state = PlayerState.normal;
		movespeed = abs(hsp);
	}
	if (sprite_index == spr_player_N_divebomb || sprite_index == spr_player_N_divebomb_land || sprite_index == spr_player_N_divebomb_fall)
	{
		if (!instance_exists(dashCloudID) && grounded)
		{
			with (instance_create(x, y, obj_dashCloud))
			{
				image_xscale = other.move;
				other.dashCloudID = id;
			}
		}
		image_speed = (abs(movespeed) / 40) + 0.4;
	}
	else
		image_speed = 0.5;
	if punch_afterimage > 0
		punch_afterimage--;
	else
	{
		punch_afterimage = 5;
		instance_create(x + random_range(5, -5), y + random_range(20, -20), obj_tornadoeffect);
		if (grounded && (sprite_index == spr_player_N_divebomb || sprite_index = spr_player_N_divebomb_land || sprite_index == spr_player_N_divebomb_fall))
		{
			repeat 2
				instance_create(x + random_range(3, -3), y + 45, obj_noisedebris)
		}
	}
	scr_taunt_storeVariables();
}

function scr_noise_machcancel_grab()
{
	image_speed = 0.5;
    move = key_left + key_right;
    
    if (inputBufferSlap > 0 && !key_up)
    {
		if (move != 0)
			xscale = move;
            
		inputBufferSlap = 0;
		key_slap = false;
		key_slap2 = false;
		jumpstop = true;
            
		if (vsp > -5)
			vsp = -5;
            
		state = PlayerState.mach2;
		movespeed = 12;
		sprite_index = spr_player_N_sidewayspin_Intro;
            
		with (instance_create(x, y, obj_crazyRunHoopEffect))
			image_xscale = other.xscale;
            
		image_index = 0;
        
        return true;
    }
    
    return false;
}