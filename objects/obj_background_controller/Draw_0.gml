shader_set(shader_background_left_right);

var cutoffUniform = shader_get_uniform(shader_background_left_right, "cutoff");
shader_set_uniform_f(cutoffUniform, cutoff);

// Draw the sprite as a background with the shader
draw_sprite(spr_concept_background_bright, 0, 0, 0);

shader_reset();
