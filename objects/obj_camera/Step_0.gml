if (!variable_global_exists("defaultCamWidth")) {
    global.defaultCamWidth = camera_get_view_width(view_camera[0]);
    global.defaultCamHeight = camera_get_view_height(view_camera[0]);
}

// Toggle fullscreen
if keyboard_check_pressed(vk_f11) {
    window_set_fullscreen(!window_get_fullscreen());
}

if keyboard_check_pressed(vk_f12) {
    global.fullRoomCamera = !global.fullRoomCamera; 
}

var targetWidth = global.fullRoomCamera ? room_width : global.defaultCamWidth;
var targetHeight = global.fullRoomCamera ? room_height : global.defaultCamHeight;

// Smoothly transition camera size
var currentWidth = camera_get_view_width(view_camera[0]);
var currentHeight = camera_get_view_height(view_camera[0]);

// Adjust transition speed (0.1 is a good default, increase for faster transitions)
var transitionSpeed = 0.02;
var newWidth = lerp(currentWidth, targetWidth, transitionSpeed);
var newHeight = lerp(currentHeight, targetHeight, transitionSpeed);

// Set camera position to center on the player
var _camX = obj_player.x - newWidth / 2;
var _camY = obj_player.y - newHeight / 2;

// Clamp camera position within room bounds
_camX = clamp(_camX, 0, room_width - newWidth);
_camY = clamp(_camY, 0, room_height - newHeight);

finalCamX += (_camX - finalCamX) * camTrailSpeed;
finalCamY += (_camY - finalCamY) * camTrailSpeed;

// Apply new size and position to camera
camera_set_view_size(view_camera[0], newWidth, newHeight);
camera_set_view_pos(view_camera[0], finalCamX, finalCamY);
