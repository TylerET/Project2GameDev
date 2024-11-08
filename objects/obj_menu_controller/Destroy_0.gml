///@description Menu clean up
for (var i = 0; i < array_length(menu_options); i++) {
    if (instance_exists(menu_options[i])) {
        instance_destroy(menu_options[i]);
    }
}
