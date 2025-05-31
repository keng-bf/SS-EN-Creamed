if (asset_get_index("obj_gmlive") != -1)
    instance_create(0, 0, obj_gmlive);
global.vkcount = 0;
global.forcehidecontrols = false;
global.forceshowcontrols = false;
global.movingvkeys = false
global.selectedvbutton = undefined
global.showbinds = true
global.vkeysgridmode = false
global.vkeysgrid_size = 16
global.colorvkeys = true
var _permsarray = ["android.permission.READ_MEDIA_IMAGES", "android.permission.READ_MEDIA_VIDEO", "android.permission.READ_MEDIA_AUDIO", "android.permission.MANAGE_EXTERNAL_STORAGE", "android.permission.READ_EXTERNAL_STORAGE"];

if (os_type == os_android)
{
    if (file_exists("saveData.ini") && !file_exists("/storage/emulated/0/Documents/sugary spire android/saves/saveData.ini.png"))
        file_copy("saveData.ini", "/storage/emulated/0/Documents/sugary spire android/saves/saveData.ini.png");
    
    if (file_exists("saves/saveData1.ini") && !file_exists("/storage/emulated/0/Documents/sugary spire android/saves/saveData1.ini.png"))
        file_copy("saves/saveData1.ini", "/storage/emulated/0/Documents/sugary spire android/saves/saveData1.ini.png");
    
    var _i = 0;
    
    repeat (array_length(_permsarray))
    {
        os_request_permission(_permsarray[_i]);
        _i++;
    }
}