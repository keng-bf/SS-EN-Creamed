var buffer_info, boffset, i;

if (use_livesplit && ls_buffer >= 0)
{
    buffer_info = [[global.SaveMinutes, 9, 8], [global.SaveSeconds, 9, 8], [global.LevelMinutes, 9, 8], [global.LevelSeconds, 9, 8], [room_get_name(room), 11, 64], [instance_exists(obj_endlevelfade), 1, 1]];
    boffset = ls_buffer_start;
    
    for (i = 0; i < array_length(buffer_info); i++)
    {
        buffer_poke(ls_buffer, boffset, buffer_info[i][1], buffer_info[i][0]);
        boffset += buffer_info[i][2];
    }
}
