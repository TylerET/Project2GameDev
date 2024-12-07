if (room == Room1|| room == Room2 || room == IntroCutSceneRoom) {
    if ds_list_size(action_queue) > 0 && index < ds_list_size(action_queue) {
        var action = action_queue[| index];
        x = action.x;
        y = action.y;
        faceDir = action.faceDir;
        sprite_index = action.sprite_index;
        image_xscale = faceDir; 
        index++;
    } else {
        if (loop) {
            index = 0; // Loop ghost
        } else {
            // Queue is empty, stop movement or destroy ghost
            show_debug_message("Ghost has completed all actions.");
            instance_destroy(); // Optional, or keep ghost idle
        }
    }
}
