// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function msg(title, variable){
	show_debug_message( string(title) + " : "+ string(variable))
}

function apply_pause_overlay_effect() {
    var effect = fx_create("_filter_old_film");
    
    // Check if the effect struct was created successfully
    if (effect != -1) {
        fx_set_parameter(effect, "g_OldFilmFlickerIntensity", 0.025);
        fx_set_parameter(effect, "g_OldFilmFlickerSpeed", 0.1);
        fx_set_parameter(effect, "g_OldFilmJitterIntensity", 0);
        fx_set_parameter(effect, "g_OldFilmSaturation", 0.2);
        fx_set_parameter(effect, "g_OldFilmSpeckIntensity", 0.05);
        fx_set_parameter(effect, "g_OldFilmBarScale", 1);
        fx_set_parameter(effect, "g_OldFilmBarSpeed", 1);
        fx_set_parameter(effect, "g_OldFilmBarFrequency", 60);
        fx_set_parameter(effect, "g_OldFilmRingScale", 0.1);
        fx_set_parameter(effect, "g_OldFilmRingSharpness", 1);
        fx_set_parameter(effect, "g_OldFilmRingIntensity", 0);
		
        layer_set_fx("pause_overlay", effect);
    } else {
        show_debug_message("Failed to create Old Film FX struct.");
    }
}



