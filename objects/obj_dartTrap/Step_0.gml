var player, top_near_x, top_near_y, top_far_x, top_far_y, bot_near_x, bot_near_y, bot_far_x, bot_far_y, player_detected;

player = instance_nearest(x, y, obj_parent_player);
top_near_x = x + ((dcos(image_angle) * (sprite_width / 2)) + (dsin(image_angle) * (sprite_height / 2)));
top_near_y = y - ((dsin(image_angle) * (sprite_width / 2)) - (dcos(image_angle) * (sprite_height / 2)));
top_far_x = top_near_x + (sign(image_xscale) * (dcos(image_angle) * sightRange));
top_far_y = top_near_y - (sign(image_xscale) * (dsin(image_angle) * sightRange));
bot_near_x = x + ((dcos(image_angle) * (sprite_width / 2)) - (dsin(image_angle) * (sprite_height / 2)));
bot_near_y = y - ((dsin(image_angle) * (sprite_width / 2)) + (dcos(image_angle) * (sprite_height / 2)));
bot_far_x = bot_near_x + (sign(image_xscale) * (dcos(image_angle) * sightRange));
bot_far_y = bot_near_y - (sign(image_xscale) * (dsin(image_angle) * sightRange));
player_detected = rectangle_in_triangle(player.bbox_left, player.bbox_top, player.bbox_right, player.bbox_bottom, top_near_x, top_near_y, top_far_x, top_far_y, bot_far_x, bot_far_y) || rectangle_in_triangle(player.bbox_left, player.bbox_top, player.bbox_right, player.bbox_bottom, top_near_x, top_near_y, bot_near_x, bot_near_y, bot_far_x, bot_far_y);

if (player_detected != 0)
    sawPlayer = player_detected;

if (tauntBuffer)
{
    if (obj_parent_player.state != States.taunt && obj_parent_player.state != States.parry && sprite_index != spr_dartFrog_shooting)
    {
        tauntBuffer = false;
        coolDown = 0;
    }
}

if (sawPlayer)
{
    if (coolDown <= 0)
    {
        sprite_index = spr_dartFrog_shooting;
        image_index = 0;
        firedDart = false;
        coolDown = coolDownMax;
    }
}

if (player_detected)
    coolDown--;

if (round(image_index) == 9 && sprite_index == spr_dartFrog_shooting && !firedDart)
{
    with (instance_create(x, y, obj_dartTrap_projectile, 
    {
        ownerID: id,
        image_xscale: image_xscale,
        image_angle: image_angle
    }))
    {
        velocity = other.dartVelocity;
        event_play_oneshot("event:/SFX/enemies/dartfrog", x, y);
    }
    
    firedDart = true;
}

