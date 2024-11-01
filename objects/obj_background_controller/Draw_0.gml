shader_set(shader_background_left_right);

var cutoffUniform = shader_get_uniform(shader_background_left_right, "cutoff");
shader_set_uniform_f(cutoffUniform, cutoff);

// Draw the sprite as a background with the shader
draw_sprite(spr_concept_background_bright, 0, 0, 0);

shader_reset();

// Activate the shader
//shader_set(Shader5);

//// Set the player's screen position in the shader
//var playerPositionUniform = shader_get_uniform(Shader5, "playerPosition");
//shader_set_uniform_f(playerPositionUniform, obj_player.x, obj_player.y);

//// Set the radius for the grayscale effect
//var radiusUniform = shader_get_uniform(Shader5, "radius");
//shader_set_uniform_f(radiusUniform, effect_radius);

//// Draw the background or full screen with the shader applied
//draw_sprite(spr_concept_background_bright, 0, 0, 0); // Or draw a background

//shader_reset();

