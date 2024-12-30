updateEffectPosition();

if (playerID.state != States.freefall && playerID.state != States.frostburnjump && playerID.state != States.climbwall && playerID.state != States.Sjump && playerID.state != States.superslam)
    instance_destroy();

if (playerID.state == States.superslam && playerID.sprite_index == playerID.spr_piledriverland)
    instance_destroy();

