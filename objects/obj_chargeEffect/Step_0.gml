updateEffectPosition();

if (playerID.sprite_index == playerID.spr_dive || (playerID.state != States.mach3 && !(playerID.state == States.run && playerID.movespeed >= 12) && !(playerID.state == States.machroll && playerID.mach3Roll > 0) && playerID.state != States.doughmountpancake && playerID.sprite_index != spr_player_PZ_flicked))
    instance_destroy();

