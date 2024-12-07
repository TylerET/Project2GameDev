current_frame = 0;
isRecording = false;
buffer_size = 180;
event_buffer = array_create(buffer_size, undefined);
buffer_index = 0;
global.player_actions = ds_list_create();
global.last_recorded_actions = ds_list_create();
player_died = false;

// Above player head texts
text_timer = 0;
display_text = ""; 








#region Sprites
idleSpr = spr_player_idle;
walkSpr = spr_player_walk;
runSpr = spr_player_run;
jumpSpr = spr_player_jump;
jumpFlipSpr = spr_player_jump_flip;
wallSlideSpr[0] = spr_player_wall_slide;
wallSlideSpr[1] = spr_player_wall_slide_left;
dashSpr = spr_player_dash

#endregion

hp = 100;

#region Movement
controlsSetup();
// Moving
faceDir = 1;
moveDir = 0;
runType = 0;
moveSpeed[0] = 2;
moveSpeed[1] = 3.5;
xSpeed = 0;
ySpeed = 0;

// Jumping
grav = .275;
terminalVelocity = 6;
onGround = true;
jumpSpeed = -3.15;
jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;
jumpHoldFrames = 18;
coyoteHangFrames = 2;
coyoteHangTimer = 0;
coyoteJumpFrames = 5;
coyoteJumpTimer = 0;
// Wall slide
onWall = false;

footstep_played = false;

function checkForSemiSolidPlatform(_x, _y)
{
	var _return = noone;
	if ySpeed >= 0 && place_meeting(_x, _y, obj_semi_solid_wall)
	{
		var _list = ds_list_create();
		var _listSize = instance_place_list(_x, _y, obj_semi_solid_wall, _list, false);
		for (var i = 0; i < _listSize; i++)
		{
			var _listInst = _list[| i];
			if _listInst != forgetSemiSolid && floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpeed)
			{
				_return =  _listInst;
				i = _listSize;
			}
		}
		ds_list_destroy(_list);
	}
}

function setOnGround(_val = true){
	if _val {
		onGround = true;
		coyoteHangTimer = coyoteHangFrames;
	} else {
		onGround = false;
		coyoteHangTimer = 0;
		myFloorPlat = noone;
	}
}


#endregion

targetColorUniform = shader_get_uniform(shader_color_select_grayscale, "targetColor");
toleranceUniform = shader_get_uniform(shader_color_select_grayscale, "tolerance");

shaderActive1 = false;
shaderActive2 = false;
shaderActive3 = false;
tolerance = 0;


//Abilities:
is_dashing = false
can_dash = true
dash_speed = 10
dash_x = 0
dash_y = 0
dash_duration = 0.3 //in seconds
dash_cd = 1 //in seconds

//Colors
color_white = make_color_rgb(255, 255, 255);
color_green = make_color_rgb(0, 255, 0);
color_blue = make_color_rgb(0, 0, 255);

//Emerald Guard
has_green_ability = true; // Tracks green cooldown
is_shield_active = false;  // Track if the shield is active
bounce_strength = 10;       // Strength of the bounce

shield_timer = 0;          // Shield duration
shield_cooldown = 0;       // Cooldown duration
shield_recharge_time = 300; // 5 seconds
shield_active_time = 180;   // 3 seconds

//Time Slow
default_room_speed = room_speed;
default_gamespeed_fps = gamespeed_fps;

// Slomo variables
slomo_active = false;
slomo_timer = 0;
slomo_duration = 3 * room_speed;   // 3 seconds
slomo_cooldown = 0;
slomo_cooldown_duration = 5 * room_speed; // 5 second cooldown

slomo_speed_factor = 0.75; 

//Moving Platforms
myFloorPlat = noone;
movePlatXspeed = 0;
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
depth = -30
