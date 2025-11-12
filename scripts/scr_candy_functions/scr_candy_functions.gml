function approach(arg0, arg1, arg2)
{
	return arg0 + clamp(arg1 - arg0, -arg2, arg2);
}

function instance_random(arg0)
{
	return instance_find(arg0, irandom(instance_number(arg0) - 1));
}

function trace()
{
	var trace_string = ""
	
	for (var i = 0; i < argument_count; i++)
		trace_string += string(argument[i])
	
	show_debug_message(trace_string)
	exit
}

function get_panic()
{
	return (global.panic && !global.RoomIsSecret) || instance_exists(obj_sucroseTimer);
}

function chance(arg0)
{
	return (debug_mode ? true : (random(100) <= arg0));
}

function wave(arg0, arg1, arg2, arg3, arg4 = global.CurrentTime)
{
	var a4 = (arg1 - arg0) / 2
	return arg0 + a4 + (sin((((arg4 * 0.001) + (arg2 * arg3)) / arg2) * 2 * pi) * a4);
}
function Wave(arg0, arg1, arg2, arg3, arg4 = -4)
{
    var a4 = (arg1 - arg0) * 0.5;
    var t = current_time;
    
    if (arg4 != -4)
        t = arg4;
    
    return arg0 + a4 + (sin((((t * 0.001) + (arg2 * arg3)) / arg2) * (2 * pi)) * a4);
}

function wrap(arg0, arg1, arg2)
{
	var _min = min(arg1, arg2)
	var _max = max(arg1, arg2)
	var range = (_max - _min) + 1
	return ((((arg0 - _min) % range) + range) % range) + _min;
}

function animation_end_old(arg0 = floor(image_index), arg1 = image_number - 1)
{
	return arg0 >= arg1;
}

function sprite_animation_end(arg0 = sprite_index, arg1 = image_index, arg2 = sprite_get_number(arg0), arg3 = image_speed)
{
	return (arg1 + ((arg3 * sprite_get_speed(arg0)) / ((sprite_get_speed_type(arg0) == 1) ? 1 : game_get_speed(gamespeed_fps)))) >= arg2;
}

function absfloor(arg0)
{
	return (arg0 > 0) ? floor(arg0) : ceil(arg0);
}

function rank_checker(arg0 = global.rank)
{
	var ranks = ["d", "c", "b", "a", "s", "p"]
	
	for (var i = 0; i < array_length(ranks); i++)
	{
		if (arg0 == ranks[i])
			return i;
	}
	
	return -4;
}

function string_extract(arg0, arg1, arg2)
{
	var len = string_length(arg1) - 1
	
	repeat (arg2)
		arg0 = string_delete(arg0, 1, string_pos(arg1, arg0) + len)
	
	arg0 = string_delete(arg0, string_pos(arg1, arg0), string_length(arg0))
	return arg0;
}

function create_small_number(arg0, arg1, arg2, arg3 = c_white)
{
	return instance_create(arg0, arg1, obj_smallnumber, 
	{
		image_blend: arg3,
		number: string(arg2)
	});
}

function array_get_any(arg0)
{
	return array_get(arg0, irandom_range(0, array_length(arg0) - 1));
}

function draw_sprite_ext_flash(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
	gpu_set_fog(true, arg7, 0, 1)
	draw_sprite_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	gpu_set_fog(false, c_black, 0, 0)
}

function draw_self_flash(arg0)
{
	draw_sprite_ext_flash(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, arg0, image_alpha)
}

function draw_sprite_ext_duotone(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
	shader_set(shd_afterimage)
	var color_blend_1 = shader_get_uniform(shd_afterimage, "blendcolor1")
	var color_blend_2 = shader_get_uniform(shd_afterimage, "blendcolor2")
	shader_set_uniform_f(color_blend_1, color_get_red(arg7) / 255, color_get_green(arg7) / 255, color_get_blue(arg7) / 255)
	shader_set_uniform_f(color_blend_2, color_get_red(arg8) / 255, color_get_green(arg8) / 255, color_get_blue(arg8) / 255)
	draw_sprite_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, c_white, arg9)
	shader_reset()
}

function draw_self_duotone(arg0, arg1)
{
	draw_sprite_ext_duotone(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, arg0, arg1, image_alpha)
}

function time_in_frames(arg0, arg1)
{
	return ((arg0 * 60) + arg1) * 60;
}

function onBeat(arg0, arg1 = false)
{
	var bps = arg0 / 60,spb = 1 / bps,song_timer = audio_sound_get_track_position(global.music),game_fps = 60,beat2 = floor(song_timer) / (spb * game_fps)
	
	if (beat != beat2)
	{
		beat = beat2
		return true;
	}
	
	return false;
}

function solid_in_line(arg0, arg1 = -4, arg2 = self)
{
	var _list = ds_list_create(),set_list = collision_line_list(x, y, arg0.x, arg0.y, obj_parent_collision, true, true, _list, true)
	
	if (set_list > 0)
	{
		for (var i = 0; i < set_list; i++)
		{
			var obj = ds_list_find_value(_list, i)
			
			if (arg1 != -4)
			{
				var found_obj = false
				
				for (var b = 0; b < array_length(arg1); b++)
				{
					var arr = arg1[b]
					
					if (obj.object_index == arr)
						found_obj = true
				}
				
				if (!found_obj)
				{
					ds_list_destroy(_list)
					return true;
				}
			}
			else
			{
				ds_list_destroy(_list)
				return true;
			}
		}
	}
	
	ds_list_destroy(_list)
	return false;
}

function angle_rotate(arg0, arg1, arg2)
{
	var diff = wrap(arg1 - arg0, -180, 180)
	
	if (diff < -arg2)
		return arg0 - arg2;
	
	if (diff > arg2)
		return arg0 + arg2;
	
	return arg1;
}

function getFacingDirection(arg0, arg1)
{
	if (arg0 != arg1)
		return -sign(arg0 - arg1);
	
	return 1;
}

function number_in_range(arg0, arg1, arg2)
{
	return arg0 >= arg1 && arg0 <= arg2;
}

function parameter_get_array()
{
	var p_num = parameter_count(),p_string = []
	
	if (p_num > 0)
	{
		for (var i = 0; i < p_num; i++)
			p_string[i] = parameter_string(i)
	}
	
	return p_string;
}

function round_nearest(arg0, arg1)
{
	var val = abs(arg1[0] - arg0),ind = 0
	
	for (var i = 1; i < array_length(arg1); i++)
	{
		var dist = abs(arg1[i] - arg0)
		
		if (dist < val)
		{
			ind = i
			val = dist
		}
	}
	
	return arg1[ind];
}

function randomize_animations(arg0)
{
	if (!variable_instance_exists(self, "saved_rand_anim"))
		saved_rand_anim = []
	
	if (!variable_instance_exists(self, "rand_anim"))
		rand_anim = []
	
	if (saved_rand_anim != arg0 || array_length(rand_anim) <= 0)
	{
		saved_rand_anim = arg0
		rand_anim = array_shuffle(arg0)
	}
	
	return array_shift(rand_anim);
}

function array_clone(arg0)
{
	var temp_arr = []
	array_copy(temp_arr, 0, arg0, 0, array_length(arg0))
	return temp_arr;
}

function get_mouse_x_screen(arg0 = 0)
{
	var mouse_xpos = device_mouse_x_to_gui(arg0),params = calculate_letterbox_params()
	return round((mouse_xpos - params.screen_x) / params.scale);
}

function get_mouse_y_screen(arg0 = 0)
{
	var mouse_ypos = device_mouse_y_to_gui(arg0),params = calculate_letterbox_params()
	return round((mouse_ypos - params.screen_y) / params.scale);
}

function get_mouse_x(arg0 = 0)
{
	var mouse_xpos = get_mouse_x_screen(arg0),camera_x = camera_get_view_x(view_camera[0]),camera_width = camera_get_view_width(view_camera[0]),gui_width = display_get_gui_width(),zoom_x = camera_width / gui_width
	return round(camera_x + (mouse_xpos * zoom_x));
}

function get_mouse_y(arg0 = 0)
{
	var mouse_ypos = get_mouse_y_screen(arg0),camera_y = camera_get_view_y(view_camera[0]),camera_height = camera_get_view_height(view_camera[0]),gui_height = display_get_gui_height(),zoom_y = camera_height / gui_height
	return round(camera_y + (mouse_ypos * zoom_y));
}

function layer_type_get_id(arg0, arg1)
{
	if (layer_exists(arg0))
	{
		var layer_elements = layer_get_all_elements(arg0)
		
		for (var i = 0; i < array_length(layer_elements); i++)
		{
			if (layer_get_element_type(layer_elements[i]) == arg1)
				return layer_elements[i];
		}
	}
	
	return -1;
}

function layer_tilemap_get_id_fixed(arg0)
{
	return layer_type_get_id(arg0, 5);
}

function layer_background_get_id_fixed(arg0)
{
	return layer_type_get_id(arg0, 1);
}

function layer_asset_get_id(arg0)
{
	return layer_type_get_id(arg0, 4);
}

function layer_get_all_sprites(arg0)
{
	var temp_array = []
	
	if (layer_exists(arg0))
	{
		var a = layer_get_all_elements(arg0)
		
		for (var i = 0; i < array_length(a); i++)
		{
			if (layer_get_element_type(a[i]) == 4)
				array_push(temp_array, a[i])
		}
	}
	
	return temp_array;
}

function layer_get_all_instances(arg0)
{
	var temp_array = []
	
	if (layer_exists(arg0))
	{
		var a = layer_get_all_elements(arg0)
		
		for (var i = 0; i < array_length(a); i++)
		{
			if (layer_get_element_type(a[i]) == 2)
				array_push(temp_array, a[i])
		}
	}
	
	return temp_array;
}

function layer_change_background(arg0, arg1)
{
	if (arg0 != arg1)
	{
		var a = layer_get_all()
		
		for (var i = 0; i < array_length(a); i++)
		{
			var back_id = layer_background_get_id_fixed(a[i])
			
			if (layer_background_get_sprite(back_id) == arg0)
				layer_background_sprite(back_id, arg1)
		}
	}
}

function layer_change_tileset(arg0, arg1)
{
	if (arg0 != arg1)
	{
		var a = layer_get_all()
		
		for (var i = 0; i < array_length(a); i++)
		{
			var tile_id = layer_tilemap_get_id_fixed(a[i])
			
			if (tilemap_get_tileset(tile_id) == arg0)
				tilemap_tileset(tile_id, arg1)
		}
	}
}

