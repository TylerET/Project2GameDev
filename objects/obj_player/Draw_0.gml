if (shaderActive1) {
    shader_set(Shader2)
    shader_set_uniform_f(targetColorUniform, 0.6745, 0.1961, 0.1961);; // Set target color
    shader_set_uniform_f(toleranceUniform, tolerance);              // Set tolerance
    draw_sprite_ext(sprite_index, image_index, x , y, image_xscale*faceDir, image_yscale, image_angle, image_blend, image_alpha);
    shader_reset();
} else if (shaderActive2) {
	shader_set(Shader1)
	draw_sprite_ext(sprite_index, image_index, x , y, image_xscale*faceDir, image_yscale, image_angle, image_blend, image_alpha);
    shader_reset();
}else {
    draw_sprite_ext(sprite_index, image_index, x , y, image_xscale*faceDir, image_yscale, image_angle, image_blend, image_alpha);
}