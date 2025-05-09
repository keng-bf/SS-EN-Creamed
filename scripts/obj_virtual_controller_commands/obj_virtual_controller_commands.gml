#macro COMMANDS_FILE_PATH "/storage/emulated/0/Documents/sugary spire android/commands/"
//TODO: READ FROM AN EXTERNAL LANGUAGE FILE SO PEOPLE CAN MAKE CUSTOM LANGAUAGES FOR TEXT HERE.
// old editor stuff
global.door_object_arr = [obj_startGate, obj_door, obj_keydoor, obj_janitorDoor, obj_hallway, obj_secretPortal, obj_lapPortal]
function processcommand(commandstring,silentcommand = false,is_trigger = false){
	var _string = string_trim(commandstring)
	if(string_pos("gml", _string) == 1)
		return docommand(_string, silentcommand, is_trigger)
	if(string_pos("startupcommand", _string) == 1)
		return docommand(_string, silentcommand, is_trigger)
	if(string_pos("savecommand", _string) == 1)
		return docommand(_string, silentcommand, is_trigger)
	if (string_pos(";", _string) != 0) 
	{
		var _commands = string_split(_string + ";",";")
		for(var i = 0; i < array_length(_commands); i++)
		{
			docommand(_commands[i],silentcommand, is_trigger)
		}
	} 
	else
		docommand(_string, silentcommand, is_trigger)
}
function docommand(commandstring,silentcommand = false,is_trigger = false) 
{
	var playerid = instance_find(obj_parent_player,0) 
	if(playerid == noone) playerid = self
	if(string_pos("panic", string_lower(commandstring)) == 1) 
	{
		var commands = string_split(commandstring, " ");
		var hasarg2 = false
		for (var i = 1;i < array_length(commands);i++) 
		{
			if(i == 2)
			{
				global.panic = true
				global.fill = int64(commands[i]) * 12
				hasarg2 = true
			}
			if(i >= 2) break
		}
		if(hasarg2 == false)
		{
			global.panic = true
			global.fill = 0
		}
	}
	if(string_pos("reload_gml", string_lower(commandstring)) == 1) 
	{
	}
	if(string_pos("gml", string_lower(commandstring)) == 1) {
	}
	if(string_pos("savecommand", string_lower(commandstring)) == 1) 
	{
		var code = string_delete(commandstring, 1, 12);
		var i = 0
		if(string_length(code) > 2)
		{
			var baseFilename = COMMANDS_FILE_PATH + "command";
			var filename = baseFilename + string(i) + ".png";
			while(file_exists(filename)) 
			{
			    filename = baseFilename + string(i) + ".png";
			    i++;
			}
			var file = file_text_open_write(filename)
			file_text_write_string(file, code)
			file_text_close(file);
		}
	}
	if(string_pos("startupcommand", string_lower(commandstring)) == 1) 
	{
		var code = string_delete(commandstring,1,15);
		if(string_length(code) > 2)
		{
			var file = file_text_open_write(working_directory + "startupcommand.txt")
			file_text_write_string(file,code)
			file_text_close(file);
		}
	}
	if(string_pos("spawn", string_lower(commandstring)) == 1) 
	{
		var commands = ""
		try{
			commands = string_split(commandstring, " ");
		} catch(err){
			return get_string_async("string splitting failed, aborting...", err);
		}
		var hasarg2 = false
		var hasarg3 = false
		var distance = 0
		var _object = obj_collect
		for(var i = 1; i < array_length(commands); i++) 
		{
			if(i == 2)
			{
					hasarg2 = true
				if(object_exists(asset_get_index(commands[i])))
					_object = asset_get_index(commands[i])
			}
			if(i == 3)
			{
				distance = real(commands[i])
				hasarg3 = true
			}
			if(i >= 3) break
		}
		if(hasarg2 == false) 
		{
			if(is_trigger) 
				instance_create(self.x, self.y, obj_collect) 
			else 
				instance_create(playerid.x, playerid.y - 20, obj_collect)
		} 
		else 
		{	
			if(is_trigger)
			{
				var object = instance_create(self.x + distance, self.y, _object)
			} 
			else 
			{
				if(variable_instance_exists(playerid, "xscale"))
				{
					if(playerid.xscale >= 0) 
						var object = instance_create(playerid.x + distance, playerid.y, _object)
					else 
						var object = instance_create(playerid.x - distance, playerid.y, _object)	
				} 
				else 
					var object = instance_create(playerid.x + distance, playerid.y, _object)
			}
			with(object) 
			{
				for (var i2 = 0; i2 < array_length(global.door_object_arr); i2++) 
				{
					if (global.door_object_arr[i2] == object_index) 
						variable_instance_set(id, "targetRoom", room)
				}
			}
		}
	}
	if(string_pos("player_set_state", string_lower(commandstring)) == 1) 
	{
		var commands = string_split(commandstring, " ");
		for (var i = 1;i < array_length(commands);i++) 
		{
			if(i == 2)
			{
				switch(commands[i])
				{
					case "states.ratmount":
					case "ratmount":
					case "states.knightpep":
					case "knightpep":
					case "states.cheesepep":
					case "cheesepep":
					case "states.rocket":
					case "rocket":
					case "states.mort":
					case "mort":
					case "states.normal":
					case "normal":
					case "states.shotgun":
					case "shotgun":
					case "states.boxxedpep":
					case "boxxedpep":
					case "states.cheeseball":
					case "cheeseball":
					case "states.fireass":
					case "fireass":
					case "states.firemouth":
					case "firemouth":
					case "states.slipnslide":
					case "slipnslide":
					case "states.rideweenie":
					case "rideweenie":
					case "states.ghost":
					case "ghost":
					case "states.debugstate":
					case "debugstate":
					case "states.clownpep":
					case "clownpep":
						show_message_async("WIP")
					break
				}
			}
			if(i >= 2) break
		}
	}
	if(string_pos("instance_set_variable", string_lower(commandstring)) == 1) 
	{
		var commands = string_split(commandstring, " ");
		var ourinstance = undefined
		var tempvarname = undefined
		var tempvartype = undefined
		var tempvarexists = false
		for(var i = 1; i < array_length(commands); i++) 
		{
			if(i == 2)
			{
				if (asset_get_index(commands[i]) != -1)
					ourinstance = asset_get_index(commands[i])
				else
				{
					show_message_async("invalid instance \"" + commands[i] + "\"")
					break
				}
			}
			if(i == 3)
			{
				tempvartype = string(commands[i])
				if(tempvartype != "bool" && tempvartype != "string" && tempvartype != "int" && tempvartype != "float" && tempvartype != "real" && tempvartype != "asset")
				{
					show_message_async("invalid type \"" + commands[i] + "\" Available types: bool, string, int, float, real, asset")
					break
				}
			}
			if(i == 4)
			{
				tempvarname = commands[i]
				if(!variable_instance_exists(ourinstance,tempvarname))
				{
					show_message_async("variable \"" + commands[i] + "\" does not exist.")
					break
				}
			}
			if(i == 5)
			{
				switch(tempvartype)
				{
					case "bool":
						if(is_bool(bool(commands[i])))
						{
							variable_instance_set(ourinstance,tempvarname,bool(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set bool")
						}
					break
					case "int":
						if(is_int64(int64(commands[i])))
						{
							variable_instance_set(ourinstance,tempvarname,int64(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set int")
						}
					break
					case "float":
					case "real":
						if(is_real(real(commands[i])))
						{
							variable_instance_set(ourinstance,tempvarname,real(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set real")
						}
					break
					case "string":
						if(is_string(commands[i]))
						{
							variable_instance_set(ourinstance,tempvarname,commands[i])
							if(!silentcommand)
								show_message_async("successfully set string")
						}
					break
					case "asset":
						if(asset_get_index(commands[i]) > -1)
						{
							variable_instance_set(ourinstance,tempvarname,asset_get_index(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set asset")
						}
					break
				}
			}
			if(i >= 5) break
		}
	}
	if(string_pos("instance_set_variable_all", string_lower(commandstring)) == 1) 
	{
		var commands = string_split(commandstring, " ");
		var ourinstance = undefined
		var tempvarname = undefined
		var tempvartype = undefined
		var tempvarexists = false
		for(var i = 1; i < array_length(commands); i++) 
		{
			if(i == 2)
			{
				if (asset_get_index(commands[i]) != -1)
					ourinstance = asset_get_index(commands[i])
				else
				{
					show_message_async("invalid instance \"" + commands[i] + "\"")
					break
				}
			}
			if(i == 3)
			{
				tempvartype = string(commands[i])
				if(tempvartype != "bool" && tempvartype != "string" && tempvartype != "int" && tempvartype != "float" && tempvartype != "real" && tempvartype != "asset")
				{
					show_message_async("invalid type \"" + commands[i] + "\" Available types: bool, string, int, float, real, asset")
					break
				}
			}
			if(i == 4)
			{
				tempvarname = commands[i]
				if(!variable_instance_exists(ourinstance,tempvarname))
				{
					show_message_async("variable \"" + commands[i] + "\" does not exist.")
					break
				}
			}
			if(i == 5)
			{
				switch(tempvartype)
				{
					case "bool":
						if(is_bool(bool(commands[i])))
						{
							with(ourinstance)
								variable_instance_set(id,tempvarname,bool(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set bool")
						}
					break
					case "int":
						if(is_int64(int64(commands[i])))
						{
							with(ourinstance)
								variable_instance_set(id,tempvarname,int64(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set int")
						}
					break
					case "float":
					case "real":
						if(is_real(real(commands[i])))
						{
							with(ourinstance)
								variable_instance_set(id,tempvarname,real(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set real")
						}
					break
					case "string":
						if(is_string(commands[i]))
						{
							with(ourinstance)
								variable_instance_set(id,tempvarname,commands[i])
							if(!silentcommand)
								show_message_async("successfully set string")
						}
					break
					case "asset":
						if(asset_get_index(commands[i]) > -1)
						{
							with(ourinstance)
								variable_instance_set(id,tempvarname,asset_get_index(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set asset")
						}
					break
				}
			}
			if(i >= 5) break
		}
	}
	if(string_pos("global_set_variable", string_lower(commandstring)) == 1) 
	{
		var commands = string_split(commandstring, " ");
		var tempvartype = undefined
		var tempvarname = undefined
		var tempvarexists = false
		for (var i = 1;i < array_length(commands);i++) 
		{
			if(i == 2)
			{
				tempvartype = string(commands[i])
				if(tempvartype != "bool" && tempvartype != "string" && tempvartype != "int" && tempvartype != "float" && tempvartype != "real" && tempvartype != "asset")
				{
					show_message_async("invalid type \"" + commands[i] + "\"")
					break
				}
			}
			if(i == 3)
			{
				tempvarname = commands[i]
				if(!variable_global_exists(tempvarname))
				{
					show_message_async("variable \"" + commands[i] + "\" does not exist.")
					break
				}
			}
			if(i == 4)
			{
				switch(tempvartype)
				{
					case "bool":
						if(is_bool(bool(commands[i])))
						{
							variable_global_set(tempvarname,bool(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set bool.")
						}
					break
					case "int":
						if(is_int64(int64(commands[i])))
						{
							variable_global_set(tempvarname,int64(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set int.")
						}
					break
					case "float":
					case "real":
						if(is_real(real(commands[i])))
						{
							variable_global_set(tempvarname,real(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set real.")
						}
					break
					case "string":
						if(is_string(commands[i]))
						{
							variable_global_set(tempvarname,commands[i])
							if(!silentcommand)
								show_message_async("successfully set string.")
						}
					break
					case "asset":
						if(asset_get_index(commands[i]) > -1)
						{
							variable_global_set(tempvarname,asset_get_index(commands[i]))
							if(!silentcommand)
								show_message_async("successfully set asset.")
						}
					break
				}
			}
			if (i >= 4) break
		}
	}		
	if(string_pos("exec", string_lower(commandstring)) == 1) {
		var _filename = string_delete(commandstring, 0, 5);
		if(os_type == os_android)
		{
			if(file_exists(_filename)) 
			{
				var _file = buffer_load(_filename);
				var _cmd = buffer_read(_file, buffer_string);
				buffer_delete(_file);
				if(string_pos("*",_cmd) == 1)
					_cmd = base64_decode(string_delete(_cmd,1,1))
				processcommand(_cmd,true)
				//TODO: test if this even works
			} 
			else 
				show_message_async("No commands file found at: " + _filename)
		} 
		else 
		{
			file = get_open_filename("commands file|*.txt|*.png", "");
			if (file != "")
			{
				var _file = buffer_load(file);
				var _cmd = buffer_read(_file, buffer_string);
				buffer_delete(_file);
				processcommand(_cmd,true)
			}
		}
	}
	switch (string_lower(commandstring)) 
	{
		case "noclip":
			obj_parent_player.state = PlayerState.noclip
			break
		case "showcollision":
		case "showcollisions":
			global.showcollisions = !global.showcollisions
			event_perform_object(obj_virtual_controller_manager, ev_other, ev_room_start)
		break
		case "showcollision true":
		case "showcollisions true":
			global.showcollisions = true
			event_perform_object(obj_virtual_controller_manager, ev_other, ev_room_start)
		break
		case "showcollision false":
		case "showcollisions false":
			global.showcollisions = false
			event_perform_object(obj_virtual_controller_manager, ev_other, ev_room_start)
		break
		case "hidetile":
		case "hidetiles":
			layer_set_visible(layer_get_id("Tiles_BG"),false)
			layer_set_visible(layer_get_id("Tiles_BG2"),false)
			layer_set_visible(layer_get_id("Tiles_BG3"),false)
			layer_set_visible(layer_get_id("Tiles_1"),false)
			layer_set_visible(layer_get_id("Tiles_2"),false)
			layer_set_visible(layer_get_id("Tiles_3"),false)
			layer_set_visible(layer_get_id("Tiles_Foreground1"),false)
			layer_set_visible(layer_get_id("Tiles_Foreground2"),false)
			layer_set_visible(layer_get_id("Tiles_Foreground3"),false)
		break
		case "showtile":
		case "showtiles":
			global.hidetiles = false
			layer_set_visible(layer_get_id("Tiles_BG"),true)
			layer_set_visible(layer_get_id("Tiles_BG2"),true)
			layer_set_visible(layer_get_id("Tiles_BG3"),true)
			layer_set_visible(layer_get_id("Tiles_1"),true)
			layer_set_visible(layer_get_id("Tiles_2"),true)
			layer_set_visible(layer_get_id("Tiles_3"),true)
			layer_set_visible(layer_get_id("Tiles_Foreground1"),true)
			layer_set_visible(layer_get_id("Tiles_Foreground2"),true)
			layer_set_visible(layer_get_id("Tiles_Foreground3"),true)
		break
		case "toggletile":
		case "toggletiles":
			global.hidetiles = !global.hidetiles
				layer_set_visible(layer_get_id("Tiles_BG"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_BG2"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_BG3"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_1"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_2"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_3"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_Foreground1"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_Foreground2"),global.hidetiles)
				layer_set_visible(layer_get_id("Tiles_Foreground3"),global.hidetiles)
		break
		case "character noise":
			scr_player_changeCharacter(obj_parent_player, Characters.Pizzelle)
		break
		case "togglebinds":
			global.showbinds = !global.showbinds
		break
		case "help":
			get_string_async("Available Commands: ","showcollisions <boolean>, panic <seconds>, hidetiles, showtiles, toggletiles, character <string>, instance_set_variable <obj_> <type> <variablename> <new value>,global_set_variable <type> <variablename> <new value>,spawn <obj_> <optional distance>, togglebinds,instance_set_variable_all <obj_> <type> <variablename> <new value>, exec <filename>, savecommand <commands>")
		break
	}
}

// TODO: Rewrite this function, it sucks.
function createvbutton(loadedbutton){
	with(instance_create_depth(0, 0, depth, obj_virtual_controller)) {
		if(variable_struct_exists(loadedbutton,"x")){
			x = loadedbutton.x
		}
		if(variable_struct_exists(loadedbutton,"y")){
			y = loadedbutton.y
		}
		if(variable_struct_exists(loadedbutton,"bklock")){
			buttonlockable = loadedbutton.bklock
		} else{
			buttonlockable = false
		}
		if(variable_struct_exists(loadedbutton,"image_angle")){
			image_angle = loadedbutton.image_angle
		}
		
		mysprite = spr_button_z_big
		if(variable_struct_exists(loadedbutton,"sprite_name")){
			if(sprite_exists(asset_get_index(loadedbutton.sprite_name))){
				mysprite = asset_get_index(loadedbutton.sprite_name)
			}
		}
		sprite_index = mysprite
		
		spr_pressed = mysprite
		if(variable_struct_exists(loadedbutton,"sprite_name_pressed")){
			if(sprite_exists(asset_get_index(loadedbutton.sprite_name_pressed))){
				spr_pressed = asset_get_index(loadedbutton.sprite_name_pressed)
			}
		}
		
		if(variable_struct_exists(loadedbutton,"image_xscale")){
			image_xscale = loadedbutton.image_xscale
		}
		if(variable_struct_exists(loadedbutton,"image_index")){
			image_index = loadedbutton.image_index
		}
		if(variable_struct_exists(loadedbutton,"image_yscale")){
			image_yscale = loadedbutton.image_yscale
		}
		if(variable_struct_exists(loadedbutton,"image_speed")){
			image_speed = loadedbutton.image_speed
		}
		
		realcolor = c_white
		if(variable_struct_exists(loadedbutton,"realcolor")){
			image_blend = loadedbutton.realcolor
			realcolor = loadedbutton.realcolor
		}
		
		myusualalpha = 0.5
		image_alpha = 0.5
		if(variable_struct_exists(loadedbutton,"balpha")){
			myusualalpha = loadedbutton.balpha
			image_alpha = loadedbutton.balpha
		}
		
		
		pressed_color = realcolor
		if(variable_struct_exists(loadedbutton,"bk")){
			if(string(loadedbutton.bk) != "null") {
				keycode = loadedbutton.bk
				// legacy stuff
				if(keycode == "shift_dash_lock")
				{
					pressed_color = make_color_rgb(255, 0, 0)
				}
			}
		}
		
		if(variable_struct_exists(loadedbutton,"pressed_color")){
			pressed_color = loadedbutton.pressed_color
		}
		
		if(variable_struct_exists(loadedbutton,"bk2")){
			if(string(loadedbutton.bk2) != "null") {
				keycode2 = loadedbutton.bk2
				forceshowbind = (string_pos("togglebinds", keycode2) == 1)
			}
		}
		
		if(variable_struct_exists(loadedbutton,"spr_joystick")){
			spr_joystick = loadedbutton.spr_joystick
		}
		
		if(variable_struct_exists(loadedbutton,"stick_xscale")){
			stick_xscale = loadedbutton.stick_xscale
		}
		
		if(variable_struct_exists(loadedbutton,"stick_yscale")){
			stick_yscale = loadedbutton.stick_yscale
		}
		
		if(variable_struct_exists(loadedbutton,"joy_x")){
			joy_x = loadedbutton.joy_x
		}
		
		if(variable_struct_exists(loadedbutton,"joy_y")){
			joy_y = loadedbutton.joy_y
		}
		
		if(variable_struct_exists(loadedbutton,"joy_deadzone_x")){
			joy_deadzone_x = loadedbutton.joy_deadzone_x
		}
		
		if(variable_struct_exists(loadedbutton,"joy_deadzone_y")){
			joy_deadzone_y = loadedbutton.joy_deadzone_y
		}
		
		if(variable_struct_exists(loadedbutton,"joy_blend")){
			joy_blend = loadedbutton.joy_blend
		}
		radius = sprite_width / 2
		vkey_init_input()
	}
}
function virtual_key_save(export = false) {
	var mybuttons = array_create(0)
	with(obj_virtual_controller) {
		if (!is_string(keycode) && !is_string(keycode2) || keycode == "debug" || keycode == "bind" || keycode == "joystick") {
			var buttonproperties = {
				bk: keycode,
				bk2: keycode2,
				bklock: buttonlockable,
				x: x,
				y: y,
				image_angle: image_angle,
				image_xscale: image_xscale,
				image_yscale: image_yscale,
				image_speed: image_speed,
				image_index: image_index,
				realcolor: realcolor,
				pressed_color: pressed_color,
				balpha: myusualalpha,
				sprite_name: sprite_get_name(mysprite)
			}
			if(keycode == "joystick")
			{
				buttonproperties.spr_joystick = spr_joystick
				buttonproperties.stick_xscale = stick_xscale
				buttonproperties.stick_yscale = stick_yscale
				buttonproperties.joy_x = joy_x
				buttonproperties.joy_y = joy_y
				buttonproperties.joy_deadzone_x = joy_deadzone_x
				buttonproperties.joy_deadzone_y = joy_deadzone_y
				buttonproperties.joy_blend = joy_blend
			}
			if(sprite_exists(spr_pressed))
				buttonproperties.sprite_name_pressed = sprite_get_name(spr_pressed)
			array_push(mybuttons,buttonproperties)
		}
	}
	if(is_string(export)){
		var buttonstring = json_stringify(mybuttons)
		if(os_type == os_android){
			var buttonbuffer = buffer_create(string_byte_length(buttonstring) + 1, buffer_fixed, 1)
			buffer_write(buttonbuffer, buffer_string, buttonstring)
			var i = 0;
			var baseFilename = CONTROLS_FILE_PATH + export;
			var filename = baseFilename + string(i) + ".png";
			while(file_exists(filename)) {
			    filename = baseFilename + string(i) + ".png";
			    i++;
			}
			buffer_save(buttonbuffer, filename)
			show_message_async("Controls saved to: " + filename)
			clipboard_set_text(buttonstring)
			buffer_delete(buttonbuffer)
		} else {
			get_string_async("Controls Save Code: ", json_stringify(mybuttons))
		}
		return
	}
	if(export) {
		get_string_async("Controls Save Code: ", json_stringify(mybuttons))
		clipboard_set_text(json_stringify(mybuttons))
		return
	}
	var buttonstring = json_stringify(mybuttons)
	var buttonbuffer = buffer_create(string_byte_length(buttonstring) + 1, buffer_fixed, 1)
	buffer_write(buttonbuffer, buffer_string, buttonstring)
	buffer_save(buttonbuffer, "buttonpositions.save")
	buffer_delete(buttonbuffer)
}
function virtual_key_load(buttonstring2 = "") {
	if (file_exists("buttonpositions.save") && buttonstring2 == "") || (file_exists("buttonpositions.save") && buttonstring2 == "load") {
		with(obj_virtual_controller) {
			if (!is_string(keycode) && !is_string(keycode2) || keycode == "debug" || keycode == "bind" || keycode == "joystick") {
				instance_destroy()
			}
		}
		var buttonbuffer = buffer_load("buttonpositions.save")
		var buttonstring = buffer_read(buttonbuffer, buffer_string)
		buffer_delete(buttonbuffer)
		
		var buttonload = json_parse(buttonstring)
		while(array_length(buttonload) > 0) {
			var loadedbutton = array_pop(buttonload)
			createvbutton(loadedbutton)
		}
	} else {
		with(obj_virtual_controller) {
			if (!is_string(keycode) && !is_string(keycode2) || keycode == "debug" || keycode == "bind" || keycode == "joystick") {
					instance_destroy()
			}
		}
		var buttonload = ""
		if(os_type == os_android){
			// use png cause of android 14 being too stingy regarding apps to read files.
			// TODO: Tell the player the existence of this feature.
			if(string_pos_ext(".png",buttonstring2,string_length(buttonstring2)-4) != 0){
				var filepath = CONTROLS_FILE_PATH + buttonstring2
				if(file_exists(filepath)){
					var buttonbuffer = buffer_load(CONTROLS_FILE_PATH + buttonstring2)
					var buttonstring = buffer_read(buttonbuffer, buffer_string)
					buffer_delete(buttonbuffer)
					
					var buttonload = json_parse(buttonstring)
					while(array_length(buttonload) > 0) {
						var loadedbutton = array_pop(buttonload)
						createvbutton(loadedbutton)
					}
				} else {
					show_message_async("No file exists at: " + CONTROLS_FILE_PATH + buttonstring2)
				}
				return;
			}
		}
		if(buttonstring2 != "" && buttonstring2 != "default") {
			buttonload = json_parse(buttonstring2)
		} else {
			buttonload = json_parse("[ { \"x\": 928.0, \"sprite_name\": \"spr_button_escape_big\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 0.0, \"image_index\": 0.5, \"y\": 32.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_button_escape_big\", \"image_yscale\": 1.0, \"bk\": 27.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 896.0, \"sprite_name\": \"spr_button_shift_big\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 0.0, \"image_index\": 0.5, \"y\": 416.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_button_shift_big\", \"image_yscale\": 1.0, \"bk\": 16.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 800.0, \"sprite_name\": \"spr_button_c_big\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 0.0, \"image_index\": 0.5, \"y\": 480.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_button_c_big\", \"image_yscale\": 1.0, \"bk\": 67.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 800.0, \"sprite_name\": \"spr_button_z_big\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 0.0, \"image_index\": 0.5, \"y\": 352.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_button_z_big\", \"image_yscale\": 1.0, \"bk\": 90.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 704.0, \"sprite_name\": \"spr_button_x_big\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 0.0, \"image_index\": 0.5, \"y\": 416.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_button_x_big\", \"image_yscale\": 1.0, \"bk\": 88.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 240.0, \"sprite_name\": \"spr_virtual_controller\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": -90.0, \"image_index\": 0.5, \"y\": 416.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_virtual_controller\", \"image_yscale\": 1.0, \"bk\": 39.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 144.0, \"sprite_name\": \"spr_virtual_controller\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 0.0, \"image_index\": 0.5, \"y\": 352.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_virtual_controller\", \"image_yscale\": 1.0, \"bk\": 38.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 144.0, \"sprite_name\": \"spr_virtual_controller\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 180.0, \"image_index\": 0.5, \"y\": 480.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_virtual_controller\", \"image_yscale\": 1.0, \"bk\": 40.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 48.0, \"sprite_name\": \"spr_virtual_controller\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": -270.0, \"image_index\": 0.5, \"y\": 416.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_virtual_controller\", \"image_yscale\": 1.0, \"bk\": 37.0, \"image_speed\": 1.0, \"bklock\": 0.0 }, { \"x\": 64.0, \"sprite_name\": \"spr_button_z_big\", \"image_xscale\": 1.0, \"balpha\": 0.5, \"pressed_color\": 16777215.0, \"bk2\": null, \"image_angle\": 0.0, \"image_index\": 0.5, \"y\": 288.0, \"realcolor\": 16777215.0, \"sprite_name_pressed\": \"spr_button_z_big\", \"image_yscale\": 1.0, \"bk\": 90.0, \"image_speed\": 1.0, \"bklock\": 0.0 } ]")
		}
		while(array_length(buttonload) > 0) {
			var loadedbutton = array_pop(buttonload)
			createvbutton(loadedbutton)
		}
	}
}

function processedit(commandstring) {
	var _string = string_trim(commandstring)
	if (string_pos(";", _string) != 0) {
		var _commands = string_split(_string + ";",";")
		var i = 0
		while (i < array_length(_commands)) {
			doedit(_commands[i])
			i++
		}
	} else{
			doedit(_string)
	}
}

function doedit(commandstring){
	if (string_pos("gridsize", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _gridsize = 0 // default
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					_gridsize = real(commands[i])
					if(_gridsize <= 1){
						_gridsize = 1
					}
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			global.vkeysgrid_size = _gridsize
		}
		return
	}
	if (global.selectedvbutton == undefined) {
		return show_message_async("A button is not selected.")
	}
	if (string_pos("color", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _red = 0
		var _green = 0
		var _blue = 0
		var _error = false
		for (var i = 1;i < array_length(commands);i++) {
			if(i == 2){
				try{_red = int64(commands[i])}catch(err){_error = true}
				argcount++
			}
			if(i == 3){
				try{_green = int64(commands[i])}catch(err){_error = true}
				argcount++
			}
			if(i == 4){
				try{_blue = int64(commands[i])}catch(err){_error = true}
				argcount++
			}
			if(i >= 4){
				break
			}
		}
		if(_error)
			show_message_async("usage: \"color 255 0 0\" in RGB format.")
		if(argcount == 3){
			with(global.selectedvbutton){
				realcolor = make_color_rgb(_red, _green, _blue)
			}
		}
	}
	if (string_pos("pressed_color", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _red = 0
		var _green = 0
		var _blue = 0
		var _error = false
		for (var i = 1;i < array_length(commands);i++) {
			if(i == 2){
				try{_red = int64(commands[i])}catch(err){_error = true}
				argcount++
			}
			if(i == 3){
				try{_green = int64(commands[i])}catch(err){_error = true}
				argcount++
			}
			if(i == 4){
				try{_blue = int64(commands[i])}catch(err){_error = true}
				argcount++
			}
			if(i >= 4){
				break
			}
		}
		if(_error)
			show_message_async("usage: \"pressed_color 255 0 0\" in RGB format.")
		if(argcount == 3){
			with(global.selectedvbutton){
				pressed_color = make_color_rgb(_red, _green, _blue)
			}
		}
	}
	if (string_pos("scale_x", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _scale = 1
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					_scale = real(commands[i])
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			with(global.selectedvbutton){
				/*var spr_name = sprite_get_name(sprite_index)
				if(string_pos("spr_button_", spr_name) == 1)
				{
					if(sprite_index != spr_button_goingidle && sprite_index != spr_button_goingpressed && sprite_index != spr_button_idle &&sprite_index != spr_button_pressed)
					{
						if(_scale >= 1.5 || _scale <= -1.5 )
						{
							var asset = asset_get_index(spr_name + "_big")
							if(sprite_exists(asset))
							{
								sprite_index = asset
								mysprite = asset
							}
						}
					}
				}*/
				image_xscale = _scale
				if(keycode == "joystick")
					radius = sprite_width / 2
			}
		}
		return;
	}
	if (string_pos("scale_y", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _scale = 1
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					_scale = real(commands[i])
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			with(global.selectedvbutton){
				/*var spr_name = sprite_get_name(sprite_index)
				if(string_pos("spr_button_", spr_name) == 1)
				{
					if(sprite_index != spr_button_goingidle && sprite_index != spr_button_goingpressed && sprite_index != spr_button_idle &&sprite_index != spr_button_pressed)
					{
						if(_scale >= 1.5 || _scale <= -1.5 )
						{
							var asset = asset_get_index(spr_name + "_big")
							if(sprite_exists(asset))
							{
								sprite_index = asset
								mysprite = asset
							}
						}
					}
				}*/
				image_yscale = _scale
			}
		}
		return;
	}
	if (string_pos("scale", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _scale = 1
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					_scale = real(commands[i])
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			with(global.selectedvbutton){
				/*var spr_name = sprite_get_name(sprite_index)
				if(string_pos("spr_button_", spr_name) == 1)
				{
					if(sprite_index != spr_button_goingidle && sprite_index != spr_button_goingpressed && sprite_index != spr_button_idle &&sprite_index != spr_button_pressed)
					{
						if(_scale >= 1.5 || _scale <= -1.5 )
						{
							var asset = asset_get_index(spr_name + "_big")
							if(sprite_exists(asset))
							{
								sprite_index = asset
								mysprite = asset
							}
						}
					}
				}*/
				image_xscale = _scale
				image_yscale = _scale
				if(keycode == "joystick")
					radius = sprite_width / 2
			}
		}
	}
	if (string_pos("alpha", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _alpha = 1
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					_alpha = real(commands[i])
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			with(global.selectedvbutton){
				myusualalpha = _alpha
				image_alpha = _alpha
			}
		}
	}
	if (string_pos("sprite", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _sprite = spr_button_z_big
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					if(sprite_exists(asset_get_index(commands[i]))){
						_sprite = asset_get_index(commands[i])
					}
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			with(global.selectedvbutton){
				if(keycode == "joystick")
					radius = sprite_width / 2
				sprite_index = _sprite
				mysprite = _sprite
			}
		}
	}
	if(global.selectedvbutton.keycode == "joystick")
	{
		if (string_pos("stick_sprite", string_lower(commandstring)) == 1) {
			var commands = string_split(commandstring, " ");
			var argcount = 0
			var _sprite = spr_button_joystick
			for (var i = 1;i < array_length(commands);i++) {
					if(i == 2){
						if(sprite_exists(asset_get_index(commands[i]))){
							_sprite = asset_get_index(commands[i])
						}
						argcount++
					}
					if(i >= 2){
						break
					}
			}
			if(argcount == 1){
				with(global.selectedvbutton){
					spr_joystick = _sprite
				}
			}
		}
		if (string_pos("stick_scale_x", string_lower(commandstring)) == 1) {
			var commands = string_split(commandstring, " ");
			var argcount = 0
			var _scale = 1
			for (var i = 1;i < array_length(commands);i++) {
					if(i == 2){
						_scale = real(commands[i])
						argcount++
					}
					if(i >= 2){
						break
					}
			}
			if(argcount == 1){
				with(global.selectedvbutton){
					stick_xscale = _scale
				}
			}
			return;
		}
		if (string_pos("stick_scale_y", string_lower(commandstring)) == 1) {
			var commands = string_split(commandstring, " ");
			var argcount = 0
			var _scale = 1
			for (var i = 1;i < array_length(commands);i++) {
					if(i == 2){
						_scale = real(commands[i])
						argcount++
					}
					if(i >= 2){
						break
					}
			}
			if(argcount == 1){
				with(global.selectedvbutton){
					stick_yscale = _scale
				}
			}
			return;
		}
		if (string_pos("stick_scale", string_lower(commandstring)) == 1) {
			var commands = string_split(commandstring, " ");
			var argcount = 0
			var _scale = 1
			for (var i = 1;i < array_length(commands);i++) {
					if(i == 2){
						_scale = real(commands[i])
						argcount++
					}
					if(i >= 2){
						break
					}
			}
			if(argcount == 1){
				with(global.selectedvbutton){
					stick_xscale = _scale
					stick_yscale = _scale
				}
			}
		}
		if (string_pos("stick_deadzone_x", string_lower(commandstring)) == 1) {
			var commands = string_split(commandstring, " ");
			var argcount = 0
			var _deadzone_x = 0.5
			for (var i = 1;i < array_length(commands);i++) {
					if(i == 2){
						_deadzone_x = real(commands[i])
						argcount++
					}
					if(i >= 2){
						break
					}
			}
			if(argcount == 1){
				with(global.selectedvbutton){
					joy_deadzone_x = clamp(_deadzone_x, 0, 1)
				}
			}
		}
		if (string_pos("stick_deadzone_y", string_lower(commandstring)) == 1) {
			var commands = string_split(commandstring, " ");
			var argcount = 0
			var _deadzone_y = 0
			for (var i = 1;i < array_length(commands);i++) {
					if(i == 2){
						_deadzone_y = real(commands[i])
						argcount++
					}
					if(i >= 2){
						break
					}
			}
			if(argcount == 1){
				with(global.selectedvbutton){
					joy_deadzone_y = clamp(_deadzone_y, 0, 1)
				}
			}
		}
		if (string_pos("stick_color", string_lower(commandstring)) == 1) {
			var commands = string_split(commandstring, " ");
			var argcount = 0
			var _red = 0
			var _green = 0
			var _blue = 0
			var _error = false
			for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					try{_red = int64(commands[i])}catch(err){_error = true}
					argcount++
				}
				if(i == 3){
					try{_green = int64(commands[i])}catch(err){_error = true}
					argcount++
				}
				if(i == 4){
					try{_blue = int64(commands[i])}catch(err){_error = true}
					argcount++
				}
				if(i >= 4){
					break
				}
			}
			if(_error)
				show_message_async("usage: \"stick_color 255 0 0\" in RGB format.")
			if(argcount == 3){
				with(global.selectedvbutton){
					joy_blend = make_color_rgb(_red, _green, _blue)
				}
			}
		}
	}
	if (string_pos("image_speed", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _speed = 0.35 // default
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					_speed = real(commands[i])
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			with(global.selectedvbutton){
				image_speed = _speed
			}
		}
	}
	if (string_pos("framenumber", string_lower(commandstring)) == 1) {
		var commands = string_split(commandstring, " ");
		var argcount = 0
		var _imageindex = 0 // default
		for (var i = 1;i < array_length(commands);i++) {
				if(i == 2){
					_imageindex = real(commands[i])
					argcount++
				}
				if(i >= 2){
					break
				}
		}
		if(argcount == 1){
			with(global.selectedvbutton){
				image_index = _imageindex
			}
		}
	}
}
function vkey_init_input()
{
	if(keycode == "joystick")
	{
		input = function (_touch_id, _touch_x, _touch_y, _click)
		{
			if(_click)
			{
				if(global.forceshowcontrols || !global.forcehidecontrols)
				{
					if (!global.movingvkeys) 
					{
						touch_id = _touch_id
					}
				}
			}
		}
	}
	if(keycode == "bind")
	{
		input = function (_touch_id, _touch_x, _touch_y, _click)
		{
			if(_click)
			{
				if(global.forceshowcontrols || !global.forcehidecontrols)
				{
					if (!global.movingvkeys) 
					{
						if(global.showbinds || forceshowbind)
						{
							processcommand(keycode2,true)
						}
					}
				}
			}
		}
	}
	if(buttonlockable) 
	{
		input = function (_touch_id, _touch_x, _touch_y, _click)
		{
			if(_click)
			{
				if(global.forceshowcontrols || !global.forcehidecontrols)
				{
					if(!global.movingvkeys)
					{
						var _func = pressed ? keyboard_key_release : keyboard_key_press
						if(!is_string(keycode) && keycode != undefined) 
						{
							_func(keycode)
						}
						if(!is_string(keycode2) && keycode2 != undefined) 
						{
							_func(keycode2)
						}
						pressed = !pressed
					}
				}
			}
		}
	}
}