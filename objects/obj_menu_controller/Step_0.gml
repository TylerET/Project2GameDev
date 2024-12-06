// Find the player's position to center the menu on them
var player = instance_find(obj_player, 0);

if (player != noone) {
    center_x = player.x;
    center_y = player.y - 100; // Offset the menu above the player
}

// Display the menu when the right mouse button is held
if (mouse_check_button(mb_right)) {
	if !bullet_time {
		bullet_time = true
        game_set_speed(room_speed * bullet_time_speed, default_gamespeed_fps);
		}
    // Check if menu options already exist
    if (array_length(menu_options) == 0) {
        // Create the menu options if they don't exist yet
        for (var i = 0; i < number_of_options; i++) {
            var angle = i * (360 / number_of_options);
            var option_x = center_x + radius * cos(degtorad(angle));
            var option_y = center_y + radius * sin(degtorad(angle));
            
            // Create each menu option and store the instance in the array
            var option_instance = instance_create_layer(option_x, option_y, "MenuLayer", obj_menu_option);
            option_instance.option_index = i;
            array_push(menu_options, option_instance); // Store reference
        }
    } else {
        // Update the positions of existing menu options
        for (var i = 0; i < number_of_options; i++) {
            var angle = i * (360 / number_of_options);
            var option_x = center_x + radius * cos(degtorad(angle));
            var option_y = center_y + radius * sin(degtorad(angle));
            
            // Update the position of each option
            menu_options[i].x = option_x;
            menu_options[i].y = option_y;
        }
    }
} else if (mouse_check_button_released(mb_right)) {
    // Right mouse button has just been released; check for a selection
	bullet_time = false
	game_set_speed(default_room_speed, default_gamespeed_fps);
    for (var i = 0; i < array_length(menu_options); i++) {
        var option_instance = menu_options[i];
        if (instance_exists(option_instance) && option_instance.is_selected) {
            // Trigger the action for the selected option
            option_instance.option_action();
            break;
        }
    }

    // Hide the menu options by destroying them
    for (var i = 0; i < array_length(menu_options); i++) {
        if (instance_exists(menu_options[i])) {
            instance_destroy(menu_options[i]);
        }
    }
    menu_options = []; // Clear the array of references
}
