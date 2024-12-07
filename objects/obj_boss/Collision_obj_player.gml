/// @description Insert description here
// You can write your code in this editor
if (other != noone) {
    // Check if Emerald Guard is active
    if (!other.is_shield_active && other.hit_cooldown <= 0) {
        // Increment the player's hit counter if the shield is NOT active
        other.hit_count++;

        other.hit_cooldown = 60;

        if (other.hit_count >= 3) {
            // Switch to death sprite
            audio_play_sound(hurt, 10, false);
            other.sprite_index = spr_player_death;
            other.image_speed = 0.2;
            other.dead = true;
        } else {
            audio_play_sound(hurt, 10, false);
        }
    }
}
