instance_destroy(obj_gms);
instance_activate_object(obj_virtual_controller);

with (obj_virtual_controller)
    visible = true;
room_goto_fixed(hub_demohallway)