function point_in_camera(arg0, arg1, arg2)
{
	var cam_x = camera_get_view_x(arg2)
	var cam_y = camera_get_view_y(arg2)
	var cam_w = camera_get_view_width(arg2)
	var cam_h = camera_get_view_height(arg2)
	return point_in_rectangle(arg0, arg1, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function bbox_in_camera(arg0, arg1, arg2 = 0)
{
	var cam_x = camera_get_view_x(arg1)
	var cam_y = camera_get_view_y(arg1)
	var cam_w = camera_get_view_width(arg1)
	var cam_h = camera_get_view_height(arg1)
	return bbox_in_rectangle(arg0, cam_x - arg2, cam_y - arg2, cam_x + cam_w + arg2, cam_y + cam_h + arg2);
}

function camera_get_position_struct(arg0, arg1 = -4) constructor
{
	var _cam_x = camera_get_view_x(arg0)
	var _cam_y = camera_get_view_y(arg0)
	var _cam_width = camera_get_view_width(arg0)
	var _cam_height = camera_get_view_height(arg0)
	centeredcam_x = _cam_x + (_cam_width / 2)
	centeredcam_y = _cam_y + (_cam_height / 2)
	cam_x = _cam_x
	cam_y = _cam_y
	
	if (arg1 != -4)
	{
		centeredcam_x -= arg1[0]
		centeredcam_y -= arg1[1]
	}
}

function screen_flash(arg0)
{
	global.screenflash = arg0
}

function camera_shake_add(arg0, arg1, arg2 = 0)
{
	with (obj_camera)
		ds_list_add(cameraShakeList, new addCameraShake(arg0, arg1 / room_speed, arg2))
}

function camera_shake_clearAll(arg0 = false)
{
	with (obj_camera)
	{
		for (var i = 0; i < ds_list_size(cameraShakeList); i++)
		{
			with (ds_list_find_value(cameraShakeList, i))
			{
				shakeTime = 0
				
				if (arg0)
				{
					shakeMag = 0
					ds_list_set(other.cameraShakeList, i, undefined)
					ds_list_delete(other.cameraShakeList, i)
				}
				else
				{
				}
			}
		}
	}
}

function scr_input_varinit()
{
	key_up = false
	key_up2 = false
	key_right = false
	key_right2 = false
	key_left = false
	key_left2 = false
	key_down = false
	key_down_release = false
	key_down2 = false
	key_jump = false
	key_jump2 = false
	key_jump_release = false
	key_slap = false
	key_slap2 = false
	key_taunt = false
	key_taunt2 = false
	key_attack = false
	key_attack2 = false
	key_shoot = false
	key_shoot2 = false
	key_start = false
	key_start2 = false
	key_escape = false
	stickpressed = false
}

function scr_getinput_menu()
{
	if (global.shellactivate)
		exit
	
	key_up = input_check("menuup")
	key_up2 = input_check_pressed("menuup")
	key_right = input_check("menuright")
	key_right2 = input_check_pressed("menuright")
	key_left = -input_check("menuleft")
	key_left2 = -input_check_pressed("menuleft")
	key_down = input_check("menudown")
	key_down_release = input_check_released("menudown")
	key_down2 = input_check_pressed("menudown")
	key_jump2 = input_check("menuconfirm")
	key_jump = input_check_pressed("menuconfirm")
	key_jump_release = input_check_released("menuconfirm")
	key_slap = input_check("menuback")
	key_slap2 = input_check_pressed("menuback")
	key_taunt = input_check("menudelete")
	key_taunt2 = input_check_pressed("menudelete")
	key_attack = false
	key_attack2 = false
	key_shoot = false
	key_shoot2 = false
	key_start = input_check("start")
	key_start2 = input_check_pressed("start")
	key_special = false
	key_special2 = false
	key_escape = key_start
	key_superjump = input_check("superjump")
	key_groundpound = input_check("groundpound")
	return true;
}

function scr_getinput()
{
	scr_input_varinit()
	
	if (global.shellactivate)
		exit
	
	key_up = input_check("up")
	key_up2 = input_check_pressed("up")
	key_right = input_check("right")
	key_right2 = input_check_pressed("right")
	key_left = -input_check("left")
	key_left2 = -input_check_pressed("left")
	key_down = input_check("down")
	key_down_release = input_check_released("down")
	key_down2 = input_check_pressed("down")
	key_jump2 = input_check("jump")
	key_jump = input_check_pressed("jump")
	key_jump_release = input_check_released("jump")
	key_slap = input_check("slap")
	key_slap2 = input_check_pressed("slap")
	key_taunt = input_check("taunt")
	key_taunt2 = input_check_pressed("taunt")
	key_attack = input_check("attack")
	key_attack2 = input_check_pressed("attack")
	key_shoot = input_check("shoot")
	key_shoot2 = input_check_pressed("shoot")
	key_start = input_check("start")
	key_start2 = input_check_pressed("start")
	key_special = input_check("special")
	key_special2 = input_check_pressed("special")
	key_escape = input_check("start")
	key_superjump = input_check("superjump")
	key_groundpound = input_check("groundpound")
	return true;
}

function input_check(arg0)
{
	return input_get(arg0).held || input_get(string("{0}C", arg0)).held;
}

function input_check_pressed(arg0)
{
	return input_get(arg0).pressed || input_get(string("{0}C", arg0)).pressed;
}

function input_check_released(arg0)
{
	return input_get(arg0).released || input_get(string("{0}C", arg0)).released;
}

function any_input_check()
{
	var keys = ds_map_keys_to_array(global.input_map)
	
	for (var i = 0; i < array_length(keys); i++)
	{
		if (ds_map_find_value(global.input_map, array_get(keys, i)).held || ds_map_find_value(global.input_map, array_get(keys, i)).pressed)
		{
			return true;
			break
		}
	}
	
	return keyboard_check(vk_anykey) || keyboard_check_pressed(vk_anykey);
}

function any_input_pressed_check()
{
	var keys = ds_map_keys_to_array(global.input_map)
	
	for (var i = 0; i < array_length(keys); i++)
	{
		if (ds_map_find_value(global.input_map, array_get(keys, i)).pressed)
		{
			return true;
			break
		}
	}
	
	return keyboard_check_pressed(vk_anykey);
}

function scr_key_display(arg0)
{
}

function scr_keyname(arg0)
{
	var key_name = ""
	
	if (ds_map_exists(global.SpecialKeyNameMap, arg0))
	{
		key_name = ds_map_find_value(global.SpecialKeyNameMap, real(arg0))
	}
	else
	{
		var _f = draw_get_font()
		draw_set_font(font_arial12)
		key_name = chr(arg0)
		draw_set_font(_f)
	}
	
	return key_name;
}

function scr_initKeyNameMap()
{
	if (!variable_global_exists("SpecialKeyNameMap"))
		global.SpecialKeyNameMap = ds_map_create()
	
	ds_map_set(global.SpecialKeyNameMap, vk_left, lang_get("key_left"))
	ds_map_set(global.SpecialKeyNameMap, vk_right, lang_get("key_right"))
	ds_map_set(global.SpecialKeyNameMap, vk_up, lang_get("key_up"))
	ds_map_set(global.SpecialKeyNameMap, vk_down, lang_get("key_down"))
	ds_map_set(global.SpecialKeyNameMap, vk_enter, lang_get("key_enter"))
	ds_map_set(global.SpecialKeyNameMap, vk_escape, lang_get("key_escape"))
	ds_map_set(global.SpecialKeyNameMap, vk_space, lang_get("key_space"))
	ds_map_set(global.SpecialKeyNameMap, vk_shift, lang_get("key_shift"))
	ds_map_set(global.SpecialKeyNameMap, vk_control, lang_get("key_control"))
	ds_map_set(global.SpecialKeyNameMap, vk_alt, lang_get("key_alt"))
	ds_map_set(global.SpecialKeyNameMap, vk_backspace, lang_get("key_backspace"))
	ds_map_set(global.SpecialKeyNameMap, vk_tab, lang_get("key_tab"))
	ds_map_set(global.SpecialKeyNameMap, vk_home, lang_get("key_home"))
	ds_map_set(global.SpecialKeyNameMap, vk_end, lang_get("key_end"))
	ds_map_set(global.SpecialKeyNameMap, vk_delete, lang_get("key_delete"))
	ds_map_set(global.SpecialKeyNameMap, vk_insert, lang_get("key_insert"))
	ds_map_set(global.SpecialKeyNameMap, vk_pageup, lang_get("key_pageup"))
	ds_map_set(global.SpecialKeyNameMap, vk_pagedown, lang_get("key_pagedown"))
	ds_map_set(global.SpecialKeyNameMap, vk_pause, lang_get("key_pause"))
	ds_map_set(global.SpecialKeyNameMap, vk_printscreen, lang_get("key_printscreen"))
	ds_map_set(global.SpecialKeyNameMap, vk_f1, "F1")
	ds_map_set(global.SpecialKeyNameMap, vk_f2, "F2")
	ds_map_set(global.SpecialKeyNameMap, vk_f3, "F3")
	ds_map_set(global.SpecialKeyNameMap, vk_f4, "F4")
	ds_map_set(global.SpecialKeyNameMap, vk_f5, "F5")
	ds_map_set(global.SpecialKeyNameMap, vk_f6, "F6")
	ds_map_set(global.SpecialKeyNameMap, vk_f7, "F7")
	ds_map_set(global.SpecialKeyNameMap, vk_f8, "F8")
	ds_map_set(global.SpecialKeyNameMap, vk_f9, "F9")
	ds_map_set(global.SpecialKeyNameMap, vk_f10, "F10")
	ds_map_set(global.SpecialKeyNameMap, vk_f11, "F11")
	ds_map_set(global.SpecialKeyNameMap, vk_f12, "F12")
	ds_map_set(global.SpecialKeyNameMap, vk_numpad0, lang_get("key_numpad0"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad1, lang_get("key_numpad1"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad2, lang_get("key_numpad2"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad3, lang_get("key_numpad3"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad4, lang_get("key_numpad4"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad5, lang_get("key_numpad5"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad6, lang_get("key_numpad6"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad7, lang_get("key_numpad7"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad8, lang_get("key_numpad8"))
	ds_map_set(global.SpecialKeyNameMap, vk_numpad9, lang_get("key_numpad9"))
	ds_map_set(global.SpecialKeyNameMap, vk_multiply, lang_get("key_multiply"))
	ds_map_set(global.SpecialKeyNameMap, vk_divide, lang_get("key_divide"))
	ds_map_set(global.SpecialKeyNameMap, vk_add, lang_get("key_add"))
	ds_map_set(global.SpecialKeyNameMap, vk_subtract, lang_get("key_subtract"))
	ds_map_set(global.SpecialKeyNameMap, vk_decimal, lang_get("key_decimal"))
	ds_map_set(global.SpecialKeyNameMap, gp_face1, "A")
	ds_map_set(global.SpecialKeyNameMap, gp_face2, "B")
	ds_map_set(global.SpecialKeyNameMap, gp_face3, "X")
	ds_map_set(global.SpecialKeyNameMap, gp_face4, "Y")
	ds_map_set(global.SpecialKeyNameMap, gp_axislh, "LH")
	ds_map_set(global.SpecialKeyNameMap, gp_axislv, "LV")
	ds_map_set(global.SpecialKeyNameMap, gp_axisrh, "RH")
	ds_map_set(global.SpecialKeyNameMap, gp_axisrv, "RV")
	ds_map_set(global.SpecialKeyNameMap, gp_shoulderl, "L")
	ds_map_set(global.SpecialKeyNameMap, gp_shoulderlb, "ZL")
	ds_map_set(global.SpecialKeyNameMap, gp_shoulderr, "R")
	ds_map_set(global.SpecialKeyNameMap, gp_shoulderrb, "ZR")
	ds_map_set(global.SpecialKeyNameMap, gp_select, lang_get("key_select"))
	ds_map_set(global.SpecialKeyNameMap, gp_start, lang_get("key_start"))
	ds_map_set(global.SpecialKeyNameMap, gp_stickl, lang_get("key_stickl"))
	ds_map_set(global.SpecialKeyNameMap, gp_stickr, lang_get("key_stickr"))
	ds_map_set(global.SpecialKeyNameMap, gp_padu, lang_get("key_padup"))
	ds_map_set(global.SpecialKeyNameMap, gp_padl, lang_get("key_padleft"))
	ds_map_set(global.SpecialKeyNameMap, gp_padr, lang_get("key_padright"))
	ds_map_set(global.SpecialKeyNameMap, gp_padd, lang_get("key_paddown"))
	ds_map_set(global.SpecialKeyNameMap, vk_multiply, "*")
	ds_map_set(global.SpecialKeyNameMap, vk_add, "+")
	ds_map_set(global.SpecialKeyNameMap, vk_subtract, "-")
	ds_map_set(global.SpecialKeyNameMap, vk_decimal, ".")
	ds_map_set(global.SpecialKeyNameMap, vk_divide, "/")
	ds_map_set(global.SpecialKeyNameMap, 186, ";")
	ds_map_set(global.SpecialKeyNameMap, 187, "=")
	ds_map_set(global.SpecialKeyNameMap, 188, ",")
	ds_map_set(global.SpecialKeyNameMap, 189, "-")
	ds_map_set(global.SpecialKeyNameMap, 190, ".")
	ds_map_set(global.SpecialKeyNameMap, 191, "/")
	ds_map_set(global.SpecialKeyNameMap, 192, "`")
	ds_map_set(global.SpecialKeyNameMap, 219, "{")
	ds_map_set(global.SpecialKeyNameMap, 220, "\\")
	ds_map_set(global.SpecialKeyNameMap, 221, "]")
	ds_map_set(global.SpecialKeyNameMap, 222, "'")
	ds_map_set(global.SpecialKeyNameMap, -1, lang_get("key_presskey"))
}

function surface_prepare_aa_filter(arg0)
{
	var surf_tex = surface_get_texture(arg0)
	var tw = texture_get_texel_width(surf_tex)
	var th = texture_get_texel_height(surf_tex)
	shader_set(shd_pixelscale)
	gpu_set_texfilter(true)
	shader_set_uniform_f_array(uRes, sRes)
}

function calculate_letterbox_params()
{
	var res_w = window_get_width()
	var res_h = window_get_height()
	var res_scale = min(res_w / 16, res_h / 9)
	res_w = 16 * res_scale
	res_h = 9 * res_scale
	var screen_x = 0
	var screen_y = 0
	var scale_w = 1
	var scale_h = 1
	var scale = 1
	
	if (global.Letterbox && (res_w >= 960 && res_h >= 540))
	{
		var target_w = floor(res_w / 960)
		var target_h = floor(res_h / 540)
		var target_scale = min(target_w, target_h)
		scale_w = (target_scale * 960) / res_w
		scale_h = (target_scale * 540) / res_h
		scale = min(scale_w, scale_h)
		screen_x = (res_w - (target_scale * 960)) / 2
		screen_y = (res_h - (target_scale * 540)) / 2
		screen_x *= scale
		screen_y *= scale
	}
	
	return 
	{
		screen_x: screen_x,
		screen_y: screen_y,
		scale: scale,
		scale_w: scale_w,
		scale_h: scale_h
	};
}

function set_fullscreen_option(arg0)
{
	var previous_val = global.fullscreen
	global.fullscreen = arg0
	
	with (obj_screen)
		alarm[0] = 1
	
	option_create_confirm(previous_val, function(arg0)
	{
		quick_write_option("Settings", "fullscrn", global.fullscreen)
	}, function(arg0)
	{
		global.fullscreen = arg0
		
		with (obj_screen)
			alarm[0] = 1
	})
}

function p1Vibration(arg0, arg1)
{
	with (obj_inputController)
	{
		if (global.controllerVibration)
		{
			vibration1 = arg0 / 100
			vibrationDecay1 = arg1
		}
		else
		{
			vibration1 = 0
			vibrationDecay1 = 0
		}
	}
	
	gamepad_set_vibration(global.PlayerInputDevice, obj_inputController.vibration1, obj_inputController.vibration1)
}

function scr_initinput()
{
}

function scr_resetinput()
{
	var deadzoneSettings = []
	deadzoneSettings[Deadzones.Master] = ["deadzoneMaster", 0.4]
	deadzoneSettings[Deadzones.Vertical] = ["deadzoneVertical", 0.5]
	deadzoneSettings[Deadzones.Horizontal] = ["deadzoneHorizontal", 0.5]
	deadzoneSettings[Deadzones.Press] = ["deadzonePress", 0.5]
	deadzoneSettings[Deadzones.SJump] = ["deadzoneSJump", 0.8]
	deadzoneSettings[Deadzones.Crouch] = ["deadzoneCrouch", 0.65]
	ini_open("optionData.ini")
	ini_section_delete("Control")
	
	for (var i = 0; i < array_length(deadzoneSettings); i++)
	{
		var set = deadzoneSettings[i]
		ini_write_real("Settings", set[0], set[1])
		global.deadzones[i] = set[1]
	}
	
	ini_close()
	scr_input_create()
}

function scr_input_create()
{
	if (!variable_global_exists("input_map"))
		global.input_map = ds_map_create()
	
	if (!variable_global_exists("stickpressed"))
	{
		global.stickpressed = ds_map_create()
		var stickarr = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
		stickarr = array_concat(stickarr, stickarr)
		
		for (var i = 0; i < array_length(stickarr); i++)
		{
			var s = string(stickarr[i])
			
			if (i >= ((array_length(stickarr) / 2) - 1))
				s += "_inv"
			
			ds_map_set(global.stickpressed, s, false)
		}
	}
	
	ini_open("optionData.ini")
	scr_input_ini_read("up", false, [38])
	scr_input_ini_read("down", false, [40])
	scr_input_ini_read("left", false, [37])
	scr_input_ini_read("right", false, [39])
	scr_input_ini_read("jump", false, [90])
	scr_input_ini_read("slap", false, [88])
	scr_input_ini_read("taunt", false, [67])
	scr_input_ini_read("shoot", false, [65])
	scr_input_ini_read("attack", false, [16])
	scr_input_ini_read("superjump", false, [])
	scr_input_ini_read("groundpound", false, [])
	scr_input_ini_read("start", false, [27])
	scr_input_ini_read("special", false, [86])
	scr_input_ini_read("menuup", false, [38])
	scr_input_ini_read("menudown", false, [40])
	scr_input_ini_read("menuleft", false, [37])
	scr_input_ini_read("menuright", false, [39])
	scr_input_ini_read("menuconfirm", false, [90, 32])
	scr_input_ini_read("menuback", false, [88])
	scr_input_ini_read("menudelete", false, [67])
	scr_input_ini_read("upC", true, [gp_padu, gp_axislv], true, true)
	scr_input_ini_read("downC", true, [gp_padd, gp_axislv], true, false)
	scr_input_ini_read("leftC", true, [gp_padl, gp_axislh], true, true)
	scr_input_ini_read("rightC", true, [gp_padr, gp_axislh], true, false)
	scr_input_ini_read("jumpC", true, [gp_face1], true)
	scr_input_ini_read("slapC", true, [gp_face3], true)
	scr_input_ini_read("tauntC", true, [gp_face4], true)
	scr_input_ini_read("shootC", true, [gp_face2], true)
	scr_input_ini_read("attackC", true, [gp_shoulderr, gp_shoulderrb], true)
	scr_input_ini_read("superjumpC", true, [], true)
	scr_input_ini_read("groundpoundC", true, [], true)
	scr_input_ini_read("startC", true, [gp_start], true)
	scr_input_ini_read("specialC", true, [gp_shoulderlb], true)
	scr_input_ini_read("menuupC", true, [gp_padu, gp_axislv], true, true)
	scr_input_ini_read("menudownC", true, [gp_padd, gp_axislv], true, false)
	scr_input_ini_read("menuleftC", true, [gp_padl, gp_axislh], true, true)
	scr_input_ini_read("menurightC", true, [gp_padr, gp_axislh], true, false)
	scr_input_ini_read("menuconfirmC", true, [gp_face1], true)
	scr_input_ini_read("menubackC", true, [gp_face3, gp_face2], true)
	scr_input_ini_read("menudeleteC", true, [gp_face4], true)
	ini_close()
}

function input_get(arg0)
{
	return ds_map_find_value(global.input_map, arg0);
}

function input_save(arg0)
{
	var gpCheck = false
	var key = string_replace(arg0.name, "C", "")
	
	if (string_length(key) < string_length(arg0.name))
		gpCheck = true
	
	var str = ""
	
	if (!gpCheck)
	{
		for (var i = 0; i < array_length(arg0.keyInputs); i++)
		{
			if (str == "")
				str = arg0.keyInputs[i]
			else
				str = string_concat(str, ",", arg0.keyInputs[i])
		}
		
		arg0.keyLen = array_length(arg0.keyInputs)
	}
	else
	{
		for (var i = 0; i < array_length(arg0.gpInputs); i++)
		{
			if (str == "")
				str = arg0.gpInputs[i]
			else
				str = string_concat(str, ",", arg0.gpInputs[i])
		}
		
		arg0.gpLen = array_length(arg0.gpInputs)
	}
	
	trace(string("Trace input_save: {0} = {1}", arg0.name, str))
	ini_open("optionData.ini")
	ini_write_string("Control", arg0.name, str)
	ini_close()
}

function scr_input_add(arg0, arg1)
{
	arg1.keyLen = array_length(arg1.keyInputs)
	arg1.gpLen = array_length(arg1.gpInputs)
	ds_map_set(global.input_map, arg0, arg1)
}

function scr_input_ini_read(arg0, arg1, arg2, arg3 = false, arg4 = false)
{
	var _inp = ini_read_string("Control", arg0, "")
	var inputs = []
	var inputStrings = string_split(_inp, ",")
	
	if (_inp == "")
	{
		inputs = arg2
	}
	else
	{
		for (var i = 0; i < array_length(inputStrings); i++)
			array_push(inputs, real(inputStrings[i]))
	}
	
	show_debug_message(string("loaded input {0}: {1}", arg0, inputs))
	scr_input_add(arg0, new Input(arg0, arg1 ? [] : inputs, arg1 ? inputs : [], arg3, arg4))
}

function scr_setinput_init()
{
	ini_open("optionData.ini")
	global.deadzones[Deadzones.Master] = ini_read_real("Settings", "deadzoneMaster", 0.4)
	global.deadzones[Deadzones.Vertical] = ini_read_real("Settings", "deadzoneVertical", 0.5)
	global.deadzones[Deadzones.Horizontal] = ini_read_real("Settings", "deadzoneHorizontal", 0.5)
	global.deadzones[Deadzones.Press] = ini_read_real("Settings", "deadzonePress", 0.5)
	global.deadzones[Deadzones.SJump] = ini_read_real("Settings", "deadzoneSJump", 0.8)
	global.deadzones[Deadzones.Crouch] = ini_read_real("Settings", "deadzoneCrouch", 0.65)
	ini_close()
	scr_input_init_sprites()
}

function scr_gpinput_isaxis(arg0)
{
	var axes = [gp_axisrh, gp_axisrv, gp_axislv, gp_axislh]
	
	if (array_contains(axes, arg0))
		return true;
	
	return false;
}

function scr_input_update(arg0 = -1)
{
	var dz = global.deadzones[Deadzones.Master]
	gamepad_set_axis_deadzone(arg0, dz)
	var keys = ds_map_keys_to_array(global.input_map)
	
	for (var i = 0; i < array_length(keys); i++)
		ds_map_find_value(global.input_map, array_get(keys, i)).update(object_index)
	
	scr_input_stickpressed_update()
}

function scr_input_stickpressed(arg0)
{
	var s = string(arg0)
	return ds_map_find_value(global.stickpressed, s) == StickPressed.Pressed;
}

function scr_input_stickpressed_update(arg0 = global.PlayerInputDevice, arg1 = global.deadzones[Deadzones.Master])
{
	var sticks = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
	sticks = array_concat(sticks, sticks)
	
	for (var i = 0; i < array_length(sticks); i++)
	{
		var s = string(sticks[i])
		var inv = false
		
		if (i >= ((array_length(sticks) / 2) - 1))
		{
			s += "_inv"
			inv = true
		}
		
		var val = gamepad_axis_value(arg0, sticks[i])
		var pressState = ds_map_find_value(global.stickpressed, s)
		
		if (pressState == StickPressed.Pressed && !((!inv && val >= arg1) || (inv && val <= -arg1)))
			ds_map_set(global.stickpressed, s, StickPressed.Released)
		
		if (pressState == StickPressed.JustPressed)
			ds_map_set(global.stickpressed, s, StickPressed.Pressed)
	}
}

function scr_checkdeadzone(arg0, arg1, arg2)
{
	var dz = global.deadzones[Deadzones.Press]
	
	switch (arg0)
	{
		case gp_axislh:
		case gp_axisrh:
			dz = global.deadzones[Deadzones.Horizontal]
			break
		
		case gp_axislv:
		case gp_axisrv:
			dz = global.deadzones[Deadzones.Vertical]
			break
	}
	
	if (arg2.object_index == obj_parent_player)
	{
		switch (arg1)
		{
			case "upC":
				if (arg2.state == PlayerState.Sjumpprep)
					dz = global.deadzones[Deadzones.SJump]
				
				break
			
			case "downC":
				if (arg2.state == PlayerState.crouch)
					dz = global.deadzones[Deadzones.Crouch]
				
				break
		}
	}
	
	return dz;
}

function Input(arg0, arg1, arg2, arg3 = 0, arg4 = false) constructor
{
	static update = function(arg0)
	{
		if (global.PlayerInputDevice < 0)
		{
			checkheld(arg0)
			checkpressed(arg0)
			checkreleased(arg0)
		}
		else
		{
			checkheldC(arg0)
			checkpressedC(arg0)
			checkreleasedC(arg0)
		}
	}
	
	static checkheld = function(arg0)
	{
		for (var i = 0; i < keyLen; i++)
		{
			if (keyboard_check(keyInputs[i]))
			{
				held = true
				exit
			}
		}
		
		held = false
	}
	
	static checkheldC = function(arg0)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var dz = scr_checkdeadzone(gpInputs[i], name, arg0)
				
				if ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz))
				{
					held = true
					exit
				}
			}
			else if (gamepad_button_check(global.PlayerInputDevice, gpInputs[i]))
			{
				held = true
				exit
			}
		}
		
		held = false
	}
	
	static checkpressed = function(arg0)
	{
		for (var i = 0; i < keyLen; i++)
		{
			if (global.PlayerInputDevice != -1)
				break
			
			if (keyboard_check_pressed(keyInputs[i]))
			{
				pressed = true
				exit
			}
		}
		
		pressed = false
	}
	
	static checkpressedC = function(arg0)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var stickstr = string(gpInputs[i])
				
				if (gpAxisInvert)
					stickstr += "_inv"
				
				var dz = scr_checkdeadzone(gpInputs[i], name, arg0)
				
				if (!scr_input_stickpressed(stickstr) && ((!gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= -dz)))
				{
					pressed = true
					ds_map_set(global.stickpressed, stickstr, StickPressed.JustPressed)
					exit
				}
			}
			else if (gamepad_button_check_pressed(global.PlayerInputDevice, gpInputs[i]))
			{
				pressed = true
				exit
			}
		}
		
		pressed = false
	}
	
	static checkreleased = function(arg0)
	{
		for (var i = 0; i < keyLen; i++)
		{
			if (keyboard_check_released(keyInputs[i]))
			{
				released = true
				exit
			}
		}
		
		released = false
	}
	
	static checkreleasedC = function(arg0)
	{
		for (var i = 0; i < gpLen; i++)
		{
			if (scr_gpinput_isaxis(gpInputs[i]))
			{
				var stickstr = string(gpInputs[i])
				
				if (gpAxisInvert)
					stickstr += "_inv"
				
				var dz = scr_checkdeadzone(gpInputs[i], name, arg0)
				
				if ((!gpAxisInvert && !scr_input_stickpressed(stickstr) && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) <= dz) || (gpAxisInvert && gamepad_axis_value(global.PlayerInputDevice, gpInputs[i]) >= -dz))
				{
					released = true
					exit
				}
			}
			else if (gamepad_button_check_released(global.PlayerInputDevice, gpInputs[i]))
			{
				released = true
				exit
			}
		}
		
		released = false
	}
	
	static clear_input = function()
	{
		held = false
		pressed = false
		released = false
		return self;
	}
	
	name = arg0
	held = false
	pressed = false
	released = false
	keyInputs = arg1
	gpInputs = arg2
	gpInputDeadzone = arg3
	gpAxisInvert = arg4
	stickpressed = false
	keyLen = 0
	gpLen = 0
}

function scr_slope(arg0 = false)
{
	return scr_slope_ext(x, y + 1, arg0);
}

function scr_slope_ext(arg0, arg1, arg2 = false)
{
	return place_meeting_slope(arg0, arg1, !arg2);
}

function scr_solid_slope(arg0, arg1)
{
	place_meeting_slopeSolid(arg0, arg1)
}

function slopeCheck(arg0, arg1)
{
	return scr_slope_ext(arg0, arg1 + 1) && !scr_solid_slope(arg0, arg1 + 1) && !scr_solid_slope(arg0, arg1) && scr_slope_ext(arg0, (arg1 - bbox_top) + bbox_bottom);
}

function scr_slopePlatform(arg0, arg1)
{
	place_meeting_slopePlatform(arg0, arg1)
}

function slopeMomentum_acceleration()
{
	if (place_meeting_slope(x, y + 1, false))
	{
		with (instance_place(x, y + 1, obj_slope))
		{
			var slope_acceleration = abs(image_yscale) / abs(image_xscale)
			
			if (sign(image_xscale) >= 1)
				return -slope_acceleration;
			else
				return slope_acceleration;
		}
	}
	
	if (place_meeting_slopePlatform(x, y + 1))
	{
		with (instance_place(x, y + 1, obj_slopePlatform))
		{
			var slope_acceleration = abs(image_yscale) / abs(image_xscale)
			
			if (sign(image_xscale) >= 1)
				return -slope_acceleration;
			else
				return slope_acceleration;
		}
	}
}

function slopeMomentum_direction()
{
	if (place_meeting_slope(x, y + 1, false))
	{
		with (instance_place(x, y + 1, obj_slope))
			return sign(image_xscale);
	}
	
	if (place_meeting_slopePlatform(x, y + 1))
	{
		with (instance_place(x, y + 1, obj_slopePlatform))
			return sign(image_xscale);
	}
	
	return -1;
}

function player_slopeMomentum(arg0, arg1 = 0)
{
	var inst = instance_place(x, y + 1, obj_slopePlatform)
	
	if (instance_place(x, y + 1, obj_slope) != -4)
		inst = instance_place(x, y + 1, obj_slope)
	
	if (groundedSlope && inst != -4)
	{
		var _xscale = sign(inst.image_xscale)
		var slope_acceleration = abs(inst.image_yscale) / abs(inst.image_xscale)
		
		if (sign(image_xscale) == _xscale)
			movespeed -= (arg1 * slope_acceleration)
		else
			movespeed += (arg0 * slope_acceleration)
	}
}

function scr_slopeanglenonplayer(arg0, arg1, arg2 = 1)
{
	var array = 0
	var checkside = -1
	var height = sprite_get_bbox_bottom(mask_index) - sprite_get_bbox_top(mask_index)
	var top = -4
	var i = 0
	array[0] = arg1
	array[1] = arg1
	
	var _function = function(arg0, arg1)
	{
		return scr_solid(arg0, arg1) || (scr_slope_ext(arg0, arg1) && scr_slopePlatform(arg0, arg1));
	}
	
	while (i < 2)
	{
		while (top < height)
		{
			array[i] = arg1
			var check_1 = _function(arg0 + (arg2 * checkside), arg1 + top)
			var check_2 = !_function(arg0 + (arg2 * checkside), (arg1 + top) - 1)
			
			if (check_1 && check_2)
			{
				var sex = (arg1 + top) - 1
				array[i] = sex
				break
			}
			
			top++
		}
		
		checkside = !checkside
		i++
	}
	
	var pointer1 = array[0]
	var pointer2 = array[1]
	var _angle = 0
	
	if (pointer1 != pointer2)
		_angle = point_direction(arg0 - arg2, pointer1, arg0 + arg2, pointer2)
	
	return _angle;
}

function scr_checkSlopeAngle()
{
	return scr_checkPositionSolidAngle(x, bbox_bottom, abs(x - bbox_left), abs(x - bbox_right) - 1, (bbox_bottom - bbox_top) / 2, -90, undefined, true);
}

function face_obj(arg0)
{
	var dir = sign(arg0.x - x)
	
	if (dir == 0)
		dir = 1
	
	return dir;
}

function fmod_init(arg0, arg1 = FMOD_INIT.NORMAL, arg2 = FMOD_STUDIO_INIT.NORMAL)
{
	return fmod_studio_system_init(arg0, arg1, arg2);
}

function fmod_loadBank(arg0, arg1 = FMOD_STUDIO_LOAD_BANK.NORMAL)
{
	return fmod_studio_system_load_bank_file(arg0, arg1);
}

function fmod_createEventInstance(arg0)
{
	var event_description = fmod_studio_system_get_event(arg0)
	var event_instance = fmod_studio_event_description_create_instance(event_description)
	array_push(global.FMOD_EventInstances, [event_instance, fmod_studio_event_description_get_path(event_description)])
	return event_instance;
}

function fmod_event_getParameter(arg0, arg1)
{
	var param = fmod_studio_event_instance_get_parameter_by_name(arg0, arg1)
	return param.value;
}

function fmod_event_set3DPosition(arg0, arg1, arg2, arg3 = 0)
{
	var attributes = global.FMOD_default3DAttributes
	attributes.position = 
	{
		x: arg1,
		y: arg2,
		z: arg3
	}
	fmod_studio_event_instance_set_3d_attributes(arg0, attributes)
}

function fmod_global_getParameter(arg0)
{
	var param = fmod_studio_system_get_parameter_by_name(arg0)
	return param.value;
}

function fmod_getEventLength(arg0)
{
	var event_description = fmod_studio_system_get_event(arg0)
	return fmod_studio_event_description_get_length(event_description);
}

function fmod_event_setPause_all(arg0)
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_set_paused(global.FMOD_EventInstances[i][0], arg0)
	}
}

