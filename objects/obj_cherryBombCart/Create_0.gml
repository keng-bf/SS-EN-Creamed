canCollide = function(argument0 = obj_parent_player)
{
    var _state;
    
    switch (argument0)
    {
        case obj_parent_player:
        case obj_player1:
        case obj_player2:
            _state = global.freezeframe ? argument0.frozenState : argument0.state;
            return _state == States.mach3 || (_state == States.run && argument0.movespeed >= 12) || _state == States.frostburnslide || (_state == States.frostburnjump && argument0.movespeed > 5) || _state == States.puddle || (_state == States.machroll && argument0.mach3Roll > 0) || _state == States.minecart || (_state == States.bottlerocket && argument0.substate == 0);
            break;
        
        default:
            return true;
            break;
    }
};

hsp = 0;

