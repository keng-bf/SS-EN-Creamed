var music_desc, bonus, c, npspr;

music_desc = musicArray[currentSelection].songDescription;
bonus = ["Aw, Fudge! (Bonus) - Pteracotta", "Fudge It All! (Bonus) - RodMod", "A Mountain Secret (Bonus) - Various", "Run the Dog (Bonus) - PaperKitty", "Sugarcube Hailstorm (Bonus) - PaperKitty", "Painter's Theme (Bonus) - CableChords", "What's that Smell? (Bonus) - PaperKitty", "Painter's Brain - Stewart Keller", "Painter's Mixtape - Stewart Keller", "Samba de Spire - PaperKitty"];
draw_set_font(global.npcfont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
c = 0;
npspr = spr_nowplaying;

if (array_contains(bonus, music_desc))
{
    c = 16777215;
    npspr = spr_nowplayingbonus;
}

draw_sprite(npspr, image_index, room_width / 2, 0);
scribble(music_desc).starting_format(font_get_name(global.npcfont), c).align(1, 1).draw(room_width / 2, 62);
