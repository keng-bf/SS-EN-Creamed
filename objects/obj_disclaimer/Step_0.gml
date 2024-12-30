scr_getinput();

if (any_input_pressed_check() || keyboard_check_pressed(vk_enter))
    event_user(0);
