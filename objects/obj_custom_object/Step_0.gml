if(step_event != ""){
	if(step_event_saved != undefined){
				if(live_snippet_call(step_event_saved)){}else{get_string_async("AN ERROR HAS OCCURRED", live_result)}
	}
}
if(spriteids)
{
	sprite_index = sprite
}
else if(asset_get_index(sprite) != -1 && sprite_exists(asset_get_index(sprite)))
{
		sprite_index = asset_get_index(sprite)
}