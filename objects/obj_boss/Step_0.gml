// Variables
var player = instance_nearest(x, y, obj_player);
var move_speed = 4;
var attack_range = 50;         // Range for slashing
var attack_cooldown = 60;      // Cooldown between slashes
var disappear_distance = 300;
var reappear_range = 150;
death_timer--;                 // Counts down to death

var distance_to_player = -1;

// Check if the player exists
if (player != noone) {
    distance_to_player = point_distance(x, y, player.x, player.y); 
}

// State logic
switch (state) {
    case "idle":
        // Follow player or vanish if too far
        if (player != noone) {
            if (distance_to_player > disappear_distance) {
                state = "vanish";
                sprite_index = spr_boss_vanish;
                image_speed = 0.2;
                image_index = 0;
            } else if (distance_to_player > attack_range) {
                // Move toward the player
                var directiontoplayer = point_direction(x, y, player.x, player.y);
                var move_x = lengthdir_x(move_speed, directiontoplayer);
                var move_y = lengthdir_y(move_speed, directiontoplayer);
                x += move_x;
                y += move_y;
            } else {
                state = "slash";
            }
        } else {
            sprite_index = spr_boss_idle;
            image_speed = 0.1;
        }

        sprite_index = spr_boss_walk;
        image_speed = 0.2;
        break;

    case "vanish":
        if (image_index >= image_number - 1) {
            // Teleport to a new position near the player
            if (player != noone) {
                var angle = random(360);
                var reappear_x = player.x + lengthdir_x(reappear_range, angle);
                var reappear_y = player.y + lengthdir_y(reappear_range, angle);

                x = reappear_x;
                y = reappear_y;
            }

            state = "reappear";
            sprite_index = spr_boss_reappear;
            image_speed = 0.2;
            image_index = 0;
        }
        break;

    case "reappear":
        if (image_index >= image_number - 1) {
            state = "idle";
        }
        break;

    case "slash":
        sprite_index = spr_boss_slash;
        image_speed = 0.3;

        if (player != noone && distance_to_player > disappear_distance) {
            // Interrupt slash and vanish if player moves too far
            state = "vanish";
            sprite_index = spr_boss_vanish;
            image_speed = 0.2;
            image_index = 0;
        } else if (image_index >= image_number - 1) {
            // Deal damage if player is within attack range
            if (player != noone && distance_to_player <= attack_range) {
                player.hp -= 20;
            }

            state = "cooldown";
            attack_timer = attack_cooldown;
        }
        break;

    case "cooldown":
        attack_timer--;
        if (attack_timer <= 0) {
            state = "idle";
        }

        sprite_index = spr_boss_idle;
        image_speed = 0.1;
        break;

    case "death":
        // Play death animation
        sprite_index = spr_boss_death;
        image_speed = 0.2;

        if (image_index >= image_number - 1) {
            instance_destroy();
        }
        break;
}

if (player == noone) {
    sprite_index = spr_boss_idle;
    image_speed = 0.1;
    state = "idle";
}

// Death check
if (death_timer <= 0 && state != "death") {
    state = "death";
	audio_play_sound(bossdeath, 10, false)
	room_goto_next()
    image_index = 0;
}
