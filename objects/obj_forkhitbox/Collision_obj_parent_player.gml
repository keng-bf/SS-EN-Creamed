var impaling_creatures, hurt_player;

if (!instance_exists(ID) || (other.state == States.mach3 || other.state == States.dodgetumble || other.state == States.minecart))
    exit;

impaling_creatures = [obj_knight, obj_bananaCharger, obj_sluggy];
hurt_player = scr_hurtplayer(other.id);

if (hurt_player)
    create_particle(round((x + other.x) / 2), round((y + other.y) / 2), spr_parryeffect);

