image_alpha = 0.5; // 50% transparency
index = 0;


if variable_instance_exists(self, "action_queue") {
    // action_queue is already set by the parent object creation
} else {
    //action_queue = ds_queue_create(); // Fallback, empty queue
	action_queue = ds_list_create();
}

if ds_list_size(global.player_actions) == 0 {
    show_debug_message("global.player_actions is empty!");
    instance_destroy(); // Destroy the ghost since there are no actions
    exit;
}


ds_list_copy(action_queue, global.player_actions)



