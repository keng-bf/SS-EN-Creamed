var rowTotal, ylen, textArr, by, _final_scroll, i, taskArr, rowSelected, rowY, a, nm, len, j, task, isSelected, c, spr, ind, xlen, XS, taskX, taskY, currentRow, xind, palind, palpattern, txt, scrib;

draw_sprite_tiled(bg_pausescreenTile, 0, bgx--, bgy--);
draw_set_font(global.font);
rowTotal = array_length(levelArr);
ylen = (taskPadY * (rowTotal - 1) * (outfitRows - 1)) + 32;
draw_sprite_stretched_ext(spr_achmenu_body, 0, 0, scrollFactor, 960, ylen, c_ltgray, 1);
draw_set_color((selectH == 0 && selectV == -1) ? c_white : c_dkgray);
draw_text(128, 128 + scrollFactor, lang_get("opt_back"));
textArr = [];
by = (rowTotal * taskPadY) + (camera_get_view_height(view_camera[0]) / 2) + scrollFactor;
_final_scroll = 0;

for (i = 0; i < rowTotal; i++)
{
    taskArr = variable_struct_get(taskIcons, array_get(levelArr, i));
    rowSelected = i == selectV;
    rowY = (i * taskPadY) + (camera_get_view_height(view_camera[0]) / 2) + scrollFactor;
    a = clamp((-rowY / 240) + 2.5, 0, 1);
    draw_set_alpha(a);
    nm = "";
    
    if (array_contains(floorArr, levelArr[i]))
        nm = string_upper(lang_get(string("floor_{0}", levelArr[i])));
    else
        nm = string_upper(lang_get(string("level_{0}", levelArr[i])));
    
    draw_set_font(global.font);
    draw_set_color(rowSelected ? c_white : c_dkgray);
    draw_text_scribble(camera_get_view_width(view_camera[0]) / 2, rowY - string_height("A") - 32, string("[fa_bottom][fa_center]{0}", nm));
    len = array_length(taskArr);
    
    for (j = 0; j < len; j++)
    {
        task = taskArr[j];
        isSelected = rowSelected && j == selectH;
        c = 4210752;
        
        if (rowSelected)
            c = 12632256;
        
        if (isSelected)
        {
            c = 16777215;
            task.y = round(lerp(task.y, -16, 0.3));
        }
        else
        {
            task.y = round(lerp(task.y, 0, 0.3));
        }
        
        spr = task.get("taskSprite") ?? spr_null;
        ind = task.get("taskIndex");
        
        if (!task.isCompleted)
            ind += floor(sprite_get_number(spr) / 2);
        
        xlen = (len - 1) * taskPadX;
        XS = (camera_get_view_width(view_camera[0]) - xlen) / 2;
        taskX = XS + (j * taskPadX) + task.x;
        taskY = rowY + task.y + 20;
        draw_sprite_ext(spr, ind, taskX, taskY, 1, 1, 0, c, a);
        
        if (isSelected)
        {
            array_push(textArr, lang_get(task.get("taskKey")));
            array_push(textArr, lang_get(string("{0}_desc", task.get("taskKey"))));
        }
    }
}

draw_set_color((selectV > (rowTotal - 1)) ? c_white : c_dkgray);

for (i = 1; i <= array_length(outfitArr); i++)
{
    currentRow = ceil(i / 3) - 1;
    rowY = by + (currentRow * taskPadY);
    draw_set_font(global.font);
    
    if (i == 1)
        draw_text_scribble(camera_get_view_width(view_camera[0]) / 2, rowY - string_height("A") - 24, string("[fa_bottom][fa_center]{0}", lang_get("menutask_clothes")));
    
    rowSelected = (currentRow + rowTotal) == selectV;
    draw_set_color(rowSelected ? c_white : c_dkgray);
    a = clamp((-rowY / 240) + 2.5, 0, 1);
    draw_set_alpha(a);
    xind = (i - 1) % 3;
    xlen = 2 * taskPadX;
    
    if (currentRow == (outfitRows - 1))
        xlen = ((array_length(outfitArr) - 1) % 3) * taskPadX;
    
    task = outfitArr[i - 1];
    isSelected = rowSelected && xind == selectH;
    XS = (camera_get_view_width(view_camera[0]) - xlen) / 2;
    taskX = XS + (xind * taskPadX) + task.x + (irandom_range(-1, 1) * isSelected);
    taskY = rowY + task.y + (irandom_range(-1, 1) * isSelected) + 20;
    c = 4210752;
    
    if (rowSelected)
        c = 12632256;
    
    if (isSelected)
    {
        c = 16777215;
        task.y = round(lerp(task.y, -16, 0.3));
    }
    else
    {
        task.y = round(lerp(task.y, 0, 0.3));
    }
    
    palind = 0;
    palpattern = -4;
    ind = 0;
    
    if (!task.isCompleted)
        c = 0;
    
    switch (task.get("taskKey"))
    {
        case "palette_PZ_exhibitionred":
            ind = 5;
            palind = 1;
            break;
        
        case "palette_PZ_exhibitionblack":
            ind = 6;
            palind = 2;
            break;
        
        case "palette_PZ_exhibitionpurple":
            ind = 5;
            palind = 3;
            break;
        
        case "palette_PZ_noise":
            ind = 6;
            palind = 4;
            break;
        
        case "palette_PZ_exhibitionbrain":
            ind = 4;
            palind = 9;
            break;
        
        case "palette_PZ_exhibitionbraingold":
            ind = 4;
            palind = 10;
            break;
        
        case "palette_PZ_exhibitionpaper":
            ind = 7;
            palind = 12;
            break;
        
        case "palette_PZ_exhibitionentryway":
            ind = 0;
            palind = 5;
            break;
        
        case "palette_PZ_exhibitionsteamy":
            ind = 1;
            palind = 6;
            break;
        
        case "palette_PZ_exhibitionmineshaft":
            ind = 2;
            palind = 7;
            break;
        
        case "palette_PZ_exhibitionmolasses":
            ind = 3;
            palind = 8;
            break;
    }
    
    pal_swap_set(spr_patchpalettes, palind, false);
    draw_sprite_ext(spr_outfitpatches, ind, taskX, taskY, 1, 1, 0, c, a);
    shader_reset();
    
    if (isSelected)
    {
        if (task.isCompleted)
        {
            array_push(textArr, lang_get(task.get("taskKey")));
            array_push(textArr, lang_get(string("{0}_desc", task.get("taskKey"))));
        }
        else
        {
            array_push(textArr, lang_get("menutask_unknown"));
            array_push(textArr, lang_get(string("{0}_hint", task.get("taskKey"))));
        }
    }
}

draw_set_alpha(1);
draw_set_color(c_white);

if (array_length(textArr) > 0)
{
    draw_sprite_general(spr_darttrap_lightgradient, 0, 0, 0, 300, 300, 0, camera_get_view_height(view_camera[0]), 0.65, 4, 90, c_black, c_black, c_black, c_black, 1);
    txt = "[fa_middle][spr_promptfont][fa_center]";
    
    for (i = 0; i < array_length(textArr); i++)
        txt += string("{0}\n", textArr[i]);
    
    scrib = scribble(txt);
    scrib.wrap(camera_get_view_width(view_camera[0]) - 200);
    scrib.draw(camera_get_view_width(view_camera[0]) / 2, camera_get_view_height(view_camera[0]) * 0.85);
}
