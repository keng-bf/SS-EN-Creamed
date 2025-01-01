canCollide = function(argument0 = obj_parent_player)
{
    switch (argument0)
    {
        case obj_parent_player:
        case obj_player1:
        case obj_player2:
            return argument0.state != States.minecart && argument0.state != States.minecart_bump && argument0.state != States.minecart_launched;
            break;
        
        default:
            return true;
            break;
    }
};

image_speed = 0.05;