function fmod_event_release_all()
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_release(global.FMOD_EventInstances[i][0])
	}
}

function fmod_event_stop_all(arg0)
{
	for (var i = 0; i < array_length(global.FMOD_EventInstances); i++)
	{
		if (fmod_studio_event_instance_is_valid(global.FMOD_EventInstances[i][0]))
			fmod_studio_event_instance_stop(global.FMOD_EventInstances[i][0], arg0)
	}
}

function fmod_event_getEventPath(arg0)
{
	var event_description = fmod_studio_event_instance_get_description(arg0)
	return fmod_studio_event_description_get_path(event_description);
}

function instance_create(arg0, arg1, arg2, arg3 = {})
{
	var inst = instance_create_depth(arg0, arg1, 0, arg2, arg3);
    
    if (instance_exists(obj_fakeeditor))
    {
        with (obj_fakeeditor)
        {
            if (in_play_mode)
            {
                instances[instances_len] = inst;
                instances_len++;
            }
        }
    }
    
    return inst;
    
}

function scr_queueTVAnimation(arg0, arg1 = 150)
{
	with (obj_hudManager.HUDObject_TV)
	{
		var roomname = room_get_name(room)
		
		if (arg0 == global.TvSprPlayer_Secret && instance_exists(obj_secretfound))
			exit
		
		if (tvExpressionSprite != arg0)
			tvForceTransition = true
		
		tvExpressionSprite = arg0
		tvExpressionBuffer = arg1
		var vocal_collectables = [spr_tvHUD_confecti1, spr_tvHUD_confecti2, spr_tvHUD_confecti3, spr_tvHUD_confecti4, spr_tvHUD_confecti5, spr_tvHUD_janitorLap, spr_tvHUD_janitorTreasure, global.TvSprPlayer_KeyGot, global.TvSprPlayer_Happy]
		
		if (chance(50) && array_contains(vocal_collectables, arg0))
			fmod_studio_event_instance_start(get_primaryPlayer().voiceCollect)
	}
}

