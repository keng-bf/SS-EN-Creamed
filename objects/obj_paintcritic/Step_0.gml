var thought_fade;

if (instance_exists(targetGate) && instance_exists(textbubble))
{
    with (targetGate)
        thought_fade = distance_to_object(obj_parent_player) / 125;
    
    textbubble.fade = 1 - thought_fade;
}
