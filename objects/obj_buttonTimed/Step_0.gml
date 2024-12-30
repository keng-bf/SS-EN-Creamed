if (countdownCounter > 0 && currentState == States.normal)
{
    countdownCounter--;
    
    if (countdownCounter <= 0)
    {
        currentState = States.run;
        sprite_index = spr_Reverting;
    }
}

