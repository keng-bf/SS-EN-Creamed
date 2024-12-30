var _found, i, _ind;

offset = (offset + wormSpeed) % abs(sprite_width);

if (debug)
    image_angle += 3;

x_direction = dcos(image_angle + ((sign(image_xscale) == -1) ? 0 : 180));
y_direction = dsin(image_angle + ((sign(image_xscale) == -1) ? 0 : 180));
_found = false;

with (obj_gummyWormBump)
{
    if (linkedWorm == other.id)
        _found = true;
}

if (!_found && !debug && hasBump)
    instance_destroy();

for (i = 0; i < array_length(segments); i++)
{
    _ind = segmentIndices[i];
    _ind += image_speed;
    
    if (_ind >= sprite_get_number(segments[i]))
        _ind = frac(_ind);
    
    segmentIndices[i] = _ind;
}
