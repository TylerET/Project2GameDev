varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 targetColor; // The color you want to target (e.g., vec3(1.0, 0.0, 0.0) for red)
uniform float tolerance;   // The tolerance for color matching (e.g., 0.2 for approximate match)

void main() {
    vec4 source = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

    // Calculate the difference between the source color and target color
    float colorDifference = distance(source.rgb, targetColor);

    // Apply grayscale if the color is within the specified tolerance range
    if (colorDifference > tolerance) {
        float brightness = dot(vec3(0.2989, 0.5870, 0.1140), source.rgb);
        gl_FragColor = vec4(vec3(brightness), source.a);
    } else {
        // Leave the color unaffected if it’s outside the target range
        gl_FragColor = source;
    }
}
