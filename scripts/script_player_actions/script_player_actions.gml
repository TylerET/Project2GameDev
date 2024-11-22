function controlsSetup(){
	// Jump buffer setup
	bufferTime = 3;
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
}



function getControls() {
// Directional inputs
rightKey = keyboard_check(vk_right) + keyboard_check(ord("D")) + gamepad_button_check(0, gp_padr);
rightKey = clamp(rightKey, 0 , 1);
leftKey = keyboard_check(vk_left) + keyboard_check(ord("A")) + gamepad_button_check(0, gp_padl);
leftKey = clamp(leftKey, 0 , 1);

upKey = keyboard_check(vk_up) + keyboard_check(ord("W")) + gamepad_button_check(0, gp_padu);
upKey = clamp(upKey, 0 , 1);
downKey = keyboard_check(vk_down) + keyboard_check(ord("S")) + gamepad_button_check(0, gp_padd);
downKey = clamp(downKey, 0 , 1);

// Action inputs
jumpKeyPressed = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face1);
jumpKeyPressed = clamp(jumpKeyPressed, 0 , 1);

jumpKey = keyboard_check(vk_space) + gamepad_button_check(0, gp_face1);
jumpKey = clamp(jumpKey, 0 , 1);

runKey = keyboard_check(vk_lshift) + gamepad_button_check(0, gp_face2);
runKey = clamp(runKey, 0 , 1);

// jumpkey buffering
if jumpKeyPressed {
	jumpKeyBufferTimer = bufferTime;
}
if jumpKeyBufferTimer > 0 {
	jumpKeyBuffered = 1;
	jumpKeyBufferTimer--;
} else {
	jumpKeyBuffered = 0;
}

}