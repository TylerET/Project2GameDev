varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 playerPosition; // Player's position in screen coordinates
uniform float radius;        // The radius of the color-to-grayscale transition

void main() {
    vec4 source = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

    // Calculate brightness for grayscale
    float brightness = dot(vec3(0.2989, 0.5870, 0.1140), source.rgb);

    // Get the screen position of the current fragment
    vec2 fragmentPosition = gl_FragCoord.xy;

    // Calculate the distance from the fragment to the player's position
    float distanceToPlayer = distance(fragmentPosition, playerPosition);

    // Calculate the grayscale factor based on the distance and radius
    float grayscaleFactor = smoothstep(radius, radius + 50.0, distanceToPlayer); // Adjust 50.0 for a smoother transition

    // Interpolate between color and grayscale based on the grayscale factor
    vec3 finalColor = mix(source.rgb, vec3(brightness), grayscaleFactor);

    gl_FragColor = vec4(finalColor, source.a);
}
