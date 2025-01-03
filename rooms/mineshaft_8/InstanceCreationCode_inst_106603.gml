flags.do_once_per_save = true;

condition = function()
{
    return ds_list_find_index(global.SaveRoom, inst_106078) != -1 && global.minesProgress == false;
};

output = function()
{
    global.minesProgress = true;
};
