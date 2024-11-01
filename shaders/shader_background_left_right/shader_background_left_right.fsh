varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float cutoff; // A value between 0.0 and 1.0 representing the reveal progress

// Simple pseudo-random function based on Y-coordinate
float randomOffset(float y) {
    return fract(sin(y * 12.9898) * 43758.5453) * 0.1; 
}

void main() {
    // Calculate an offset based on the Y-coordinate to add variation
    float yOffset = randomOffset(v_vTexcoord.y);

    // Adjust the reveal threshold by adding the yOffset
    if (v_vTexcoord.x <= cutoff + yOffset) {
        // Sample the texture color
        vec4 source = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

        // Apply grayscale calculation
        float brightness = dot(vec3(0.2989, 0.5870, 0.1140), source.rgb);
        gl_FragColor = vec4(vec3(brightness), source.a);
    } else {
        // Hide the pixels beyond the cutoff by making them fully transparent
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
