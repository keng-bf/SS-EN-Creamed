var sprit = sprite_index;
clamp(state, PlayerState.normal, UnknownEnum.Value_279);
clamp(xscale, -3, 3);
clamp(yscale, -3, 3);
clamp(pause, 0, 1);
clamp(sprite_width, 1, 3);
clamp(sprite_height, 1, 3);

if (!sprite_exists(sprit))
    sprit = 40;

enum UnknownEnum
{
    Value_279 = 279
}
