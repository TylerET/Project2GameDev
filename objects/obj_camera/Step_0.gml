if keyboard_check_pressed(vk_f11){
	window_set_fullscreen(!window_get_fullscreen());
}


var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

var _camX = obj_player.x - _camWidth / 2;
var _camY = obj_player.y - _camHeight / 2;


_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

finalCamX += (_camX - finalCamX) * camTrailSpeed;
finalCamY += (_camY - finalCamY) * camTrailSpeed;

camera_set_view_pos(view_camera[0], finalCamX, finalCamY);
