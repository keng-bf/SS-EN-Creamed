x = playerID.x;
y = playerID.y;

if (mach && playerID.state != States.mach3 && !global.freezeframe)
    instance_destroy();

