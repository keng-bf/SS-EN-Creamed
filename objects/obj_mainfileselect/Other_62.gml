if (ds_map_find_value(async_load, "id") == fetch)
{
    if (ds_map_find_value(async_load, "status") == 0)
        global.newgameversion = ds_map_find_value(async_load, "result");
}