function scr_queueToolTipPrompt(arg0 = "", arg1 = 220)
{
	with (obj_hudManager)
	{
		global.TooltipPrompt = arg0
		HUDObject_tooltipPrompts.promptTimer = arg1
	}
	
	return arg1;
}

function scr_sleep(arg0 = undefined)
{
	with (obj_camera)
	{
		if (global.hitstunalarm <= -1 && !global.freezeframe)
		{
			if (is_undefined(arg0))
			{
				freezetype = false
			}
			else
			{
				freezeval = arg0
				freezetype = true
			}
			
			NextFreeze = true
		}
	}
}

function scr_sleep_ext(arg0)
{
	var time = current_time
	var ms = arg0
	
	do
	{
	}
	until ((current_time - time) >= round(ms))
	
	return current_time - time;
}

function in_saveroom(_id = id, _map = global.SaveRoom)
{
	if !is_string(_id) && variable_instance_exists(_id, "ID")
		_id = _id.ID;
	return ds_list_find_index(_map, _id) > -1;
}

function add_saveroom(_id = id, _map = global.SaveRoom)
{
	if !is_string(_id) && variable_instance_exists(_id, "ID")
		_id = _id.ID;
	ds_list_add(_map, _id);
}

function in_baddieroom(_id = id)
{
	return in_saveroom(_id, global.BaddieRoom);
}

function add_baddieroom(_id = id)
{
	add_saveroom(_id, global.BaddieRoom);
}

function in_escaperoom(_id = id)
{
	return in_saveroom(_id, global.EscapeRoom);
}

function add_escaperoom(_id = id)
{
	add_saveroom(_id, global.EscapeRoom);
}

function scr_secrettiles_add(arg0)
{
	if (object_index != obj_secretwall)
		return false;
	
	if (is_undefined(arg0))
		return false;
	
	for (var i = 0; i < argument_count; i++)
	{
		var arg = argument[i]
		var layer_id = layer_get_id(arg)
		layer_set_visible(layer_id, false)
		array_push(layerArray, layer_id)
	}
	
	var func = function(arg0, arg1)
	{
		return layer_get_depth(arg1) - layer_get_depth(arg0);
	}
	
	array_sort(layerArray, func)
	return true;
}

function add_secrettiles(arg0)
{
	global.secret_layers = []
	
	for (var i = 0; i < argument_count; i++)
	{
		var arg = argument[i]
		var layerid = layer_get_id(arg)
		layer_set_visible(layerid, false)
		var name = layer_get_name(layerid)
		
		if (layer_exists(argument[i]))
		{
			array_push(global.secret_layers, 
			{
				nm: name,
				id: layerid,
				alpha: 1,
				surf: -4
			})
		}
	}
	
	var _f = function(arg0, arg1)
	{
		return -(layer_get_depth(arg0.nm) - layer_get_depth(arg1.nm));
	}
	
	array_sort(global.secret_layers, _f)
	return true;
}

function scr_saveinit()
{
	video_close()
	ini_open(global.SaveFileName)
	global.SaveSeconds = ini_read_real("Game", "seconds", 0)
	global.SaveMinutes = ini_read_real("Game", "minutes", 0)
	global.HurtCounter = ini_read_real("Game", string("damage_{0}", scr_getCharacterPrefix(Characters.Pizzelle)), 0)
	global.HurtMilestone = global.HurtCounter
	global.PlayerPaletteIndex = ini_read_real("Misc", string("playerPaletteIndex_{0}", scr_getCharacterPrefix(Characters.Pizzelle)), 2)
	global.GLOBAL_FUN = ini_read_real("Game", "FUN", -4)
	
	if (global.GLOBAL_FUN <= -4)
	{
		global.GLOBAL_FUN = irandom_range(0, 100)
		ini_write_real("Game", "FUN", global.GLOBAL_FUN)
	}
	
	var cur_version = ini_read_real("SaveFormat", "version", 0)
	
	if (cur_version > 1)
		show_debug_message(string("WARNING: {0} Version: {1} is higher than game's expected {2} version: {3}. Tomfoolery afoot.", global.SaveFileName, cur_version, global.SaveFileName, 1))
	
	if (!ini_section_exists("SaveFormat") || !ini_key_exists("SaveFormat", "version") || cur_version < 1)
	{
		show_debug_message(string("ALERT: Updating {0} version... {1} to {2}", global.SaveFileName, cur_version, 1))
		ini_write_real("SaveFormat", "version", 1)
	}
	
	ini_close()
	
	with (obj_achievementTracker)
		event_user(0)
}

function get_control_string(arg0)
{
	switch (arg0)
	{
		default:
			return "[unknown]";
			break
		
		case 27:
			return "Escape";
			break
		
		case 112:
			return "F1";
			break
		
		case 113:
			return "F2";
			break
		
		case 114:
			return "F3";
			break
		
		case 115:
			return "F4";
			break
		
		case 116:
			return "F5";
			break
		
		case 117:
			return "F6";
			break
		
		case 118:
			return "F7";
			break
		
		case 119:
			return "F8";
			break
		
		case 120:
			return "F9";
			break
		
		case 121:
			return "F10";
			break
		
		case 122:
			return "F11";
			break
		
		case 123:
			return "F12";
			break
		
		case 44:
			return "Print Screen";
			break
		
		case 19:
			return "Pause";
			break
		
		case 49:
			return "[1]";
			break
		
		case 50:
			return "[2]";
			break
		
		case 51:
			return "[3]";
			break
		
		case 52:
			return "[4]";
			break
		
		case 53:
			return "[5]";
			break
		
		case 54:
			return "[6]";
			break
		
		case 55:
			return "[7]";
			break
		
		case 56:
			return "[8]";
			break
		
		case 57:
			return "[9]";
			break
		
		case 48:
			return "[0]";
			break
		
		case 8:
			return "Backspace";
			break
		
		case 45:
			return "Insert";
			break
		
		case 36:
			return "Home";
			break
		
		case 33:
			return "Page Up";
			break
		
		case 9:
			return "Tab";
			break
		
		case 81:
			return "Q";
			break
		
		case 87:
			return "W";
			break
		
		case 69:
			return "E";
			break
		
		case 82:
			return "R";
			break
		
		case 84:
			return "T";
			break
		
		case 89:
			return "Y";
			break
		
		case 85:
			return "U";
			break
		
		case 73:
			return "I";
			break
		
		case 79:
			return "O";
			break
		
		case 80:
			return "P";
			break
		
		case 35:
			return "End";
			break
		
		case 34:
			return "Page Down";
			break
		
		case 103:
			return "Num 7";
			break
		
		case 104:
			return "Num 8";
			break
		
		case 105:
			return "Num 9";
			break
		
		case 43:
			return "[+]";
			break
		
		case 65:
			return "A";
			break
		
		case 83:
			return "S";
			break
		
		case 68:
			return "D";
			break
		
		case 70:
			return "F";
			break
		
		case 71:
			return "G";
			break
		
		case 72:
			return "H";
			break
		
		case 74:
			return "J";
			break
		
		case 75:
			return "K";
			break
		
		case 76:
			return "L";
			break
		
		case 13:
			return "Enter";
			break
		
		case 100:
			return "Num 4";
			break
		
		case 101:
			return "Num 5";
			break
		
		case 102:
			return "Num 6";
			break
		
		case 16:
			return "$";
			break
		
		case 90:
			return "Z";
			break
		
		case 88:
			return "X";
			break
		
		case 67:
			return "C";
			break
		
		case 86:
			return "V";
			break
		
		case 66:
			return "B";
			break
		
		case 78:
			return "N";
			break
		
		case 77:
			return "M";
			break
		
		case 38:
			return "&";
			break
		
		case 97:
			return "Num 1";
			break
		
		case 98:
			return "Num 2";
			break
		
		case 99:
			return "Num 3";
			break
		
		case 17:
			return "/";
			break
		
		case 18:
			return "Alt";
			break
		
		case 32:
			return "%";
			break
		
		case 37:
			return ")";
			break
		
		case 39:
			return "*";
			break
		
		case 40:
			return "(";
			break
		
		case 96:
			return "Num 0";
			break
	}
}

function get_control_string_npc(arg0)
{
	switch (arg0)
	{
		default:
			return "[unknown]";
			break
		
		case 27:
			return "Escape";
			break
		
		case 112:
			return "F1";
			break
		
		case 113:
			return "F2";
			break
		
		case 114:
			return "F3";
			break
		
		case 115:
			return "F4";
			break
		
		case 116:
			return "F5";
			break
		
		case 117:
			return "F6";
			break
		
		case 118:
			return "F7";
			break
		
		case 119:
			return "F8";
			break
		
		case 120:
			return "F9";
			break
		
		case 121:
			return "F10";
			break
		
		case 122:
			return "F11";
			break
		
		case 123:
			return "F12";
			break
		
		case 44:
			return "Print Screen";
			break
		
		case 19:
			return "Pause";
			break
		
		case 49:
			return "[1]";
			break
		
		case 50:
			return "[2]";
			break
		
		case 51:
			return "[3]";
			break
		
		case 52:
			return "[4]";
			break
		
		case 53:
			return "[5]";
			break
		
		case 54:
			return "[6]";
			break
		
		case 55:
			return "[7]";
			break
		
		case 56:
			return "[8]";
			break
		
		case 57:
			return "[9]";
			break
		
		case 48:
			return "[0]";
			break
		
		case 8:
			return "Backspace";
			break
		
		case 45:
			return "Insert";
			break
		
		case 36:
			return "Home";
			break
		
		case 33:
			return "Page Up";
			break
		
		case 9:
			return "Tab";
			break
		
		case 81:
			return "Q";
			break
		
		case 87:
			return "W";
			break
		
		case 69:
			return "E";
			break
		
		case 82:
			return "R";
			break
		
		case 84:
			return "T";
			break
		
		case 89:
			return "Y";
			break
		
		case 85:
			return "U";
			break
		
		case 73:
			return "I";
			break
		
		case 79:
			return "O";
			break
		
		case 80:
			return "P";
			break
		
		case 35:
			return "End";
			break
		
		case 34:
			return "Page Down";
			break
		
		case 103:
			return "Num 7";
			break
		
		case 104:
			return "Num 8";
			break
		
		case 105:
			return "Num 9";
			break
		
		case 43:
			return "[+]";
			break
		
		case 65:
			return "A";
			break
		
		case 83:
			return "S";
			break
		
		case 68:
			return "D";
			break
		
		case 70:
			return "F";
			break
		
		case 71:
			return "G";
			break
		
		case 72:
			return "H";
			break
		
		case 74:
			return "J";
			break
		
		case 75:
			return "K";
			break
		
		case 76:
			return "L";
			break
		
		case 13:
			return "Enter";
			break
		
		case 100:
			return "Num 4";
			break
		
		case 101:
			return "Num 5";
			break
		
		case 102:
			return "Num 6";
			break
		
		case 16:
			return "Shift";
			break
		
		case 90:
			return "Z";
			break
		
		case 88:
			return "X";
			break
		
		case 67:
			return "C";
			break
		
		case 86:
			return "V";
			break
		
		case 66:
			return "B";
			break
		
		case 78:
			return "N";
			break
		
		case 77:
			return "M";
			break
		
		case 38:
			return "Up Arrow";
			break
		
		case 97:
			return "Num 1";
			break
		
		case 98:
			return "Num 2";
			break
		
		case 99:
			return "Num 3";
			break
		
		case 17:
			return "Control";
			break
		
		case 18:
			return "Alt";
			break
		
		case 32:
			return "Spacebar";
			break
		
		case 37:
			return "Left Arrow";
			break
		
		case 39:
			return "Right Arrow";
			break
		
		case 40:
			return "Down Arrow";
			break
		
		case 96:
			return "Num 0";
			break
	}
}

