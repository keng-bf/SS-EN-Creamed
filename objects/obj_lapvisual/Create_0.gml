y = -sprite_height
down = 1
movespeed = 2
depth = -100
sprite_index = lang_get_sprite(spr_lapbg)	
switch global.lapcount
{
	case 2:
		sprite_index = spr_lapbg2
		break
		
	case 3:
		sprite_index = spr_lapbg3
		break
		
	case 4:
		sprite_index = spr_lapbg4
		break
}