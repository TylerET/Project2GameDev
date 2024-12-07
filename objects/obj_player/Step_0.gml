if (global.paused) {
	image_speed = 0;
    exit; // Skip the rest of the Step Event if the game is paused
} else {
	image_speed = 1;
}

#region unlockable controls 
// at the top because dash ignores gravity and animations-- dashing into diagonal corners is broken right now, fix!!!

if (keyboard_check_pressed(vk_alt) and can_dash) { //add conditions to have abilities! *** (must have red color for dash)
	// add dash sfx!
	var random_pitch = random_range(0.55, 1.55);
    audio_sound_pitch(whoosh, random_pitch);
    audio_play_sound(whoosh, 10, false);
	
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

#region Slomo
if (slomo_active) {
    slomo_timer++;

    var remaining_time_ratio = (slomo_duration - slomo_timer) / slomo_duration;

    // Lerp from white to blue
    var fade_color = color_lerp(color_white, color_blue, remaining_time_ratio);
    image_blend = fade_color;

    if (slomo_timer >= slomo_duration) {
        // End slow motion
        slomo_active = false;
        slomo_timer = 0;
        slomo_cooldown = slomo_cooldown_duration;
        game_set_speed(default_room_speed, default_gamespeed_fps);

        image_blend = color_white; 
    }
}

if (slomo_cooldown > 0) {
    slomo_cooldown -= 1;
}

// Check for T press
if (keyboard_check_pressed(ord("T"))) {
    if (!slomo_active && slomo_cooldown <= 0) {
        slomo_active = true;
		
		var random_pitch = random_range(0.55, 1.55);
		audio_sound_pitch(icecracking,random_pitch);
		audio_play_sound(icecracking, 10, false)
		
        slomo_timer = 0;
        game_set_speed(default_room_speed * slomo_speed_factor, default_gamespeed_fps);
    }
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
downSlopeSemiSolid = noone;
if ySpeed >= 0 && !place_meeting(x + xSpeed, y + 1, obj_wall_collisions) && place_meeting(x +xSpeed, y + abs(xSpeed)+1, obj_wall_collisions) {
	downSlopeSemiSolid = checkForSemiSolidPlatform(x + xSpeed, y + abs(xSpeed) + 1);
	if !instance_exists(downSlopeSemiSolid)
	{
		while !place_meeting(x + xSpeed, y + _subPixel, obj_wall_collisions) { y+= _subPixel}

	}
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

if !downKey && jumpKeyBuffered && jumpCount < jumpMax {
	jumpKeyBuffered = false;
	jumpKeyBufferTimer = 0;
	if (jumpCount != 0) {
		sprite_index = spr_player_jump_flip;
		
		var random_pitch = random_range(1.95, 2.35);
        audio_sound_pitch(updraft, random_pitch);
        audio_play_sound(updraft, 10, false);
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
// Moving Platform

if (!is_shield_active)
{
var _clampYspeed = max(0, ySpeed);
var _clampYspeed = max(0, ySpeed);
var _list = ds_list_create();
var _array = array_create(0);
array_push(_array, obj_wall_collisions, obj_semi_solid_wall);
var _listSize = instance_place_list(x, y+ 1 + _clampYspeed + terminalVelocity, _array, _list, false);
for (var i = 0; i < _listSize; i++) {
	var _listInst = _list[| i];
	if _listInst != forgetSemiSolid
	&& (_listInst.ySpeed <= ySpeed || instance_exists(myFloorPlat))
	&& (_listInst.ySpeed > 0 || place_meeting(x, y+ 1 +  _clampYspeed, _listInst))
	{
		if _listInst.object_index == obj_wall_collisions 
		|| object_is_ancestor(_listInst.object_index, obj_wall_collisions)
		|| floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpeed)
		{
			if !instance_exists(myFloorPlat)
			|| _listInst.bbox_top + _listInst.ySpeed <= myFloorPlat.bbox_top + myFloorPlat.ySpeed
			|| _listInst.bbox_top + _listInst.ySpeed <= bbox_bottom
			{
				myFloorPlat = _listInst;
			}
		}
	}
	
}
ds_list_destroy(_list);
}



if instance_exists(myFloorPlat) && !place_meeting(x, y + terminalVelocity, myFloorPlat) 
{
	myFloorPlat = noone;
}

if instance_exists(myFloorPlat)
{
	var _subPixel = .5;
	while !place_meeting(x, y + _subPixel, myFloorPlat) && !place_meeting(x, y , obj_wall_collisions)
	{
		y += _subPixel;
	}
	if myFloorPlat.object_index == obj_semi_solid_wall || object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall)
	{
		while place_meeting(x, y, myFloorPlat)
		{
			y -= _subPixel;
		}
		y = floor(y);
	}
	if (ySpeed < 0){
		jumpHoldTimer = 0;
	}
	ySpeed = 0;
	setOnGround(true);
	can_dash = true;
}


// Manually fall through semi solid;
if downKey && jumpKeyPressed
{
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == obj_semi_solid_wall || object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall))
	{
		var _yCheck = y + max(1, myFloorPlat.ySpeed + 1);
		if !place_meeting(x, _yCheck, obj_wall_collisions)
		{
			y += 1;
			ySpeed = _yCheck - 1;
			forgetSemiSolid = myFloorPlat;
			setOnGround(false);
		}
		
	}
}




//Move
y += ySpeed;

if forgetSemiSolid && !place_meeting(x, y, forgetSemiSolid) forgetSemiSolid = noone;

// final moving platform logic
movePlatXspeed = 0;
if instance_exists(myFloorPlat)
{
	movePlatXspeed = myFloorPlat.xSpeed;
}

if place_meeting(x + movePlatXspeed, y ,obj_wall_collisions)
{
	var _subPixel = .5;
	var _pixelCheck = _subPixel * sign(movePlatXspeed);
	while !place_meeting(x + _pixelCheck, y, obj_wall_collisions)
	{
		x += _pixelCheck
	}
	movePlatXspeed = 0;
}
x += movePlatXspeed;

if instance_exists(myFloorPlat) 
&& myFloorPlat.ySpeed != 0
{
	if !place_meeting(x, myFloorPlat.bbox_top, obj_wall_collisions)
	&& myFloorPlat.bbox_top >= bbox_bottom - terminalVelocity
	{
		y = myFloorPlat.bbox_top;
	}
	
	if myFloorPlat.ySpeed < 0
	&& place_meeting(x, y + myFloorPlat.ySpeed, obj_wall_collisions)
	{
		if myFloorPlat.object_index == obj_semi_solid_wall
		|| object_is_ancestor(myFloorPlat.object_index, obj_semi_solid_wall)
		{
			var _subPixel = .25
			while place_meeting(x, y + myFloorPlat.ySpeed, obj_wall_collisions)
			{
				y += _subPixel;
			}
			while place_meeting(x, y, obj_wall_collisions)
			{
				y -= _subPixel;
			}
			y = round(y);
		}
		setOnGround(false);
	}
}

	
#endregion

#region Sprite controls
if abs(xSpeed) > 0 { sprite_index = runType ? runSpr : walkSpr}
if xSpeed == 0 {sprite_index = idleSpr}
if !onGround {
	if (onWall && ySpeed >= 0){
		sprite_index = wallSlideSpr[moveDir == 1 ? 0 : 1]
		var random_pitch = random_range(0.95, 1.05);
        audio_sound_pitch(slide, random_pitch);
		audio_sound_gain(slide, 0.7, 1)
        audio_play_sound(slide, 10, true);
		image_speed = 0;
	} else {
		audio_stop_sound(slide)
		
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

if (keyboard_check_pressed(ord("R"))  && !keyboard_check(vk_control)) {
	game_restart()
}

if (keyboard_check_pressed(ord("R"))  && keyboard_check(vk_control)) {

	if isRecording
	{
        var ghost = instance_create_layer(x, y, "Instances", obj_player_ghost);
		isRecording = false;
		current_frame = 0;
		ds_list_copy(global.last_recorded_actions, global.player_actions)
	} else 
	{
		display_text = "Recording...";
		text_timer = 60; // Display text for 1 seconds (60 steps at 60 FPS)
		ds_list_clear(global.player_actions)
		isRecording = true;
	}
}

if (keyboard_check_pressed(ord("P"))) {
    if !instance_exists(obj_player_ghost) {
		var queue = load_action_queue("recorded_actions.json");
		global.player_actions = queue;
        var ghost = instance_create_layer(x, y, "Instances", obj_player_ghost);
    }
}

if (keyboard_check_pressed(ord("S")) && keyboard_check(vk_control)) { // Press 'S' to save the queue
	if ds_list_size(global.last_recorded_actions) > 0
	{
	    save_action_queue(global.last_recorded_actions);
	} else
	{
		show_debug_message("No actions to save");
	}
}

#region Emerald Guard
// Define colors

if (shield_cooldown > 0) 
{
    shield_cooldown--;
}

if (has_green_ability && shield_cooldown <= 0)
{
    if (keyboard_check(ord("Q")) && !is_shield_active) 
	{
        is_shield_active = true; // Activate shield
		var random_pitch = random_range(0.55, 1.55);
		audio_sound_pitch(emeraldguardactive, random_pitch);
		audio_play_sound(emeraldguardactive, 10, false);
    }
}

if (is_shield_active) 
{
    shield_timer++;

    // Calculate fade effect
    var remaining_time_ratio = (shield_active_time - shield_timer) / shield_active_time;
    var fade_color = color_lerp(color_white, color_green, remaining_time_ratio); // Lerp between white and green
    image_blend = fade_color;

    if (shield_timer >= shield_active_time)
	{
        is_shield_active = false; // Deactivate shield
        shield_timer = 0;
        shield_cooldown = shield_recharge_time; // Start cooldown
    }
} 
else
{
    image_blend = color_white; // Reset to normal

    if (!keyboard_check(ord("Q"))) {
        shield_timer = 0;
    }
}

// Shield functionality
if (is_shield_active) 
{
    var _collision = instance_place(x, y + 1, all);

    if (_collision != noone && (_collision.object_index == obj_wall_collisions || object_is_ancestor(_collision.object_index, obj_wall_collisions) || 
	 _collision.object_index == obj_semi_solid_wall || object_is_ancestor(_collision.object_index, obj_semi_solid_wall))
	) 
	{
        ySpeed = -bounce_strength; 
    }
}
#endregion


#region Frame-Based Sounds
if (sprite_index == spr_player_run) {
    var current_frame = floor(image_index);

    if (current_frame == 1 || current_frame == 5) {
        if (!footstep_played) {
            var random_pitch = random_range(0.95, 1.05);
            audio_sound_pitch(footstep, random_pitch);
            audio_play_sound(footstep, 10, false);
            footstep_played = true;
        }
    } else {
        footstep_played = false;
    }
}
else if (sprite_index == spr_player_walk) {
    var current_frame = floor(image_index);

    if (current_frame == 0 || current_frame == 4) {
        if (!footstep_played) {
            var random_pitch = random_range(0.55, 1.55);
            audio_sound_pitch(footstep, random_pitch);
            audio_play_sound(footstep, 10, false);
            footstep_played = true;
        }
    } else {
        footstep_played = false;
    }
}
#endregion


if (isRecording)
{
var action = {
    x: x,
    y: y,
    faceDir: faceDir,
    sprite_index: sprite_index,
    frame: current_frame
};
	ds_list_add(global.player_actions, action);
	current_frame++;
}

if (text_timer > 0) {
    text_timer--;
}
