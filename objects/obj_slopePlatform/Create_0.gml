canCollide = function(player = obj_parent_player)
{
    var _state;
    
    switch (player)
    {
        case obj_parent_player:
        case obj_player1:
        case obj_player2:
            _state = global.freezeframe ? player.frozenState : player.state;
            return _state != States.ladder;
            break;
        
        default:
            return true;
            break;
    }
};

