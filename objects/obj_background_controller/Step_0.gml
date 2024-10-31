/// @description Insert description here
// You can write your code in this editor
cutoff += 0.001; // Adjust the speed as needed
if (cutoff > 1.0) {
    cutoff = 1.0; // Cap at 1.0 to prevent overflow
}
