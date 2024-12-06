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

function save_action_queue(action_list) {
    var action_array = []; 
    var filename = get_string("Enter a file name:", "recorded_actions") + ".json"

    for (var i = 0; i < ds_list_size(action_list); i++) {
        var action = ds_list_find_value(action_list, i);
        var action_data = [
            action.x,
            action.y,
            action.faceDir,
            action.sprite_index
        ];

        array_push(action_array, action_data);
    }
    var json_data = json_stringify(action_array);
    var file = file_text_open_write(filename);
    file_text_write_string(file, json_data);
    file_text_close(file);

    show_debug_message("List saved to ");
	show_debug_message(filename)
}


function load_action_queue(filename) {
    var action_list = ds_list_create();

    if (file_exists(filename)) {
        var file = file_text_open_read(filename);
        var json_data = file_text_read_string(file);
        file_text_close(file);

        var action_array = json_parse(json_data);

        for (var i = 0; i < array_length(action_array); i++) {
            var action_data = action_array[i];

            var action = {
                x: action_data[0],
                y: action_data[1],
                faceDir: action_data[2],
                sprite_index: action_data[3]
            };

            ds_list_add(action_list, action);
        }

        show_debug_message("Action list loaded from " + filename);
    } else {
        show_debug_message("File not found: " + filename);
    }

    return action_list; 
}




function print_queue (queue)
{
if (ds_queue_size(queue) > 0) {
    var temp_queue = ds_queue_create();
    ds_queue_copy(temp_queue, queue);
    
    var index = 0;
    while (ds_queue_size(temp_queue) > 0) {
        var value = ds_queue_dequeue(temp_queue);
        show_debug_message("Queue Element " + string(index) + ": " + string(value));
        index++;
    }
    
    ds_queue_destroy(temp_queue);
} else {
    show_debug_message("The queue is empty.");
}
}

function debug_ds_list(list) {
    if (!ds_exists(list, ds_type_list)) {
        show_debug_message("Provided variable is not a ds_list.");
        return;
    }

    var size = ds_list_size(list);

    if (size == 0) {
        show_debug_message("The list is empty.");
    } else {
        for (var i = 0; i < size; i++) {
            var value = ds_list_find_value(list, i);
            show_debug_message("List[" + string(i) + "] = " + string(value));
        }
    }
}





