updateEffectPosition();

if ((playerID.state != States.climbwall && playerID.state != States.Sjump) || playerID.sprite_index == playerID.spr_superjumpCancelIntro)
    instance_destroy();

