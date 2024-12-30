var lang_key, lang_key_desc, scrib;

if (!global.ShowHUD)
    exit;

lang_key = global.CharacterPalette[global.playerCharacter].palettes[global.PlayerPaletteIndex].palName;
lang_key_desc = lang_get(string("{0}_desc", lang_key));
scrib = scribble(string("[fa_center][spr_promptfont][fa_bottom][alpha,{0}]{1}\n{2}", alpha, lang_get(lang_key), lang_key_desc));
scrib.wrap(camera_get_view_width(view_camera[0]) - 200);
scrib.draw(480, 524);
