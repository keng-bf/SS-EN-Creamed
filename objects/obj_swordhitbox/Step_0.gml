image_xscale = obj_parent_player.xscale;
x = obj_parent_player.x;
y = obj_parent_player.y;

if (!global.freezeframe && obj_parent_player.state != States.frozen && obj_parent_player.state != States.finishingblow)
    instance_destroy();

