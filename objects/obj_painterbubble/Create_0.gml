var k, dg, palette_array, i, key;

image_speed = 0.35;
fade = 0;
bufferThought = lang_get("demopainter_thoughtbuffer");
bufferLength = string_length(bufferThought) + 1;
idleThoughts = [];
idleThought = 0;
usePaletteThought = false;
paletteThoughts = [];
savedPaletteIndex = global.PlayerPaletteIndex;
buffering = false;
bufferCooldown = 0;
typist = scribble_typist();
typist.pause();
typist.in(0.25, 1);

for (k = 1; lang_key_exists(string("demopainter_idlethought_{0}", k)); k++)
{
    dg = lang_get(string("demopainter_idlethought_{0}", k));
    array_push(idleThoughts, dg);
}

palette_array = global.CharacterPalette[global.playerCharacter].palettes;

for (i = 0; i < array_length(palette_array); i++)
{
    key = palette_array[i].palName;
    array_push(paletteThoughts, lang_get(string("{0}_thought", key)));
}
