depth = 4;

canCollide = function(argument0 = obj_parent_player)
{
    var _state;
    
    switch (argument0)
    {
        case obj_parent_player:
        case obj_player1:
        case obj_player2:
            _state = global.freezeframe ? argument0.frozenState : argument0.state;
            return _state == States.minecart || _state == States.minecart_launched || _state == States.minecart_bump || _state == States.actor;
            break;
        
        case obj_minecart:
        case obj_creamThiefCar:
        case obj_minecartCutscene:
        case obj_creamThief:
        case obj_cherryBombCart:
            return true;
            break;
        
        default:
            return false;
            break;
    }
};

