if(event.alarms[3][0] == "")
	return;
if(event.alarms[3][1] != undefined)
	if(live_snippet_call(event.alarms[0][1])){}else{get_string_async("AN ERROR HAS OCCURRED", live_result)}