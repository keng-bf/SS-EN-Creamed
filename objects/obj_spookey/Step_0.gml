var supertaunts, _total_frame, _player_pct, target_object, tgtX, tgtY, tgtMVSP, _d, hsp, vsp;

supertaunts = [obj_parent_player.spr_supertaunt1, obj_parent_player.spr_supertaunt2, obj_parent_player.spr_supertaunt3, obj_parent_player.spr_supertaunt4];

if (array_contains(supertaunts, obj_parent_player.sprite_index))
{
    if (sprite_index != spr_spookey_supertaunt)
    {
        sprite_index = spr_spookey_supertaunt;
        image_index = 0;
    }
    
    _total_frame = 8;
    _player_pct = obj_parent_player.image_index / _total_frame;
    image_index = floor(_player_pct * (image_number - 1));
    image_speed = 0;
    exit;
}

if (get_primaryPlayer().sprite_index == spr_player_PZ_gotKey)
{
    x = get_primaryPlayer().x;
    y = get_primaryPlayer().y;
    visible = 0;
    exit;
}
else
{
    visible = get_primaryPlayer().visible;
}

target_object = (ds_list_find_index(global.KeyFollowerList, id) <= 0) ? get_nearestPlayer(x, y) : ds_list_find_value(global.KeyFollowerList, ds_list_find_index(global.KeyFollowerList, id) - 1);
tgtX = target_object.x + (sign(target_object.image_xscale) * -((ds_list_find_index(global.KeyFollowerList, id) <= 0) ? 30 : 10));
tgtY = (ds_list_find_index(global.KeyFollowerList, id) <= 0) ? (target_object.y - 40) : (target_object.y - 3);
tgtMVSP = distance_to_point(tgtX, tgtY) / 200;

if (get_primaryPlayer().state == States.gotkey)
{
    tgtMVSP = 0.8;
    tgtX = get_primaryPlayer().x + (25 * get_primaryPlayer().xscale);
}

_d = point_direction(x, y, tgtX, tgtY);
hsp = lengthdir_x((18 * tgtMVSP) + 0.5, _d);
vsp = lengthdir_y((18 * tgtMVSP) + 0.5, _d);
x = approach(x, tgtX, hsp);
y = approach(y, tgtY, vsp);
x = round(x);
y = round(y);

if (x != target_object.x)
    image_xscale = abs(image_xscale) * getFacingDirection(x, target_object.x);

image_speed = 0.35;

if (x == xprevious)
    sprite_index = spr_spookey;
else
    sprite_index = spr_spookey_move;

if (blurEffectTimer-- <= 0)
{
    blurEffectTimer = 2;
    
    with (create_afterimage(AfterImageType.plain, image_xscale))
    {
        image_yscale = other.image_yscale;
        image_alpha = 0.6;
        image_index = other.image_index - 1;
        vanish = true;
    }
}