function scr_destroy_tile(arg0)
{
	var lay_id = layer_get_id(arg0)
	var map_id = layer_tilemap_get_id_fixed(lay_id)
	
	for (var i = 0; i < floor(sprite_width / tilemap_get_tile_width(map_id)); i++)
	{
		for (var z = 0; z < floor(sprite_height / tilemap_get_tile_height(map_id)); z++)
		{
			var data = tilemap_get_at_pixel(map_id, x + (i * tilemap_get_tile_width(map_id)) + 1, y + (z * tilemap_get_tile_height(map_id)) + 1)
			data = tile_set_empty(data)
			tilemap_set_at_pixel(map_id, data, x + (i * tilemap_get_tile_width(map_id)) + 1, y + (z * tilemap_get_tile_height(map_id)) + 1)
		}
	}
}

function scr_destroy_nearby_tiles()
{
	instance_destroy(instance_place(x + 1, y, obj_tiledestroyOLD))
	instance_destroy(instance_place(x - 1, y, obj_tiledestroyOLD))
	instance_destroy(instance_place(x, y + 1, obj_tiledestroyOLD))
	instance_destroy(instance_place(x, y - 1, obj_tiledestroyOLD))
	instance_destroy(instance_place(x + 1, y, obj_secretTileDestroy))
	instance_destroy(instance_place(x - 1, y, obj_secretTileDestroy))
	instance_destroy(instance_place(x, y + 1, obj_secretTileDestroy))
	instance_destroy(instance_place(x, y - 1, obj_secretTileDestroy))
	
	with (obj_secret_cutoff)
		alarm[0] = 1
}

function manage_up_arrow(arg0)
{
	if (!variable_instance_exists(self, "script_UpArrow"))
		script_UpArrow = -4
	
	if (arg0)
	{
		if (!instance_exists(script_UpArrow))
		{
			script_UpArrow = instance_create(obj_parent_player.x, obj_parent_player.y, obj_uparrow)
			script_UpArrow.manual = true
		}
	}
	else if (instance_exists(script_UpArrow))
	{
		instance_destroy(script_UpArrow)
	}
	
	if (!instance_exists(script_UpArrow))
		return -4;
	
	return script_UpArrow;
}

function particle_spawn_dustTrail(arg0 = 15)
{
	create_particle(x, y, spr_cloudEffect, arg0)
}

function event_instance_isplaying(arg0)
{
	return fmod_studio_event_instance_get_playback_state(arg0) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING;
}

function event_instance_exists(arg0)
{
	return fmod_studio_event_description_get_instance_count(arg0) > 0;
}

function event_play_oneshot(arg0 = "", arg1 = undefined, arg2 = undefined, arg3 = 0)
{
	var _id = fmod_createEventInstance(arg0)
	fmod_studio_event_instance_start(_id)
	
	if (!is_undefined(arg1) && !is_undefined(arg2))
		fmod_event_set3DPosition(_id, arg1, arg2, arg3)
	
	fmod_studio_event_instance_release(_id)
	return _id;
}

function event_play_oneshot_ext(arg0 = "", arg1 = undefined, arg2 = undefined, arg3 = 0)
{
	var _id = fmod_createEventInstance(arg0)
	fmod_studio_event_instance_start(_id)
	
	if (!is_undefined(arg1) && !is_undefined(arg2))
		fmod_event_set3DPosition(_id, arg1, arg2, arg3)
	
	ds_list_add(global.FMOD_OneShotList, 
	{
		id: _id,
		name: arg0,
		one_shot: true
	})
	return _id;
}

function event_play_multiple(arg0 = "", arg1 = undefined, arg2 = undefined, arg3 = 0)
{
	event_play_oneshot(arg0, arg1, arg2, arg3)
}

function fmod_quick3D(arg0, arg1 = x, arg2 = y, arg3 = 0)
{
	if (event_instance_isplaying(arg0))
		fmod_event_set3DPosition(arg0, arg1, arg2, arg3)
}

function kill_sounds(arg0)
{
	if (is_array(arg0))
	{
		for (var i = 0; i < array_length(arg0); i++)
		{
			var snd = arg0[i]
			fmod_studio_event_instance_stop(snd, true)
			fmod_studio_event_instance_release(snd)
		}
	}
	else
	{
		fmod_studio_event_instance_stop(arg0, true)
		fmod_studio_event_instance_release(arg0)
	}
}

function kill_sound_list(arg0)
{
	if (is_array(arg0))
	{
		for (var i = 0; i < array_length(arg0); i++)
		{
			var snd_id = arg0[i]
			
			for (var p = 0; p < ds_list_size(global.FMOD_OneShotList); p++)
			{
				var entry = ds_list_find_value(global.FMOD_OneShotList, p)
				
				if (entry != -4 && !is_undefined(entry) && entry.id == snd_id)
				{
					kill_sounds(snd_id)
					ds_list_delete(global.FMOD_OneShotList, p)
					p--
				}
			}
		}
	}
	else
	{
		var snd_id = arg0
		
		for (var p = 0; p < ds_list_size(global.FMOD_OneShotList); p++)
		{
			var entry = ds_list_find_value(global.FMOD_OneShotList, p)
			
			if (entry != -4 && !is_undefined(entry) && entry.id == snd_id)
			{
				kill_sounds(snd_id)
				ds_list_delete(global.FMOD_OneShotList, p)
			}
		}
	}
}

function set_volume_options(arg0 = global.masterVolume, arg1 = global.musicVolume, arg2 = global.soundVolume)
{
	fmod_studio_system_set_parameter_by_name("masterVolume", arg0, true)
	fmod_studio_system_set_parameter_by_name("musicVolume", arg1, true)
	fmod_studio_system_set_parameter_by_name("sfxVolume", arg2, true)
}

function stop_music(arg0 = true)
{
	if (!is_undefined(global.RoomMusic))
	{
		fmod_studio_event_instance_stop(global.RoomMusic.musicInst, arg0)
		fmod_studio_event_instance_stop(global.RoomMusic.secretMusicInst, arg0)
	}
	
	fmod_studio_event_instance_stop(global.HarryMusicInst, arg0)
	fmod_studio_event_instance_stop(global.EscapeMusicInst, arg0)
}

function floor_ext(arg0, arg1)
{
	return floor(arg0 * arg1) / arg1;
}

function ceil_ext(arg0, arg1)
{
	return ceil(arg0 * arg1) / arg1;
}

function round_ext(arg0, arg1)
{
	return round(arg0 * arg1) / arg1;
}

function scr_shell_openconsole()
{
	global.shellactivate = true
}

function scr_shell_closeconsole()
{
	if (instance_exists(obj_pause))
	{
		obj_pause.canmove = false
		obj_pause.alarm[0] = 3
		obj_pause.key_jump = false
	}
	
	if (instance_exists(obj_mainfileselect))
	{
		obj_mainfileselect.abletomove = false
		obj_mainfileselect.alarm[0] = 3
	}
	
	global.shellactivate = false
}

function scr_shell_roomstart()
{
	toggle_collision_function()
	show_tiles_function()
}

function pal_swap_draw_palette(arg0, arg1, arg2, arg3)
{
	draw_sprite_part(arg0, 0, floor(arg1), 0, 1, sprite_get_height(arg0), arg2, arg3)
}

function pal_swap_get_color_count(arg0)
{
	return sprite_get_height(arg0);
}

function pal_swap_get_pal_count(arg0)
{
	return sprite_get_width(arg0);
}

function pal_swap_init_system(arg0, arg1, arg2)
{
	var swapper = 
	{
		shader: -4,
		html5: false,
		html5_sprite: -4,
		html5_surface: -4,
		texel_size: [0],
		uvs: [0],
		index: [0],
		texture: [0],
		layer_priority: 0,
		layer_temp_priority: 0,
		layer_map: 0,
		
		cleanup: function()
		{
			ds_priority_destroy(layer_priority)
			ds_priority_destroy(layer_temp_priority)
			ds_map_destroy(layer_map)
		}
	}
	swapper.html5 = false
	
	if (!swapper.html5)
	{
		swapper.shader = arg0
		swapper.texel_size[0] = shader_get_uniform(arg0, "u_pixelSize")
		swapper.uvs[0] = shader_get_uniform(arg0, "u_Uvs")
		swapper.index[0] = shader_get_uniform(arg0, "u_paletteId")
		swapper.texture[0] = shader_get_sampler_index(arg0, "u_palTexture")
	}
	else
	{
		if (arg1 == undefined || arg2 == undefined)
		{
			show_message("Must provide pal_swap_init_system() with 2 additional arguments for HTML5 Compatible Sprite and Surface Shaders")
			game_end()
		}
		
		swapper.html5_sprite = arg1
		swapper.html5_surface = arg2
		swapper.texel_size[1] = shader_get_uniform(arg1, "u_pixelSize")
		swapper.uvs[1] = shader_get_uniform(arg1, "u_Uvs")
		swapper.index[1] = shader_get_uniform(arg1, "u_paletteId")
		swapper.texture[1] = shader_get_sampler_index(arg1, "u_palTexture")
		swapper.texel_size[2] = shader_get_uniform(arg2, "u_pixelSize")
		swapper.uvs[2] = shader_get_uniform(arg2, "u_Uvs")
		swapper.index[2] = shader_get_uniform(arg2, "u_paletteId")
		swapper.texture[2] = shader_get_sampler_index(arg2, "u_palTexture")
	}
	
	swapper.layer_priority = ds_priority_create()
	swapper.layer_temp_priority = ds_priority_create()
	swapper.layer_map = ds_map_create()
	global.retro_pal_swapper = swapper
}

function pal_swap_set(arg0, arg1, arg2)
{
	var swapper = global.retro_pal_swapper
	
	if (arg1 == 0)
		exit
	
	var mode = 0
	
	if (!arg2)
	{
		if (swapper.html5)
		{
			shader_set(swapper.html5_sprite)
			mode = 1
		}
		else
		{
			shader_set(swapper.shader)
		}
		
		var tex = sprite_get_texture(arg0, 0)
		var UVs = sprite_get_uvs(arg0, 0)
		texture_set_stage(swapper.texture[mode], tex)
		var texel_x = texture_get_texel_width(tex)
		var texel_y = texture_get_texel_height(tex)
		var texel_hx = texel_x * 0.5
		var texel_hy = texel_y * 0.5
		shader_set_uniform_f(swapper.texel_size[mode], texel_x, texel_y)
		shader_set_uniform_f(swapper.uvs[mode], UVs[0] + texel_hx, UVs[1] + texel_hy, UVs[2], UVs[3])
		shader_set_uniform_f(swapper.index[mode], arg1)
	}
	else
	{
		if (swapper.html5)
		{
			shader_set(swapper.html5_surface)
			mode = 2
		}
		else
		{
			shader_set(swapper.shader)
		}
		
		var tex = surface_get_texture(arg0)
		texture_set_stage(swapper.texture[mode], tex)
		var texel_x = texture_get_texel_width(tex)
		var texel_y = texture_get_texel_height(tex)
		var texel_hx = texel_x * 0.5
		var texel_hy = texel_y * 0.5
		shader_set_uniform_f(swapper.texel_size[mode], texel_x, texel_y)
		shader_set_uniform_f(swapper.uvs[mode], texel_hx, texel_hy, 1 + texel_hx, 1 + texel_hy)
		shader_set_uniform_f(swapper.index[mode], arg1)
	}
}

function pal_swap_reset()
{
	var u_enabled = shader_get_uniform(shd_pal_swapper, "pattern_enabled")
	shader_set_uniform_i(u_enabled, false)
	
	if (shader_current() != -1)
		shader_reset()
}

function pal_swap_layer_init()
{
	ds_map_clear(global.retro_pal_swapper.layer_map)
	ds_priority_clear(global.retro_pal_swapper.layer_priority)
	ds_priority_clear(global.retro_pal_swapper.layer_temp_priority)
}

function pal_swap_set_layer(arg0, arg1, arg2, arg3)
{
	var data = ds_map_find_value(global.retro_pal_swapper.layer_map, arg2)
	
	if (data == undefined)
		exit
	
	ds_map_set(global.retro_pal_swapper.layer_map, _layer_index, 
	{
		sprite: arg0,
		index: arg1,
		is_surf: arg3
	})
}

