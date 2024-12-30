var p, offset;

if (!receiver)
{
    p = other.id;
    offset = p.y - y;
    
    with (obj_screenwrap)
    {
        if (trigger == other.trigger && receiver)
        {
            if (type == 0)
            {
                p.x = x;
                p.y = y + offset;
            }
            else
            {
                p.y = y;
            }
        }
    }
}
