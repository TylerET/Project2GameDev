/// @description Insert description here
// You can write your code in this editor
global.paused = false;

// Play background music
audio_play_sound(forestbackground, true, 1);
audio_sound_gain(forestbackground, 0.02, 0);

audio_play_sound(pianobackground, true, 1);
audio_sound_gain(forestbackground, 0.08, 0);

window_set_fullscreen(true);

