// Find obj_menu_controller instance if it hasn't been assigned
if (menu_controller == noone) {
    menu_controller = instance_find(obj_menu_controller, 0); // Assumes only one obj_menu_controller
}

// Only proceed if menu_controller was successfully found
if (menu_controller != noone) {
    // Calculate the angle range for this option based on its index
    var angle_step = 360 / menu_controller.number_of_options;
    angle_start = option_index * angle_step;
    angle_end = angle_start + angle_step;

    // Get the angle of the mouse relative to the menu center
    var mouse_angle = point_direction(menu_controller.center_x, menu_controller.center_y, mouse_x, mouse_y);

    // Mirror the angle across the x-axis by inverting it
    mouse_angle = 360 - mouse_angle;

    // Ensure the angle is within 0-360 range
    if (mouse_angle >= 360) mouse_angle -= 360;

    // Check if the mouse is within this slice's angle range
    if (mouse_angle >= angle_start && mouse_angle < angle_end) {
        is_selected = true;

        // If left mouse button is pressed, trigger the action for this option
        if (mouse_check_button_pressed(mb_left)) {
            show_debug_message("Option " + string(option_index) + " selected!");
            //option_action();
        }
    } else {
        is_selected = false;
    }
}
