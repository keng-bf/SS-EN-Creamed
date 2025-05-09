if(room == rm_virtualcontrollerload && !variable_instance_exists(self, "gamestartedlmao")){
	instance_destroy()
}
event_perform(ev_mouse, ev_global_left_button)