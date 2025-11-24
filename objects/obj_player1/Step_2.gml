clamp(state, PlayerState.normal, UnknownEnum2.Value_279);
clamp(xscale, -3, 3);
clamp(yscale, -3, 3);
clamp(sprite_width, 1, 3);
clamp(sprite_height, 1, 3);

if (instance_exists(obj_gms) && gms_info_isloggedin())
{
    gms_self_set("xscale", xscale);
    gms_self_set("yscale", yscale);
    gms_self_set("flash", flash);
    gms_self_set("nickname", (nickname == "") ? gms_self_name() : nickname);
    gms_self_set("visible", visible);
    gms_self_set("image_index", image_index);
    gms_self_set("img_angle", img_angle);
}

enum UnknownEnum2
{
    Value_279 = 279
}

event_inherited();

