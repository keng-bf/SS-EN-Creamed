function scr_enemy_eyescreamwait()
{
    var p, _dist, _disttoplayer, dir, _spd;
    
    image_speed = 0.35;
    sprite_index = spr_eyescreamsandwich;
    p = get_nearestPlayer();
    _dist = point_distance(x, y, xstart, ystart);
    _disttoplayer = point_distance(x, y, p.x, p.y);
    dir = point_direction(x, y, xstart, ystart);
    _spd = 5;
    hsp = approach(hsp, lengthdir_x(_spd, dir), 0.5);
    vsp = approach(vsp, lengthdir_y(_spd, dir), 0.5);
    x += hsp;
    y += vsp;
    
    if (abs(_dist) < 400 && abs(_disttoplayer) < 400)
        state = EnemyStates.eyescream;
    
    if (abs(_dist) <= 10)
    {
        state = EnemyStates.eyescreampopout;
        x = xstart;
        y = ystart;
        sprite_index = spr_eyescreamsandwich_wait;
    }
}

