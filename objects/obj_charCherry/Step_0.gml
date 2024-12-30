baddieCollisionBoxEnabled = state != States.charcherryrun;

if (state == States.frozen)
    state = States.charcherryrun;

event_inherited();

