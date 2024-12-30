if (currentState == States.titlescreen)
{
    currentState = States.normal;
    sprite_index = spr_Pressed;
}
else if (currentState == States.run)
{
    currentState = States.frozen;
    sprite_index = spr_Released;
}

