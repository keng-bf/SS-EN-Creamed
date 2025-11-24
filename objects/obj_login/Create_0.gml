if (!instance_exists(obj_gms))
    instance_create(0, 0, obj_gms);

gms_show_keyboard();
instance_deactivate_object_hook(obj_virtual_controller);

with (obj_virtual_controller)
    visible = false;

gms_show_set_allowguest(0);
gms_show_login();
