if (!start)
    exit;

alarm[0] = 60;

if (obj_parent_player.state != PlayerState.actor)
{
    seconds--;
    
    if (seconds < 0)
    {
        if (minutes > 0)
        {
            minutes--;
            seconds = 59;
        }
        else if (room != rank_room)
        {
			with (obj_parent_player)
			{
				instance_destroy(obj_fadeoutTransition)
				scr_levelSet()
				targetDoor = "A"
				global.panic = 0
				global.greyscalefade = 0
				room = timesuproom
				state = PlayerState.timesup
				sprite_index = spr_Timesup
				image_index = 0
				event_play_oneshot("event:/music/timesup")
			}
		
            
            instance_destroy();
        }
    }
}