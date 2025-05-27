if (instance_exists(obj_fadeoutTransition))
    exit;
var nohurt = (other.state == PlayerState.noclip || other.state == PlayerState.grabdash || other.state == PlayerState.mach2 || other.state == PlayerState.mach3 || other.state == PlayerState.minecart || other.state == PlayerState.machroll)

if !nohurt
	scr_hurtplayer()
else
{
	instance_create(x, y, obj_poofeffect2)
	x = room_width / 2;
	y = -10;
}