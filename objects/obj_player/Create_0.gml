current_frame = 0;
isRecording = false;
global.player_actions = ds_list_create();
global.last_recorded_actions = ds_list_create();

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


//Moving Platforms
myFloorPlat = noone;
movePlatXspeed = 0;
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
depth = -30
