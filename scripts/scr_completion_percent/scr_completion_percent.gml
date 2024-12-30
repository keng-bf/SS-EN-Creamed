function scr_completion_percent(argument0)
{
    var levels, ranks, levels_count, confecti_count, secret_count, task_count, rank_count, p_rank_count, treasure_count, completed_tutorial, i, rank, j, tasks, completion;
    
    if (file_exists(argument0))
    {
        ini_open(argument0);
        levels = ["entryway", "steamy", "mineshaft", "molasses"];
        ranks = ["d", "c", "b", "a", "s"];
        levels_count = 0;
        confecti_count = 0;
        secret_count = 0;
        task_count = 0;
        rank_count = 0;
        p_rank_count = 0;
        treasure_count = 0;
        completed_tutorial = ini_read_real("Misc", "completedtutorial", 0);
        
        for (i = 0; i < array_length(levels); i++)
        {
            if (ini_key_exists("Highscore", levels[i]))
                levels_count++;
            
            rank = ini_read_string("Ranks", levels[i], "d");
            
            if (rank == "p")
            {
                rank_count += 4;
                p_rank_count++;
            }
            else
            {
                rank_count += array_get_index(ranks, rank);
            }
            
            for (j = 0; j < 5; j++)
            {
                if (ini_read_real("Confecti", levels[i] + string(j + 1), 0))
                    confecti_count++;
            }
            
            for (j = 0; j < 3; j++)
                secret_count += (ini_read_real("Secret", levels[i] + string(j + 1), 0) ? 1 : 0);
            
            if (ini_read_real("Treasure", levels[i], 0))
                treasure_count++;
            
            tasks = scr_get_chef_tasks(levels[i], false);
            
            for (j = 0; j < array_length(tasks); j++)
            {
                if (ini_read_real("ChefTasks", tasks[j].taskKey, 0))
                    task_count++;
            }
        }
        
        ini_close();
        completion = 0;
        completion += (1 * completed_tutorial);
        completion += ((9 * levels_count) / 4);
        completion += ((10 * rank_count) / 16);
        completion += ((20 * confecti_count) / 20);
        completion += ((30 * secret_count) / 12);
        completion += ((20 * treasure_count) / 4);
        completion += ((10 * task_count) / 12);
        completion += ((1 * p_rank_count) / 4);
        show_debug_message(string("File: {0}", filename_name(argument0)));
        show_debug_message(string("Completion of tutorial: {0}", completed_tutorial));
        show_debug_message(string("Number of levels: {0}", levels_count));
        show_debug_message(string("Completion of levels: {0}", levels_count / 4));
        show_debug_message(string("Number of ranks: {0}", rank_count));
        show_debug_message(string("Completion of ranks: {0}", rank_count / 16));
        show_debug_message(string("Number of confecti: {0}", confecti_count));
        show_debug_message(string("Completion of confecti: {0}", confecti_count / 20));
        show_debug_message(string("Number of secrets: {0}", secret_count));
        show_debug_message(string("Completion of secrets: {0}", secret_count / 12));
        show_debug_message(string("Number of treasures: {0}", treasure_count));
        show_debug_message(string("Completion of treasures: {0}", treasure_count / 4));
        show_debug_message(string("Number of tasks: {0}", task_count));
        show_debug_message(string("Completion of tasks: {0}", task_count / 12));
        show_debug_message(string("Number of p-ranks: {0}", p_rank_count));
        show_debug_message(string("Completion of p-ranks: {0}", p_rank_count / 4));
        show_debug_message(string("Completion: {0}", completion));
        show_debug_message(string("Completion Floored: {0}", floor(completion)));
        return floor(completion);
    }
    else
    {
        return 0;
    }
}

function scr_check_completion(argument0 = global.SaveFileName)
{
    var levels, count, i, rank;
    
    levels = ["entryway", "steamy", "mineshaft", "molasses"];
    count = 0;
    ini_open(argument0);
    
    for (i = 0; i < array_length(levels); i++)
    {
        rank = ini_read_string("Ranks", levels[i], "none");
        
        if (rank != "none")
            count++;
    }
    
    ini_close();
    return count >= array_length(levels);
}
