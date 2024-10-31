varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float cutoff; // A value between 0.0 and 1.0 representing the reveal progress

// Simple pseudo-random function based on pixel coordinates
float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    // Generate a random threshold based on the pixel's texture coordinates
    float threshold = random(v_vTexcoord);

    // Only reveal the pixel if the cutoff exceeds the random threshold
    if (cutoff >= threshold) {
        // Sample the texture color
        vec4 source = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

        // Apply grayscale calculation
        float brightness = dot(vec3(0.2989, 0.5870, 0.1140), source.rgb);
        gl_FragColor = vec4(vec3(brightness), source.a);
    } else {
        // Hide the pixels that haven't yet been revealed
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
