var i, tasks, j, completed_task, palArr, p, unlocked_outfit;

taskIcons = {};
ini_open(global.SaveFileName);

for (i = 0; i < array_length(levelArr); i++)
{
    tasks = scr_get_chef_tasks(levelArr[i], false);
    
    for (j = 0; j < array_length(tasks); j++)
    {
        completed_task = ini_read_string("ChefTasks", tasks[j].taskKey, "0") != "0";
        addTask(levelArr[i], new taskIcon(tasks[j], completed_task));
    }
    
    if (global.InternalLevelName == levelArr[i])
        selectV = i;
    else if (is_hub() && levelArr[i] == "demoEN")
        selectV = i;
}

ini_close();
ini_open("optionData.ini");
palArr = scr_get_palettes(false);

for (i = 0; i < array_length(palArr); i++)
{
    p = palArr[i];
    unlocked_outfit = ini_read_string("Palettes", p.taskKey, "0") != "0";
    addOutfit(new taskIcon(p, unlocked_outfit));
}

ini_close();
outfitRows = ceil(array_length(outfitArr) / 3);
