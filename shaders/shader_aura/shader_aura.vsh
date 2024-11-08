// Vertex Shader

attribute vec2 in_Position;
attribute vec2 in_Texcoord;
attribute vec4 in_Colour;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition; // Room position

void main() {
    // Pass texture coordinate and color to fragment shader
    v_vTexcoord = in_Texcoord;
    v_vColour = in_Colour;

    // Calculate room position (assuming camera doesn't affect vertex shader)
    v_vPosition = in_Position;

    // Standard position output
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 0.0, 1.0);
}