function pal_swap_enable_layer(arg0)
{
	if (!layer_exists(arg0))
		exit
	
	var data = 
	{
		sprite: undefined,
		index: undefined,
		is_surf: undefined
	}
	layer_script_begin(arg0, function()
	{
		if (event_type == ev_draw)
		{
			var layer_id = ds_priority_delete_min(global.retro_pal_swapper.layer_priority)
			var data = ds_map_find_value(global.retro_pal_swapper.layer_map, layer_id)
			
			if (data == "<undefined>")
				exit
			
			pal_swap_set(data.sprite, data.index, data.is_surf)
			ds_priority_add(global.retro_pal_swapper.layer_temp_priority, layer_id, layer_get_depth(layer_id))
		}
	})
	layer_script_end(arg0, function()
	{
		if (event_type == ev_draw)
		{
			pal_swap_reset()
			
			if (ds_priority_empty(global.retro_pal_swapper.layer_priority))
			{
				ds_priority_copy(global.retro_pal_swapper.layer_priority, global.retro_pal_swapper.layer_temp_priority)
				ds_priority_clear(global.retro_pal_swapper.layer_temp_priority)
			}
		}
	})
	ds_map_set(global.retro_pal_swapper.layer_map, arg0, data)
	ds_priority_add(global.retro_pal_swapper.layer_priority, arg0, layer_get_depth(arg0))
}

function scr_solid(arg0, arg1, arg2 = false)
{
	return place_meeting_collision(arg0, arg1, arg2);
}

function scr_solid_player(arg0, arg1, arg2 = false)
{
	return place_meeting_collision(arg0, arg1, arg2);
}

function scr_confecti_appear()
{
	drawxscale = image_xscale
	var _end = sprite_animation_end()
	
	if (sprite_index == spr_supertaunt)
	{
		drawxscale = obj_parent_player.xscale
		_end = sprite_animation_end() && obj_parent_player.state != PlayerState.taunt
	}
	
	if (sprite_index != spr_appear && sprite_index != spr_supertaunt)
		sprite_index = spr_appear
	
	image_speed = 0.4
	
	if (sprite_animation_end())
	{
		if (_end)
		{
			sprite_index = spr_idle
			state = PlayerState.frozen
			
			if (use_interpolation)
				interpolation = 0
		}
		else
		{
			image_index = image_number - 1
		}
	}
}

function scr_confecti_init()
{
	ds_list_add(global.FollowerList, id)
	depth = -5 + ds_list_find_index(global.FollowerList, id)
	bigTaunt = false
	old_x = x
	old_y = y
	real_x = x
	
	switch (object_index)
	{
		default:
			spr_idle = spr_marshmellow_idle
			spr_run = spr_marshemellow_run
			spr_runpanic = spr_marshmellow_panicWalk
			spr_panic = spr_marshmellow_panic
			spr_appear = spr_marshmallow_appear
			spr_supertaunt = spr_marshmallow_supertaunt
			spr_taunt = spr_marshmellow_taunt
			global.MallowFollow = true
			break
		
		case obj_confectichoco:
			spr_idle = spr_chocolate_idle
			spr_run = spr_chocolate_walk
			spr_runpanic = spr_chocolate_panicWalk
			spr_panic = spr_chocolate_panic
			spr_appear = spr_chocolate_appear
			spr_supertaunt = spr_chocolate_supertaunt
			spr_taunt = spr_chocolate_taunt
			global.ChocoFollow = true
			break
		
		case obj_confecticrack:
			if global.newconfect == false{
			spr_idle = spr_crack_idle
			spr_run = spr_crack_run
			spr_runpanic = spr_crack_panicWalk
			spr_panic = spr_crack_panic
			spr_appear = spr_crack_appear
			spr_supertaunt = spr_crack_supertaunt
			spr_taunt = spr_crack_taunt}
			else{
			spr_idle = spr_lollipop_idle
			spr_run = spr_lollipop_run
			spr_runpanic = spr_lollipop_run
			spr_panic = spr_lollipop_idle
			spr_appear = spr_crack_appear
			spr_supertaunt = spr_crack_supertaunt
			spr_taunt = spr_lollipop_taunt}
			global.CrackFollow = true
			break
		
		case obj_confectiworm:
			spr_idle = spr_gummyworm_idle
			spr_run = spr_gummyworm_walk
			spr_runpanic = spr_gummyworm_panicWalk
			spr_panic = spr_gummyworm_panic
			spr_appear = spr_gummyworm_appear
			spr_supertaunt = spr_gummyworm_supertaunt
			spr_taunt = spr_gummyworm_taunt
			global.WormFollow = true
			break
		
		case obj_confecticandy:
			spr_idle = spr_candy_idle
			spr_run = spr_candy_walk
			spr_runpanic = spr_candy_panicWalk
			spr_panic = spr_candy_panic
			spr_appear = spr_candy_appear
			spr_supertaunt = spr_candy_supertaunt
			spr_taunt = spr_candy_taunt
			global.CandyFollow = true
			break
		
		case obj_icegrandson:
			spr_idle = spr_icegrandson
			spr_run = spr_icegrandson
			spr_runpanic = spr_icegrandson_panic
			spr_panic = spr_icegrandson_panic
			spr_appear = spr_icegrandson_appear
			spr_supertaunt = spr_icegrandson_appear
			spr_taunt = spr_icegrandson_taunt
			global.NephewFollow = true
			break
		
		case obj_rudejanitor:
			bigTaunt = true
			spr_idle = spr_rudejanitor_idlefollow
			spr_run = spr_rudejanitor_walk
			spr_runpanic = spr_rudejanitor_walk
			spr_panic = spr_rudejanitor_idlefollow
			spr_appear = spr_rudejanitor_appear
			spr_supertaunt = spr_rudejanitor_appear
			spr_taunt = spr_rudejanitor_taunt
			global.janitorRudefollow = true
			break
		
		case obj_lapjanitor:
			bigTaunt = true
			spr_idle = spr_janitor_idle
			spr_run = spr_janitor_run
			spr_runpanic = spr_janitor_run
			spr_panic = spr_janitor_idle
			spr_appear = spr_janitor_jump
			spr_supertaunt = spr_janitor_taunt
			spr_taunt = spr_janitor_taunt
			global.janitorLapfollow = true
			break
	}
}

function scr_confecti_normal()
{
	if (sprite_index != spr_appear)
	{
		if (x != real_x)
			sprite_index = !global.panic ? spr_run : spr_runpanic
		else
			sprite_index = !global.panic ? spr_idle : spr_panic
	}
	
	var _dir = 0
	
	if (obj_parent_player.state != PlayerState.ladder && obj_parent_player.state != PlayerState.door && obj_parent_player.state != PlayerState.comingoutdoor)
		_dir = obj_parent_player.xscale
	
	confecti_dir = approach(confecti_dir, _dir, 0.2)
	distance = confecti_dir * 25
	var leader = -4
	leader = !ds_list_find_index(global.FollowerList, id) ? obj_parent_player : ds_list_find_value(global.FollowerList, floor(ds_list_find_index(global.FollowerList, id) - 1))
	
	if (!instance_exists(leader))
		leader = obj_parent_player
	
	if (instance_exists(leader))
	{
		ds_queue_enqueue(followQueue, leader.x - distance)
		ds_queue_enqueue(followQueue, leader.y)
	}
	
	LAG_STEPS = 10
	
	if (ds_queue_size(followQueue) > (LAG_STEPS * 2))
	{
		targetx = ds_queue_dequeue(followQueue)
		targety = ds_queue_dequeue(followQueue)
	}
	
	if (obj_parent_player.x != x)
		drawxscale = -sign(x - obj_parent_player.x)
	
	real_x = x
	
	if (use_interpolation)
	{
		x = lerp(x, targetx, interpolation)
		y = lerp(y, targety, interpolation)
		interpolation = approach(interpolation, 1, 0.01)
		
		if (interpolation)
		{
			interpolation = 0
			use_interpolation = false
		}
	}
	else
	{
		x = targetx
		y = targety
	}
	
	x = round(x)
	y = round(y)
	var supertaunts = [obj_parent_player.spr_supertaunt1, obj_parent_player.spr_supertaunt2, obj_parent_player.spr_supertaunt3, obj_parent_player.spr_supertaunt4]
	
	if (obj_parent_player.state == PlayerState.taunt && state != PlayerState.normal && state != PlayerState.titlescreen)
	{
		if (array_contains(supertaunts, obj_parent_player.sprite_index))
		{
			sprite_index = spr_supertaunt
			image_index = 0
			state = PlayerState.titlescreen
			
			with (obj_confectitaunt)
			{
				if (o_id == other.id)
					instance_destroy()
			}
		}
		else if (obj_parent_player.sprite_index == obj_parent_player.spr_taunt)
		{
			instance_create(x, y, obj_confectitaunt, 
			{
				o_id: id,
				depth: depth + 1,
				bigTaunt: bigTaunt
			})
			state = PlayerState.normal
			image_index = irandom_range(0, sprite_get_number(spr_taunt) - 1)
		}
	}
	
	image_speed = 0.35
}

function scr_confecti_taunt()
{
	image_speed = 0
	sprite_index = spr_taunt
	
	if (obj_parent_player.state != PlayerState.taunt)
	{
		state = PlayerState.frozen
		image_speed = 0.35
	}
	
	var supertaunts = [obj_parent_player.spr_supertaunt1, obj_parent_player.spr_supertaunt2, obj_parent_player.spr_supertaunt3, obj_parent_player.spr_supertaunt4]
	
	if (array_contains(supertaunts, obj_parent_player.sprite_index))
	{
		sprite_index = spr_supertaunt
		image_index = 0
		image_speed = 0.35
		state = PlayerState.titlescreen
		
		with (obj_confectitaunt)
		{
			if (o_id == other.id)
				instance_destroy()
		}
	}
}

function scr_confecti_unlock()
{
	sprite_index = spr_rudejanitor_unlock
	
	if (sprite_index == spr_rudejanitor_unlock && sprite_animation_end())
		image_speed = 0
	
	if (instance_exists(obj_fadeoutTransition) && obj_fadeoutTransition.fadealpha == 1 && sprite_index == spr_rudejanitor_unlock)
		instance_destroy()
}

function scr_getDialogIcon(arg0, arg1 = "c_white", arg2 = "c_black")
{
	arg0 = string_upper(arg0)
	var spr = "spr_null"
	var ind = "0"
	
	switch (arg0)
	{
		case "HARRY":
			spr = "spr_icon_dialog"
			ind = "1"
			break
		
		case "PIZZELLE":
			spr = "spr_icon_dialog"
			ind = "0"
			break
		
		case "LAPLAD":
		case "LAP LAD":
		case "POLKA":
			spr = "spr_icon_dialog"
			ind = "2"
			break
		
		case "INK":
			spr = "spr_icon_dialog"
			ind = "3"
			break
		
		case "RUDY":
			spr = "spr_icon_dialog"
			ind = "4"
			break
		
		case "SLUGGY":
			spr = "spr_icon_dialog"
			ind = "5"
			break
		
		case "COTTONWITCH":
			spr = "spr_icon_dialog"
			ind = "6"
			break
		
		case "GUARDIAN":
			spr = "spr_icon_dialog"
			ind = "7"
			break
		
		case "FLINGFROG":
			spr = "spr_icon_dialog"
			ind = "8"
			break
	}
	
	return string("[{0}][{1}, {2}][{3}]", arg1, spr, ind, arg2);
}

function subSprite(arg0, arg1 = 0, arg2 = 0.35, arg3 = true) constructor
{
	static update = function(arg0 = image_speed)
	{
		image_number = sprite_get_number(sprite_index)
		image_index += arg0
		
		if (doWrap)
			image_index = wrap(image_index, 0, image_number)
		else
			image_index = clamp(image_index, 0, image_number)
		
		return image_index;
	}
	
	static setPosition = function(arg0, arg1)
	{
		x = arg0
		y = arg1
		return self;
	}
	
	static draw = function(arg0 = x, arg1 = y, arg2 = image_xscale, arg3 = image_yscale, arg4 = image_angle, arg5 = image_blend, arg6 = image_alpha)
	{
		if (!visible)
			exit
		
		draw_sprite_ext(sprite_index, image_index, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
		return self;
	}
	
	static draw_lang = function(arg0 = x, arg1 = y, arg2 = image_xscale, arg3 = image_yscale, arg4 = image_angle, arg5 = image_blend, arg6 = image_alpha)
	{
		if (!visible)
			exit
		
		draw_sprite_ext(lang_get_sprite(sprite_index), image_index, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
		return self;
	}
	
	static setFunction = function(arg0)
	{
		custom_func = method(self, arg0)
		return self;
	}
	
	sprite_index = arg0
	image_index = arg1
	image_speed = arg2
	doWrap = arg3
	image_xscale = 1
	image_yscale = 1
	visible = true
	image_angle = 0
	image_blend = c_white
	image_alpha = 1
	x = 0
	y = 0
	xstart = 0
	ystart = 0
	image_number = sprite_get_number(sprite_index)
	finalFrame = image_number
	custom_func = -4
	return self;
}

function scr_button_pressed(arg0)
{
	if ((keyboard_check_pressed(vk_anykey) || input_get("jump").pressed) && !keyboard_check_pressed(vk_f1))
	{
		return -1;
	}
	else if (gamepad_is_connected(arg0))
	{
		if (gamepad_button_check(arg0, gp_face1) || gamepad_button_check(arg0, gp_start))
			return arg0;
	}
	
	return -2;
}

function create_afterimage(arg0, arg1 = image_xscale, arg2 = false)
{
	if (!instance_exists(id))
		exit
	
	var parent = object_index
	var afterimage_id = id
	var pal = [-4, -4]
	var angle = afterimage_id.image_angle
	
	if (object_is_ancestor(parent, obj_parent_enemy))
		pal = [paletteSelect, paletteSprite]
	
	if (object_is_ancestor(parent, obj_parent_player))
		angle = afterimage_id.draw_angle
	
	var q = 
	{
		x: afterimage_id.x,
		y: afterimage_id.y,
		blink: arg2,
		sprite_index: afterimage_id.sprite_index,
		image_index: afterimage_id.image_index,
		image_alpha: 1,
		image_angle: angle,
		image_xscale: arg1,
		image_yscale: 1,
		visible: true,
		alarm: [13, 30],
		color_choose: arg0,
		hsp: 0,
		vsp: 0,
		identity: afterimage_id,
		gonealpha: (arg0 == AfterImageType.plain) ? 0.85 : 1,
		vanish: false,
		paletteSelect: pal[0],
		paletteSprite: pal[1],
		basicAfterimage: true,
		mach3Afterimage: false,
		vanishSpd: 0.15,
		fakeMach3Afterimage: false
	}
	
	if (arg0 == AfterImageType.baddie)
		q.vanishSpd = 0.05
	
	ds_list_add(global.afterimage_list, q)
	return q;
}

function create_heat_afterimage(arg0, arg1 = image_xscale, arg2 = 8)
{
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85
		vsp = arg2
		alarm[0] = 1
		alarm[1] = 60
	}
	
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85
		vsp = -arg2
		alarm[0] = 1
		alarm[1] = 60
	}
	
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85
		hsp = arg2
		alarm[0] = 1
		alarm[1] = 60
	}
	
	with (create_afterimage(arg0, arg1))
	{
		gonealpha = 0.85
		hsp = -arg2
		alarm[0] = 1
		alarm[1] = 60
	}
}

