// Fragment Shader

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform vec2 playerPosition;   // Player's position in room coordinates
uniform float radius;          // Radius for the color-to-grayscale transition

void main() {
    vec4 source = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

    // Calculate brightness for grayscale
    float brightness = dot(vec3(0.2989, 0.5870, 0.1140), source.rgb);

    // Calculate the distance from the fragment to the player's position
    float distanceToPlayer = distance(v_vPosition, playerPosition);

    // Calculate the grayscale factor based on the distance and radius
    float grayscaleFactor = smoothstep(radius, radius + 50.0, distanceToPlayer);

    // Interpolate between color and grayscale based on the grayscale factor
    vec3 finalColor = mix(source.rgb, vec3(brightness), grayscaleFactor);

    gl_FragColor = vec4(finalColor, source.a);
}
