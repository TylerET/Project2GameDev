/// @description Insert description here
// You can write your code in this editor
if (global.paused) { exit }

cutoff += 0.001; // Adjust the speed as needed
if (cutoff > 1.0) {
    cutoff = 1.0; // Cap at 1.0 to prevent overflow
}

// Gradually increase the radius for the grayscale effect

calcRadius = auraState == -1 ?  obj_player.hp + (10 * auraState) : effect_radius  + (10 * auraState)
effect_radius = clamp(calcRadius, 0 , max_radius)


if (keyboard_check_pressed(ord("F"))) {
	auraState *= -1
}

// In the Step event of a controller object
if (keyboard_check_pressed(ord("B"))) {
    bullet_time = !bullet_time;
    if (bullet_time) {
        game_set_speed(room_speed * bullet_time_speed, gamespeed_fps);
    } else {
        game_set_speed(default_room_speed, default_gamespeed_fps);
    }
}



