x = playerID.x;
y = playerID.y;

if ((playerID.state != States.grind && playerID.state != States.minecart) || !playerID.grounded)
    instance_destroy();