function window_get_active_displays()
{
	window_get_active_displays()
	var wx = window_get_x(),wy = window_get_y(),ww = window_get_width(),wh = window_get_height(),display_data = window_get_visible_rects(wx, wy, wx + ww, wy + wh)
	return array_length(display_data) / 8;
}

function cutscene_wait(arg0)
{
	with (obj_cutsceneManager)
	{
		timer++
		
		if (timer >= arg0)
		{
			timer = 0
			cutscene_event_end()
		}
	}
}

function cutscene_end_player()
{
	obj_parent_player.state = PlayerState.normal
	obj_parent_player.hsp = 0
	obj_parent_player.vsp = 0
	obj_parent_player.sprite_index = obj_parent_player.spr_idle
	cutscene_event_end()
}

function cutscene_start_player()
{
	obj_parent_player.state = PlayerState.actor
	obj_parent_player.hsp = 0
	obj_parent_player.vsp = 0
	obj_parent_player.sprite_index = obj_parent_player.spr_idle
	cutscene_event_end()
}

function cutscene_create_instance(arg0, arg1, arg2)
{
	instance_create(arg0, arg1, arg2)
	cutscene_event_end()
}

function cutscene_do_func(arg0)
{
	arg0()
	cutscene_event_end()
}

function cutscene_with_actor(arg0, arg1)
{
	cutscene_event_end()
	
	with (cutscene_get_actor(arg0))
		return arg1();
}

function cutscene_do_dialog(arg0, arg1 = false)
{
	queue_dialogue(arg0, arg1)
	
	with (obj_dialogue)
		instant_destroy = arg1
	
	cutscene_event_end()
}

function cutscene_wait_dialog()
{
	var finished = false
	
	if (!instance_exists(obj_dialogue) && !instance_exists(obj_dialogue_choices))
		finished = true
	
	if (finished)
		cutscene_event_end()
}

function cutscene_lerp_actor(arg0, arg1, arg2, arg3)
{
	var finished = false
	
	with (cutscene_get_actor(arg0))
	{
		x = lerp(x, arg1, arg3)
		y = lerp(y, arg2, arg3)
		
		if (distance_to_point(arg1, arg2) <= 4)
		{
			finished = true
			x = arg1
			y = arg2
		}
	}
	
	if (finished)
		cutscene_event_end()
}

function cutscene_move_actor(arg0, arg1, arg2, arg3)
{
	var finished = false
	var real_actor = cutscene_get_actor(arg0)
	
	with (real_actor)
	{
		var angle = point_direction(x, y, arg1, arg2)
		var dir_x = lengthdir_x(arg3, angle)
		var dir_y = lengthdir_y(arg3, angle)
		x = approach(x, arg1, dir_x)
		y = approach(y, arg2, dir_y)
		
		if (x == arg1 && y == arg2)
			finished = true
	}
	
	if (finished || !real_actor)
		cutscene_event_end()
}

function cutscene_new_actor(arg0, arg1, arg2, arg3)
{
	var new_actor = instance_create(arg0, arg1, obj_actor)
	new_actor.sprite_index = arg2
	
	with (new_actor)
		cutscene_declare_actor(id, arg3)
	
	cutscene_event_end()
	return new_actor;
}

function cutscene_actor_animend(arg0)
{
	var finished = false
	
	with (cutscene_get_actor(arg0))
	{
		if (sprite_animation_end())
			finished = true
	}
	
	if (finished)
		cutscene_event_end()
}

function cutscene_geyser_start()
{
	var geyser = cutscene_get_actor("GEYSER")
	var finished = false
	global.ComboFreeze = 2
	obj_camera.chargeCameraX = 0
	
	with (obj_parent_player)
	{
		state = PlayerState.actor
		visible = false
		hsp = 0
		vsp = 0
		image_speed = 0.35
		
		if (instance_exists(geyser))
		{
			geyser.t = 0
			geyser.cutsceneTimer = 60
			geyser.shakeX = 2
			finished = true
		}
	}
	
	with (obj_parent_follower)
		visible = false
	
	if (finished)
		cutscene_event_end()
}

function cutscene_geyser_middle()
{
	var geyser = cutscene_get_actor("GEYSER")
	var finished = false
	global.ComboFreeze = 2
	
	with (obj_parent_player)
	{
		state = PlayerState.actor
		visible = false
		hsp = 0
		vsp = 0
		image_speed = 0.35
		
		if (instance_exists(geyser))
		{
			with (geyser)
			{
				t = (t + 1) % 65535
				
				if ((t % 6) == 0)
				{
					camera_shake_add(irandom(2), 1)
					event_play_multiple("event:/SFX/general/breakblock", x, y)
				}
				
				if (sprite_animation_end(2) && sprite_index == spr_geyserCutscene_Activated)
					finished = true
			}
		}
	}
	
	if (finished)
		cutscene_event_end()
}

function cutscene_geyser_end()
{
	var geyser = cutscene_get_actor("GEYSER")
	var finished = false
	global.ComboFreeze = 2
	
	with (obj_parent_player)
	{
		sprite_index = spr_player_PZ_geyser
		state = PlayerState.jump
		jumpStop = true
		visible = true
		hsp = 0
		vsp = -18
		image_speed = 0.35
		wetTimer = wetTimerMax
		
		if (instance_exists(geyser))
		{
			finished = true
			
			with (geyser)
			{
				sprite_index = spr_geyserCutscene_Active
				image_index = 0
				fmod_studio_event_instance_start(sound)
			}
		}
	}
	
	with (obj_parent_follower)
	{
		visible = true
		wetTimer = wetTimerMax
	}
	
	if (finished)
		cutscene_event_end()
}

function cutscene_judgment_init()
{
	cutscene_create([cutscene_start_player, cutscene_judgment_playermove, cutscene_judgment_start, cutscene_judgment_dialog, cutscene_judgment_flick, cutscene_judgment_end])
	
	with (obj_parent_player)
	{
		cutscene_declare_actor(id, "PLAYER")
		visible = true
		image_speed = 0.35
		image_index = 0
		xscale = 1
		image_xscale = 1
	}
	
	var cr = inst_100209
	cr.Region_active = true
	
	with (obj_judgmentpainter)
	{
		cutscene_declare_actor(id, "PAINTER")
		targetPlayer = cutscene_get_actor("PLAYER")
		x = cr.x + cr.sprite_width
		y = cr.y + cr.sprite_width
	}
}

function cutscene_judgment_playermove()
{
	with (cutscene_get_actor("PLAYER"))
	{
		if (place_meeting_collision(x + 32, y + 1))
		{
			x += 3
			sprite_index = spr_move
		}
		else
		{
			sprite_index = spr_idle
			image_index = 0
			image_speed = 0.35
			cutscene_event_end()
		}
	}
}

function cutscene_judgment_start()
{
	with (obj_judgmentpainter)
	{
		if (!active)
		{
			givenJudgment = scr_judgment_assign()
			var d = array_clone(givenJudgment.properties.dialog)
			ini_open(global.SaveFileName)
			
			if (ini_read_real("Treasure", "mindpalace", 0) > 0)
				array_push(d, lang_get("judgmentinfo_additional"))
			
			ini_close()
			
			for (var i = 0; i < array_length(d); i++)
			{
				var s = scribble(d[i]).wrap(sprite_get_width(spr_dialobox_temp) - 80).line_spacing(30).starting_format(font_get_sprite(global.npcfont, true)).align(0, 0)
				array_push(dialogEvents, s)
			}
		}
		
		active = true
		visible = true
	}
	
	cutscene_event_end()
}

function cutscene_judgment_dialog()
{
	with (obj_judgmentpainter)
	{
		if (finished)
		{
			var cr = inst_100209
			cr.Region_active = false
			
			with (obj_secret_brainBlock)
			{
				instance_change(obj_secretdestroyable_metal, true)
				debrisSprite = spr_painterbraindebris
				smokeColor = [ #A90861, #E95098, #E18BB2 ]
			}
			
			cutscene_event_end()
		}
	}
}

function cutscene_judgment_flick()
{
	static afterimage_timer = 2
	
	with (obj_parent_player)
	{
		targetRoom = rm_credits
		sprite_index = spr_flicked
		x -= 18
		y = ystart + random_range(-1, 1)
		
		if (!instance_exists(obj_chargeEffect))
			instance_create(x, y, obj_chargeEffect)
		
		afterimage_timer = max(afterimage_timer - 1, 0)
		
		if (afterimage_timer <= 0)
		{
			with (create_afterimage(AfterImageType.plain, xscale, 0))
			{
				image_index = max(other.image_index - 1, 0)
				vanish = true
				gonealpha = 0.8
				alarm[0] = 1
				alarm[1] = 60
			}
			
			afterimage_timer = 2
		}
		
		check_and_destroy(x - 18, y, obj_destructibles)
		check_and_destroy(x - 18, y, obj_metalblock)
		
		if (x <= -100)
		{
			x = -100
			cutscene_event_end()
		}
	}
}

function cutscene_judgment_end()
{
	with (instance_create(0, 0, obj_fadeoutTransition))
		fadespeed = 0.02
	
	cutscene_event_end()
}

function cutscene_mindpalacedoor_prestart()
{
	var _seenCutscene = false
	ini_open(global.SaveFileName)
	_seenCutscene = ini_read_real("Game", "mindpalace_door_cutscene", false)
	ini_close()
	
	if (_seenCutscene)
	{
		with (obj_door)
			visible = true
		
		ds_queue_clear(Cutscene)
	}
	
	cutscene_event_end()
}

function cutscene_mindpalacedoor_start()
{
	with (cutscene_new_actor(256, 1120, spr_door_mindpalace2, "DOOR"))
		depth = 110
	
	with (obj_door)
		visible = false
	
	with (obj_parent_player)
	{
		state = PlayerState.actor
		hsp = 0
		vsp = 0
		visible = false
	}
	
	obj_camera.cameraLock = true
	timer = 0
	event_play_oneshot("event:/SFX/general/mindpalacedoorrise")
	cutscene_event_end()
}

function cutscene_mindpalacedoor_mid()
{
	static cloudEffect = 2
	
	var _door = cutscene_get_actor("DOOR"),_finish = false
	
	with (_door)
	{
		y = approach(y, 992, 1)
		x = xstart + irandom_range(-4, 4)
		
		if (!cloudEffect--)
		{
			create_particle(random_range(bbox_left, bbox_right), 1088, choose(spr_cloudEffect, spr_bigcloudeffect))
			cloudEffect = 8
		}
		
		if (y == 992)
		{
			_finish = true
			x = xstart
		}
	}
	
	if (_finish)
		cutscene_event_end()
}

function cutscene_mindpalacedoor_end()
{
	instance_destroy(cutscene_get_actor("DOOR"))
	
	with (obj_parent_player)
	{
		state = PlayerState.comingoutdoor
		image_index = 0
		sprite_index = spr_walkfront
		visible = true
		hsp = 0
		vsp = 0
		image_blend = c_black
	}
	
	obj_camera.cameraLock = false
	
	with (obj_door)
		visible = true
	
	ini_open(global.SaveFileName)
	ini_write_real("Game", "mindpalace_door_cutscene", true)
	ini_close()
	cutscene_event_end()
}

function queue_dialogue(arg0, arg1 = false)
{
	reset_dialogue()
	
	if (!instance_exists(obj_dialogue))
		instance_create(0, 0, obj_dialogue)
	
	with (obj_dialogue)
	{
		if (obj_dialogue.state == dialogstate.outro)
			obj_dialogue.state = dialogstate.intro
		
		if (arg1)
			obj_dialogue.state = dialogstate.normal
		
		obj_dialogue.curmsg = 0
	}
	
	global.DialogMessage = arg0
}

function reset_dialogue()
{
	instance_destroy(obj_dialogue)
	instance_destroy(obj_dialogue_choices)
	global.DialogMessage = -4
	global.dialogchoices = -4
	global.choiced = -4
}

function create_dialogue(arg0, arg1 = -4, arg2 = -4)
{
	return [arg0, arg1, arg2];
}

function create_choice(arg0, arg1)
{
	return [arg0, arg1];
}

function queue_choices(arg0, arg1)
{
	reset_dialogue()
	
	with (instance_create(x, y, obj_dialogue_choices))
		msg_text = arg1
	
	global.dialogchoices = arg0
	show_debug_message(string("Dialogue Choices: {0}", global.dialogchoices))
}

function text_wrap(arg0, arg1, arg2, arg3)
{
	var pos_space = -1
	var pos_current = 1
	var text_current = arg0
	var text_output = ""
	
	if (is_real(arg2))
		arg2 = "#"
	
	while (string_length(text_current) >= pos_current)
	{
		if (string_width(string_copy(text_current, 1, pos_current)) > arg1)
		{
			if (pos_space != -1)
			{
				text_output += (string_copy(text_current, 1, pos_space) + string(arg2))
				text_current = string_copy(text_current, pos_space + 1, string_length(text_current) - pos_space)
				pos_current = 1
				pos_space = -1
			}
			else if (arg3)
			{
				text_output += (string_copy(text_current, 1, pos_current - 1) + string(arg2))
				text_current = string_copy(text_current, pos_current, string_length(text_current) - (pos_current - 1))
				pos_current = 1
				pos_space = -1
			}
		}
		
		pos_current += 1
		
		if (string_char_at(text_current, pos_current) == " ")
			pos_space = pos_current
	}
	
	if (string_length(text_current) > 0)
		text_output += text_current
	
	return text_output;
}

function gate_createlayer(arg0, arg1, arg2 = 0, arg3 = 0, arg4 = 0)
{
	var w = sprite_get_width(arg0),h = sprite_get_height(arg0),x1 = sprite_get_xoffset(arg0),y1 = sprite_get_yoffset(arg0)
	return 
	{
		sprite_index: arg0,
		image_index: arg1,
		image_xscale: 1,
		image_yscale: 1,
		image_speed: arg4,
		image_alpha: 1,
		image_blend: c_white,
		image_angle: 0,
		x: 0,
		y: 0,
		xstart: 0,
		ystart: h,
		hspeed: arg2,
		vspeed: arg3,
		readjust: false,
		dbg: false,
		func: -4
	};
}

function default_gate_scroll(arg0)
{
	var length = sprite_get_number(arg0)
	var arr = []
	var debug_arr = []
	
	for (var i = length; i > 0; i--)
	{
		var pct = lerp(-0.5, -0.85, i / length)
		array_push(arr, gate_createlayer(arg0, i - 1, pct))
		array_push(debug_arr, i - 1)
	}
	
	return arr;
}

function default_gate_parallax(arg0)
{
	var length = sprite_get_number(arg0),arr = [],xoffset = x,yoffset = y - (sprite_height / 2)
	
	for (var i = length; i > 0; i--)
	{
		var pct = lerp(0.15, 0.05, i / length)
		var g = gate_createlayer(arg0, i - 1, pct, pct)
		
		with (g)
		{
			xoff = xoffset
			yoff = yoffset
			
			func = function()
			{
				x = ((camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2)) - xoff) * hspeed
				y = ((camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2)) - yoff) * vspeed
			}
		}
		
		array_push(arr, g)
	}
	
	trace(arr)
	return arr;
}

