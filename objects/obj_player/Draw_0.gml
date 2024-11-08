if (shaderActive1) {
    shader_set(shader_color_select_grayscale)
    shader_set_uniform_f(targetColorUniform, 0.6745, 0.1961, 0.1961);; // Set target color
    shader_set_uniform_f(toleranceUniform, tolerance);              // Set tolerance
    draw_sprite_ext(sprite_index, image_index, x , y, image_xscale*faceDir, image_yscale, image_angle, image_blend, image_alpha);
    shader_reset();
} else if (shaderActive2) {
	shader_set(shader_grayscale)
	draw_sprite_ext(sprite_index, image_index, x , y, image_xscale*faceDir, image_yscale, image_angle, image_blend, image_alpha);
    shader_reset();
} else {
    draw_sprite_ext(sprite_index, image_index, x , y, image_xscale*faceDir, image_yscale, image_angle, image_blend, image_alpha);
}
if (debug)
{
// Set the color and transparency for the collision mask outline (for visibility)
draw_set_color(c_red);
draw_set_alpha(0.5);

// Get the collision mask's bounding box
var mask_left = bbox_left;
var mask_top = bbox_top;
var mask_right = bbox_right;
var mask_bottom = bbox_bottom;

// Draw a rectangle representing the collision mask
draw_rectangle(mask_left, mask_top, mask_right, mask_bottom, false);

// Reset the draw color and alpha for other objects
draw_set_color(c_white);
draw_set_alpha(1);
}