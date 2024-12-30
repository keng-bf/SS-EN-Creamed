canCollide = function(argument0 = obj_parent_player)
{
    var _state;
    
    switch (argument0)
    {
        case obj_parent_player:
        case obj_player1:
        case obj_player2:
            _state = global.freezeframe ? argument0.frozenState : argument0.state;
            return _state != States.ladder;
            break;
        
        default:
            return true;
            break;
    }
};

