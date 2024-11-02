// Option-specific variables
option_index = 0; // Set by obj_menu_controller
is_selected = false;
angle_start = 0; // Start angle for this option's slice
angle_end = 0;   // End angle for this option's slice
menu_controller = noone; // Reference to the controller

// Define the option_action function to handle each slice's action
function option_action() {
    switch (option_index) {
        case 0:
            show_debug_message("Option 0 selected");
            break;
        case 1:
            show_debug_message("Option 1 selected");
            break;
        case 2:
            show_debug_message("Option 2 selected");
            break;
        case 3:
            show_debug_message("Option 3 selected4");
            break;
        case 4:
            show_debug_message("Option 4 selected5");
            break;
        case 5:
            show_debug_message("Option 5 selected");
            break;
        default:
            show_debug_message("Unknown option selected");
    }
}
