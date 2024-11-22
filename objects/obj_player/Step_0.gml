if (global.paused) {
	image_speed = 0;
    exit; // Skip the rest of the Step Event if the game is paused
} else {
	image_speed = 1 
}

#region unlockable controls 
// at the top because dash ignores gravity and animations-- dashing into diagonal corners is broken right now, fix!!!

if (keyboard_check_pressed(vk_alt) and can_dash) { //add conditions to have abilities! *** (must have red color for dash)
	// add dash sfx!
	is_dashing = true
	can_dash = false
	alarm[0] = dash_duration * 30
	sprite_index = dashSpr
	image_index = 0
	
	dash_x = rightKey - leftKey
	dash_y = downKey - upKey //down - up because inverted y axis
	
	if (dash_x != 0 and dash_y != 0) { //diagonal dash
		var _length = sqrt(power(dash_x, 2) + power(dash_y, 2))
		xSpeed = (dash_x / _length) * dash_speed
		ySpeed = (dash_y / _length) * dash_speed
	} else if (dash_x != 0 or dash_y != 0) { //cardinal dash
		xSpeed = dash_x * dash_speed
		ySpeed = dash_y * dash_speed
	} else { // default dash (direction of player)
		xSpeed = faceDir * dash_speed
		ySpeed = 0
	}
}

#endregion

#region dash
if (is_dashing) {
	
	x += xSpeed
	y += ySpeed
	if(image_index == 4)
		image_speed = 0
	exit //exit scripts below
}
#endregion

if (x < 0 || x > room_width) || (y < 0 | y > room_height) {
	game_restart()
}



// Step Event of obj_player
if (place_meeting(x, y, obj_camera_transition)) {
    global.fullRoomCamera = true;
} else {
    global.fullRoomCamera = false;
}



// Setup
getControls();

onWall = false;

#region X Movement

moveDir = rightKey - leftKey;
if moveDir != 0 {faceDir = moveDir}
runType = runKey;
xSpeed = moveDir * moveSpeed[runType];

// X collision
var _subPixel = .5;
if place_meeting(x + xSpeed, y ,  obj_wall_collisions) {
	
	// Check for slope
	if !place_meeting(x + xSpeed, y - abs(xSpeed)-1, obj_wall_collisions) {
		while place_meeting(x + xSpeed, y, obj_wall_collisions) {y -= _subPixel}
	} else {	
	// moves as close to wall precisely
		var _pixelCheck = _subPixel * sign(xSpeed);
		while !place_meeting(x + _pixelCheck, y , obj_wall_collisions) {
			x += _pixelCheck;
		}
		xSpeed = 0;
		onWall = true;
	}

}

//Go down slopes
if ySpeed >= 0 && !place_meeting(x + xSpeed, y + 1, obj_wall_collisions) && place_meeting(x +xSpeed, y + abs(xSpeed)+1, obj_wall_collisions) {
	while !place_meeting(x + xSpeed, y + _subPixel, obj_wall_collisions) { y+= _subPixel}
}

//Move
x += xSpeed;

#endregion

#region Y Movement

// Gravity
if coyoteHangTimer > 0 {
	coyoteHangTimer--;
}else {
	if (onWall && ySpeed > 0) {
		ySpeed += grav / 50;
	} else { ySpeed += grav}
	setOnGround(false);
}


if ySpeed > terminalVelocity {
	ySpeed = terminalVelocity;
}
	
// Initiate the Jump
	if onGround {
		jumpCount = 0;
		coyoteJumpTimer = coyoteJumpFrames;
	} else {
		// if player is in air, make sure they can't do an extra jump
		coyoteJumpTimer--;
		if (jumpCount == 0 && coyoteJumpTimer <= 0) { jumpCount = 1;}
	}

if jumpKeyBuffered && jumpCount < jumpMax {
	jumpKeyBuffered = false;
	jumpKeyBufferTimer = 0;
	if (jumpCount != 0) {
		sprite_index = spr_player_jump_flip;
	}
	jumpCount++;
	jumpHoldTimer = jumpHoldFrames;
	setOnGround(false);
}

// Jump based on holding jump key

if !jumpKey {
	jumpHoldTimer = 0;	
}

if (jumpHoldTimer > 0){
	ySpeed = jumpSpeed;
	jumpHoldTimer--;
}

// Y collision
var _subPixel = .5;
if (place_meeting(x, y + ySpeed, obj_wall_collisions)) {
    // moves as close to floor precisely
	var _pixelCheck = _subPixel * sign(ySpeed);
	while !place_meeting(x, y + _pixelCheck, obj_wall_collisions) {
		y += _pixelCheck;
	}
	//Bonk head check
	if (ySpeed < 0){
		jumpHoldTimer = 0;
	}
	
	ySpeed = 0;
}

if (ySpeed >= 0 && place_meeting(x, y+1, obj_wall_collisions)){
	setOnGround(true);
	can_dash = true //recover dash on touching ground
}

//Move
y += ySpeed;
	
#endregion

#region Sprite controls
if abs(xSpeed) > 0 { sprite_index = runType ? runSpr : walkSpr}
if xSpeed == 0 {sprite_index = idleSpr}
if !onGround {
	if (onWall && ySpeed >= 0){
		sprite_index = wallSlideSpr[moveDir == 1 ? 0 : 1]
		image_speed = 0;
	} else {
		sprite_index = jumpSpr
		//make falling sprite less wobbly
		image_speed = 0
		if (abs(ySpeed) < 1.5) { //mid-jump, can adjust 
			image_index = 1
		} else if (ySpeed > 0) {//if falling down
			image_index = 2
		} else { //if rising up
			image_index = 0
		}
	}	
}
mask_index = idleSpr


#endregion

if (keyboard_check_pressed(vk_f1)) {
    shaderActive1 = !shaderActive1;
	shaderActive2  = false;
}

if (keyboard_check_pressed(vk_f2)) {
    shaderActive2 = !shaderActive2;
	shaderActive1 = false;
}

if (keyboard_check_pressed(vk_f3)) {
	msg("Tolerance", tolerance)
    tolerance += .1;
}

if (keyboard_check_pressed(vk_f4)) {
    shaderActive3 = !shaderActive3;
	shaderActive1 = false;
	shaderActive2 = false;
}

if (keyboard_check_pressed(ord("R"))) {
	game_restart()
}

if (keyboard_check_pressed(ord("Q"))) {
	hp -= 10;
}