function scr_checkanygamepad(arg0)
{
	var gpButtons = [gp_face1, gp_face2, gp_face3, gp_face4, gp_shoulderl, gp_shoulderlb, gp_shoulderr, gp_shoulderrb, gp_select, gp_start, gp_stickl, gp_stickr, gp_padu, gp_padd, gp_padl, gp_padr, gp_axislh, gp_axislv, gp_axisrv, gp_axisrh]
	
	for (var i = 0; i < array_length(gpButtons); i++)
	{
		if (gamepad_button_check_pressed(arg0, gpButtons[i]))
			return gpButtons[i];
	}
	
	return -4;
}

function scr_check_joysticks(arg0, arg1 = 0.5)
{
	var sticks = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
	
	for (var i = 0; i < array_length(sticks); i++)
	{
		var val = gamepad_axis_value(arg0, sticks[i])
		
		if (val > arg1)
			return sticks[i];
		
		if (val < -arg1)
			return sticks[i];
	}
	
	return -4;
}

function scr_checkanystick(arg0, arg1 = 0.5)
{
	var sticks = [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
	
	for (var i = 0; i < array_length(sticks); i++)
	{
		var val = gamepad_axis_value(arg0, sticks[i])
		
		if (val > arg1 || val < -arg1)
			return true;
	}
	
	return false;
}

function scr_checksuperjump()
{
	var disabled = global.option_sjump_gp
	
	if (global.PlayerInputDevice < 0)
		disabled = global.option_sjump_key
	
	return (disabled && key_up) || key_superjump;
}

function scr_checkgroundpound()
{
	var disabled = global.option_groundpound_gp
	
	if (global.PlayerInputDevice < 0)
		disabled = global.option_groundpound_key
	
	return (disabled && key_down2) || key_groundpound;
}

function scr_input_init_sprites()
{
	if (!variable_global_exists("input_icons"))
		global.input_icons = ds_map_create()
	
	scr_input_icon_add(["UNSET"], spr_key_empty, 0)
	scr_input_icon_add(["NONE"], spr_key_special, 0)
	scr_input_icon_add([vk_space], spr_key_special, 1)
	scr_input_icon_add([vk_up], spr_key_special, 2)
	scr_input_icon_add([vk_right], spr_key_special, 3)
	scr_input_icon_add([vk_down], spr_key_special, 4)
	scr_input_icon_add([vk_left], spr_key_special, 5)
	scr_input_icon_add([vk_shift, vk_lshift, vk_rshift], spr_key_special, 6)
	scr_input_icon_add([vk_control, vk_lcontrol, vk_rcontrol], spr_key_special, 7)
	scr_input_icon_add([vk_alt, vk_lalt, vk_ralt], spr_key_special, 8)
	scr_input_icon_add([vk_escape], spr_key_special, 9)
	scr_input_icon_add([vk_enter], spr_key_special, 10)
	scr_input_icon_add([vk_backspace], spr_key_special, 11)
	scr_input_icon_add([20], spr_key_special, 12)
	scr_input_icon_add([vk_tab], spr_key_special, 13)
	scr_input_icon_add([gp_axislh, gp_axislv], spr_key_controller, 18)
	scr_input_icon_add([gp_axisrh, gp_axisrv], spr_key_controller, 19)
	scr_input_icon_add([gp_stickl], spr_key_controller, 18)
	scr_input_icon_add([gp_stickr], spr_key_controller, 19)
	scr_input_icon_add([gp_face1], spr_key_controller, 8)
	scr_input_icon_add([gp_face3], spr_key_controller, 9)
	scr_input_icon_add([gp_face4], spr_key_controller, 10)
	scr_input_icon_add([gp_face2], spr_key_controller, 11)
	scr_input_icon_add([gp_padu], spr_key_controller, 0)
	scr_input_icon_add([gp_padd], spr_key_controller, 1)
	scr_input_icon_add([gp_padr], spr_key_controller, 2)
	scr_input_icon_add([gp_padl], spr_key_controller, 3)
	scr_input_icon_add([gp_start], spr_key_controller, 17)
	scr_input_icon_add([gp_select], spr_key_controller, 16)
	scr_input_icon_add([gp_shoulderlb], spr_key_controller, 12)
	scr_input_icon_add([gp_shoulderrb], spr_key_controller, 13)
	scr_input_icon_add([gp_shoulderl], spr_key_controller, 14)
	scr_input_icon_add([gp_shoulderr], spr_key_controller, 15)
}

function scr_input_icon_add(arg0, arg1, arg2)
{
	for (var i = 0; i < array_length(arg0); i++)
	{
		var input = arg0[i]
		ds_map_set(global.input_icons, input, [arg1, arg2])
		trace("Added ", sprite_get_name(arg1), string(" (frame: {0}) to input icon map for {1}.", arg2, input))
	}
}

function scr_input_get_actions(arg0)
{
	var inputArr = []
	var use_gamepad = global.PlayerInputDevice >= 0
	
	if (instance_exists(obj_option_keyconfig))
		use_gamepad = obj_option_keyconfig.gamepad
	
	if (use_gamepad && !string_ends_with(arg0, "C"))
		arg0 = string_concat(arg0, "C")
	
	var input = input_get(arg0)
	
	if (is_undefined(input))
		return inputArr;
	
	if (!use_gamepad && array_length(input.keyInputs) > 0)
		inputArr = input.keyInputs
	else if (use_gamepad && array_length(input.gpInputs) > 0)
		inputArr = input.gpInputs
	
	return inputArr;
}

function scr_input_get_icon(arg0, arg1 = false)
{
	var result = []
	var inputArr = scr_input_get_actions(arg0)
	var length = arg1 ? array_length(inputArr) : 1
	
	if (array_length(inputArr) > 0)
	{
		for (var i = 0; i < length; i++)
		{
			var ico = ds_map_find_value(global.input_icons, array_get(inputArr, i))
			var iarr = [inputArr[i]]
			
			if (!is_undefined(ico))
				array_push(result, array_concat(ico, iarr))
			else
				array_push(result, array_concat(ds_map_find_value(global.input_icons, "UNSET"), iarr))
		}
	}
	else
	{
		result = [array_concat(ds_map_find_value(global.input_icons, "NONE"), [-1])]
	}
	
	return arg1 ? result : result[0];
}

function get_control_sprite(arg0, arg1 = false)
{
	var _controller = global.PlayerInputDevice >= 0
	
	switch (arg0)
	{
		case "forward":
			arg0 = (obj_parent_player.xscale == -1) ? "left" : "right"
			break
		
		case "backward":
			arg0 = (obj_parent_player.xscale == 1) ? "left" : "right"
			break
		
		case "dialogSJ":
			var _enabled = _controller ? global.option_sjump_gp : global.option_sjump_key
			arg0 = !_enabled ? "superjump" : "up"
			break
		
		case "dialogGP":
			var _enabled = _controller ? global.option_groundpound_gp : global.option_groundpound_key
			arg0 = !_enabled ? "groundpound" : "down"
			break
	}
	
	var icon = scr_input_get_icon(arg0)
	
	if (arg1)
		return icon;
	
	var str = string("[{0}]", sprite_get_name(icon[0]) + ", " + string(floor(icon[1])))
	
	if (icon[0] == spr_key_empty)
		str += string("[keyDrawFont]{0}", scr_keyname(icon[2]))
	
	return str;
}

function draw_control_sprite(arg0, arg1, arg2)
{
	var icon = get_control_sprite(arg0, true)
	var base = scribble(string("[{0}, {1}]", sprite_get_name(icon[0]), floor(icon[1]))).align(1, 1).blend(draw_get_color(), draw_get_alpha()).draw(arg1, arg2)
	
	if (icon[0] == spr_key_empty)
		scribble(string_copy(scr_keyname(icon[2]), 1, 3)).starting_format(font_get_name(global.keyDrawFont), 0).align(1, 1).blend(draw_get_color(), draw_get_alpha()).draw(arg1 + 16, arg2)
	
	return base;
}

function scr_judgment_assign()
{
	var per = scr_completion_percent(global.SaveFileName)
	ini_open(global.SaveFileName)
	var j = "disappointing"
	var judgement = ini_read_string("Game", "Judgment", "noone")
	
	if (per >= 100)
		j = "perfect"
	else if (per >= 50)
		j = "fine"
	
	if (global.SaveMinutes < 20)
		j = "fast"
	
	if (global.SaveMinutes < 45 && per >= 101)
		j = "holyshit"
	
	if (judgement == "holyshit")
		j = "holyshit"
	
	ini_write_string("Game", "Judgment", j)
	ini_close()
	trace(string("Save File Judgment: {0}", j))
	return scr_judgment_get(j);
}

function scr_judgment_get(arg0)
{
	var j = ds_map_find_value(global.judgment_map, arg0)
	return j ?? ds_map_find_value(global.judgment_map, "none");
}

function scr_judgment_read(arg0)
{
	if (!file_exists(arg0))
		return scr_judgment_get("none");
	
	ini_open(arg0)
	var p = ini_read_string("Game", "Judgment", "none")
	ini_close()
	return scr_judgment_get(p);
}

function saveJudgment() constructor
{
	static setProperties = function(arg0)
	{
		properties = arg0
		return self;
	}
	
	properties = 
	{
		title: "",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_null,
		fileindex: 0
	}
	return self;
}

function add_judgment(arg0, arg1)
{
	var j = new saveJudgment().setProperties(arg1)
	j.properties.title = lang_get(string("judgment_title_{0}", arg0))
	j.properties.dialog = [lang_get("judgmentinfo_default")]
	
	for (var i = 1; lang_key_exists(string("judgmentinfo_{0}_{1}", arg0, i)); i++)
	{
		var dg = lang_get(string("judgmentinfo_{0}_{1}", arg0, i))
		array_push(j.properties.dialog, dg)
	}
	
	array_push(j.properties.dialog, lang_get("judgmentinfo_ending"))
	ds_map_set(global.judgment_map, arg0, j)
	return j;
}

function scr_judgment_init()
{
	if (!variable_global_exists("judgment_map"))
	{
		global.judgment_map = ds_map_create()
		add_judgment("none", 
		{
			title: "none",
			titlespr: spr_null,
			titleindex: 0,
			splash: spr_null,
			splashindex: 0,
			filespr: spr_null,
			fileindex: 0
		})
	}
	else
	{
		var default_judgment = ds_map_find_value(global.judgment_map, "none")
		ds_map_clear(global.judgment_map)
		ds_map_set(global.judgment_map, "none", default_judgment)
	}
	
	add_judgment("disappointing", 
	{
		title: "disappointing",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 0
	})
	add_judgment("fine", 
	{
		title: "fine",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 1
	})
	add_judgment("perfect", 
	{
		title: "perfect",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 2
	})
	add_judgment("fast", 
	{
		title: "fast",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 3
	})
	add_judgment("holyshit", 
	{
		title: "holyshit",
		titlespr: spr_null,
		titleindex: 0,
		splash: spr_null,
		splashindex: 0,
		filespr: spr_judgment_files,
		fileindex: 4
	})
}

function scr_ghostcollectible(arg0 = false, arg1 = undefined, arg2 = undefined)
{
	if (!instance_exists(obj_secretfound) || createdGhost)
		return -4;
	
	createdGhost = true
	var q = -4
	var b = id
	
	with (obj_secretfound)
	{
		q = 
		{
			x: b.xstart,
			y: b.ystart,
			sprite_index: b.sprite_index,
			image_speed: b.image_speed * sprite_get_speed(b.sprite_index),
			image_number: b.image_number,
			image_xscale: b.image_xscale,
			image_yscale: b.image_yscale,
			image_alpha: 0.5,
			image_index: 0,
			candysona: arg0,
			paletteSprite: arg1,
			paletteSelect: arg2,
			usePalette: !is_undefined(arg1),
			platformIndex: 0
		}
		show_debug_message(string("Ghost Collectable created: {0} (Struct)", q))
		ds_list_add(collectSecretList, q)
	}
	
	return q;
}

function scr_player_check_normal(arg0)
{
	var normalStates = [PlayerState.normal, PlayerState.jump, PlayerState.mach1, PlayerState.mach2, PlayerState.mach3, PlayerState.machslide, PlayerState.wallkick, PlayerState.grabdash, PlayerState.crouch, PlayerState.crouchjump]
	return array_contains(normalStates, arg0.state);
}

function scr_isPTCharacter()
{
	return (global.playerCharacter == Characters.Peppino || global.playerCharacter == Characters.Noise || global.playerCharacter == Characters.Vigilante)
}

function concat()
{
    var _string = "";
    
    for (var i = 0; i < argument_count; i++)
        _string += string(argument[i]);
    
    return _string;
}