var spritetoget = get_string_async("Sprite To Export", ""),run = true,i = 0,prefix = true,directories = false,j = 0
while (run) {if (sprite_exists(i)) {run = true;}else {run = false;}i += 1;}
for (var j = 0; j < i; j += 1){if sprite_exists(j) && (sprite_get_name(j) == spritetoget) && sprite_get_texture(j, 0) != pointer_null{if directories == 1{var path = "/exports/" + sprite_get_name(j) +"/";}else{var path = "/exports/";}
		var sprite_variable = sprite_duplicate(j);
        if prefix == 1
        {
		sprite_save_strip(sprite_variable, path + sprite_get_name(j) + "_strip" + string(sprite_get_number(j)) + ".png");
        }
        else
        {
		sprite_save_strip(sprite_variable, path + sprite_get_name(j) + ".png");
        }
		sprite_delete(sprite_variable)
		show_message("Exported " + sprite_get_name(j))
		}
		else
		{
			continue;
		}
	}