var p = obj_parent_player
x = median(x - maxspeed, p.x, x + maxspeed);
y = median(y - maxspeed, p.y, y + maxspeed);
savedCamX = x
savedCamY = y

if (x != p.x)
    image_xscale = -sign(x - p.x);