var player_hsp, player_vsp;

if (room == rank_room)
    visible = false;

player_hsp = playerID.x - playerID.xprevious;
player_vsp = playerID.y - playerID.yprevious;
x += (hSpeed + player_hsp);
y += ((vSpeed + player_vsp) - 1);
