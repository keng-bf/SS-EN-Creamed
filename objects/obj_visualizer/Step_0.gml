var raw_visualizer_y, intensity, visualizer_y, target_y;

raw_visualizer_y = ds_list_find_value(global.FMOD_DSP_Value, visualizerIndex) ?? 0;
intensity = 5;
visualizer_y = min(raw_visualizer_y * intensity, 1);
target_y = lerp(bottomY, topY, visualizer_y);
y = lerp(y, target_y, 0.3);
