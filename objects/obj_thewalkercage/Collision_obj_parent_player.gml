if (other.state == States.grabdash)
{
    other.vsp = -2;
    other.hsp = -6 * other.xscale;
    other.state = States.bump;
    instance_destroy();
}

