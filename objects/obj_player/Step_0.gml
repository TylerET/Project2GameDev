if (global.paused) {
	image_speed = 0;
    exit; // Skip the rest of the Step Event if the game is paused
} else {
	image_speed = 1 
}

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





