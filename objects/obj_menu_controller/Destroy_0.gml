/// @description Insert description here
// You can write your code in this editor
// Destroy Event of obj_menu_controller
for (var i = 0; i < array_length(menu_options); i++) {
    if (instance_exists(menu_options[i])) {
        instance_destroy(menu_options[i]);
    }
}
