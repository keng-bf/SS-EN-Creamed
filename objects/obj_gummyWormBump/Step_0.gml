var _offset, _length, overall_offset, x_component, y_component;

event_inherited();

if (instance_exists(linkedWorm))
{
    _offset = bumpOffset;
    _length = abs(linkedWorm.sprite_width);
    overall_offset = (bumpOffset - linkedWorm.offset) + 32;
    
    while (overall_offset < -32)
        overall_offset += _length;
    
    while (overall_offset > (_length + 32))
        overall_offset -= _length;
    
    x_component = sign(image_xscale) * dcos(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
    y_component = -sign(image_yscale) * dsin(image_angle + ((sign(image_yscale) == -1) ? 270 : 90));
    x = linkedWorm.x + (overall_offset * -linkedWorm.x_direction);
    y = linkedWorm.y + (overall_offset * linkedWorm.y_direction);
}
else
{
    instance_destroy();
}
