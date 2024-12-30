var surfW, surfH, wScalar, hScalar;

depth = -99;
gameframe_init();
__display_set_gui_size_hook(960, 540);
global.gameframe_caption_text = "Sugary Spire";
global.gameframe_caption_font = font_caption;
global.gameframe_caption_icon = spr_gameframe_icon;
global.gameframe_caption_margin = 6;
global.gameframe_border_width = 2;
alarm[0] = 1;
previousMouseX = device_mouse_x_to_gui(0);
previousMouseY = device_mouse_y_to_gui(0);
captionBuffer = 100;
application_surface_draw_enable(false);
finalApplicationSurface = -4;
finalApplicationSurfBuffer = -1;
guiSurface = -4;

nextPowTwo = function(argument0)
{
    return power(2, ceil(log2(argument0) / log2(2)));
};

surfW = 960;
surfH = 540;
wScalar = nextPowTwo(surfW);
hScalar = nextPowTwo(surfH);
uRes = shader_get_uniform(shd_pixelscale, "uRes");
sRes = [wScalar, hScalar];
