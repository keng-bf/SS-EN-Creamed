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
            return _state != States.noclip && _state != States.cotton && _state != States.cottondrill && _state != States.cottonroll && _state != States.tumble && _state != States.taunt && _state != States.bump && _state != States.actor && _state != States.frozen;
            break;
        
        case obj_creamThief:
        case obj_bigcherry:
        case obj_gigacherrydead:
        case obj_cherryBombCart:
            return true;
            break;
        
        default:
            return false;
            break;
    }
};

