if (state != States.stun)
    depth = 0;

if (state != States.charge && state != States.freezeframe)
    thrown = 0;

if (state == States.charge)
    hitboxcreate = 0;

if (x != obj_parent_player.x)
{
    movespeed = 3;
    image_xscale = sign(obj_parent_player.x - x);
}

