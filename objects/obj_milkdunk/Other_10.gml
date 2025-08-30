if !in_saveroom()
{
	event_play_multiple("event:/SFX/general/collect", x, y)
    
    if (global.cafeseconds <= global.cafesecondssmall)
    {
        with (instance_create(0, 540 + sprite_get_height(spr_caferank1), obj_caferank))
        {
            collect = 400;
            collectend = 0;
            sprite_index = spr_caferank1;
        }
    }
    else if (global.cafeseconds <= (global.cafesecondssmall + 10) && !(global.cafeseconds <= global.cafesecondssmall))
    {
        with (instance_create(0, 540 + sprite_get_height(spr_caferank2), obj_caferank))
        {
            collect = 200;
            collectend = -150;
            sprite_index = spr_caferank2;
        }
    }
    else if (global.cafeseconds <= (global.cafesecondssmall + 20) && !(global.cafeseconds <= (global.cafesecondssmall + 10)) && !(global.cafeseconds <= global.cafesecondssmall))
    {
        with (instance_create(0, 540 + sprite_get_height(spr_caferank3), obj_caferank))
        {
            collect = 100;
            collectend = -300;
            sprite_index = spr_caferank3;
        }
    }
    else if (global.cafeseconds <= (global.cafesecondssmall + 30) && !(global.cafeseconds <= (global.cafesecondssmall + 20)) && !(global.cafeseconds <= (global.cafesecondssmall + 10)) && !(global.cafeseconds <= global.cafesecondssmall))
    {
        with (instance_create(0, 540 + sprite_get_height(spr_caferank4), obj_caferank))
        {
            collect = 0;
            collectend = -400;
            sprite_index = spr_caferank4;
        }
    }
    
	instance_destroy(obj_milkblock)
	global.CafeDrawer.dunk = true
	add_saveroom()
}

sprite_index = spr_milkgoal_filled
