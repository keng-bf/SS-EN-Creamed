if(draw_event != "" && draw_event != "draw_self()"){
	if(draw_event_saved != undefined){
				if(live_snippet_call(draw_event_saved)){}else{get_string_async("AN ERROR HAS OCCURRED", live_result)}
	}
} else {
	draw_self()
}