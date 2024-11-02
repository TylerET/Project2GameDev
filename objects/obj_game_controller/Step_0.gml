/// @description Insert description here
// You can write your code in this editor
if (keyboard_check_pressed(vk_escape)) {
    global.paused = !global.paused;
    if (global.paused) {
		apply_pause_overlay_effect();
        layer_set_visible(layer_get_id("pause_overlay"), true); 
        game_speed = 0;
    } else {
        layer_set_visible(layer_get_id("pause_overlay"), false); 
        game_speed = 1;
    }
}
