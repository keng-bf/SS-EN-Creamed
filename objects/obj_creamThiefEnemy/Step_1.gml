event_inherited();

if (!active)
{
    if (state != States.frozen)
        state = States.frozen;
    
    if (baddieStunTimer > 0)
        active = true;
}

