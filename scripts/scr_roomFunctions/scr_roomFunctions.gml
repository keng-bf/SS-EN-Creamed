global.NextRoom = rm_missing

function room_goto_fixed(index)
{
	global.NextRoom = index
	room_goto(index)
}
function is_preGame(arg0 = room)
{
	var special_rooms = [rm_preinitializer, rm_initializer, rm_startupLogo, rm_introVideo, rm_mainmenu, rm_credits, rm_disclaimer]
	return array_contains(special_rooms, arg0);
}

function scr_roomcheck(arg0 = room)
{
	var special_rooms = [rm_initializer, rm_preinitializer, rm_startupLogo, rm_devroom, rm_introVideo, rank_room, timesuproom, rm_mainmenu, rm_credits, rm_disclaimer, rm_blank]
	return !array_contains(special_rooms, arg0);
}

function is_hub(arg0 = room)
{
	var hub_rooms = [hub_soundTest, hub_demohallway, hub_paintstudio, hub_molasses, hub_mindpalace, hub_mindvault, rm_credits, internship_floor1, internship_floor2, tower_1, tower_2, tower_3, tower_4, tower_5]
	return array_contains(hub_rooms, arg0);
}

function is_tutorial(arg0 = room)
{
	var tut_rooms = [tutorial_1, tutorial_2, tutorial_3, tutorial_4, tutorial_5]
	return array_contains(tut_rooms, arg0);
}
function scr_gamecaptions(arg0 = room)
{
	var game_caption = undefined
	
	switch (arg0)
	{
		case rm_preinitializer:
		case rm_initializer:
			game_caption = "winname_init"
			break
		
		case rm_startupLogo:
			game_caption = "winname_logos"
			break
		
		case rm_disclaimer:
			game_caption = "winname_disclaimer"
			break
		
		case rm_introVideo:
			game_caption = "winname_intro"
			break
		
		case rm_mainmenu:
			game_caption = "winname_fileselect"
			break
		
		case rm_devroom:
			game_caption = "winname_devroom"
			break
		
		case rank_room:
			game_caption = "winname_rank"
			break
		
		case rm_credits:
			game_caption = "winname_credit"
			break
		
		case hub_paintstudio:
		case hub_demohallway:
		case hub_molassesB:
		case hub_molasses:
			game_caption = "winname_hub"
			break
		
		case hub_mindpalace:
			game_caption = "winname_mind"
			break
		
		case tutorial_1:
			game_caption = "winname_tutorial"
			break
		
		case entryway_1:
			game_caption = "winname_entryway"
			break
		
		case steamy_1:
			game_caption = "winname_cotton"
			break
		
		case mineshaft_1:
			game_caption = "winname_mines"
			break
		
		case mountain_intro:
			game_caption = "Sky High Exhibition Night!"
			break
		
		case molasses_1:
			game_caption = "winname_swamp"
			break
		
		case cafe_1:
			game_caption = "Early Morning Sugary Spire"
			break
	}
	
	if (instance_exists(obj_titlecard))
		game_caption = "winname_titlecard"
	
	if (lang_key_exists(game_caption))
		return lang_get(game_caption);
	else
		return game_caption;
}

function scr_roomnames(arg0 = room)
{
	var room_name = "NO ROOMNAME FOUND-1265"
	
	switch (arg0)
	{
		case rm_missing:
			room_name = "romname_missing"
			break
		
		case hub_paintstudio:
			room_name = "romname_mainhub"
			break
		
		case hub_demohallway:
			room_name = "romname_hallway"
			break
		
		case hub_molasses:
			room_name = "romname_molasses"
			break
		
		default:
			room_name = "NO ROOMNAME FOUND-1265"
			break
	}
	
	if (lang_key_exists(room_name))
		return lang_get(room_name);
	else
		return room_name;
}

