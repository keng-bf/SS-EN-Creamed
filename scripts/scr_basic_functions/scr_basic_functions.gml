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
	var bps = arg0 / 60
	var spb = 1 / bps
	var song_timer = audio_sound_get_track_position(global.music)
	var game_fps = 60
	var beat2 = floor(song_timer) / (spb * game_fps)
	
	if (beat != beat2)
	{
		beat = beat2
		return true;
	}
	
	return false;
}

function solid_in_line(arg0, arg1 = -4, arg2 = self)
{
	var _list = ds_list_create()
	var set_list = collision_line_list(x, y, arg0.x, arg0.y, obj_parent_collision, true, true, _list, true)
	
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
	var p_num = parameter_count()
	var p_string = []
	
	if (p_num > 0)
	{
		for (var i = 0; i < p_num; i++)
			p_string[i] = parameter_string(i)
	}
	
	return p_string;
}

function round_nearest(arg0, arg1)
{
	var val = abs(arg1[0] - arg0)
	var ind = 0
	
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
	var mouse_xpos = device_mouse_x_to_gui(arg0)
	var params = calculate_letterbox_params()
	return round((mouse_xpos - params.screen_x) / params.scale);
}

function get_mouse_y_screen(arg0 = 0)
{
	var mouse_ypos = device_mouse_y_to_gui(arg0)
	var params = calculate_letterbox_params()
	return round((mouse_ypos - params.screen_y) / params.scale);
}

function get_mouse_x(arg0 = 0)
{
	var mouse_xpos = get_mouse_x_screen(arg0)
	var camera_x = camera_get_view_x(view_camera[0])
	var camera_width = camera_get_view_width(view_camera[0])
	var gui_width = display_get_gui_width()
	var zoom_x = camera_width / gui_width
	return round(camera_x + (mouse_xpos * zoom_x));
}

function get_mouse_y(arg0 = 0)
{
	var mouse_ypos = get_mouse_y_screen(arg0)
	var camera_y = camera_get_view_y(view_camera[0])
	var camera_height = camera_get_view_height(view_camera[0])
	var gui_height = display_get_gui_height()
	var zoom_y = camera_height / gui_height
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

function pummel_dim()
{
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