// SPAWN CPU DURING CPU TURN (DO THIS FIRST)----- (DISABLED) -----
//if (global.game_phase == "cpu" && !instance_exists(obj_cpu)) {
    //instance_create_layer(spawn_x, spawn_y, "Instances", obj_cpu);
//}

global.game_phase = "player";

// THEN handle player visibility
ivisible = true;

// Detect when player turn starts
if (global.game_phase == "player" && !player_turn_started) {

    // Reset position
    x = spawn_x;
    y = spawn_y;

    vspeed = 0;
    hspeed = 0;

    // Reset movement
    charging = false;
    charge = 0;

    // Reset rotation
    rotation = 0;
    rotation_speed = 0;
    image_angle = 0;

    // Reset tricks
    flip_count = 0;
    last_flip_label = "";
    tuck_quality = "none";

    // Reset state
    state = "idle";
    image_index = 0;
}

// --- WATER STATE ---
var was_in_water = in_water;

// --- INPUT ---

var move = keyboard_check(vk_right) - keyboard_check(vk_left);
var jump = keyboard_check_released(vk_down);
var crouch = keyboard_check(vk_down);

// --- TRACK CHEESECUTTER ---
if (!on_ground && keyboard_check(vk_space) && !performed_cheesecutter) {
    performed_cheesecutter = true;
    trick_multiplier = 2;
}

// --- TUCK INPUT WITH ZONES ---
if (!on_ground && keyboard_check_pressed(vk_down)) {

    var water = instance_nearest(x, y, obj_water);

    if (water != noone) {

        var total_height = 100;
        var zone_height = total_height / 2;

        var zone_offset = 120;
        var top_zone = water.bbox_top - total_height - zone_offset;

        var player_y = y;

        if (player_y < top_zone) {
            tuck_quality = "too_early";
        }
        else if (player_y < top_zone + zone_height) {
            tuck_quality = "ok";
        }
        else if (player_y < top_zone + zone_height * 2) {
            tuck_quality = "good";
        }
        else if (player_y < top_zone + zone_height * 3) {
            tuck_quality = "perfect";
        }
        else if (player_y < top_zone + zone_height * 4) {
            tuck_quality = "good";
        }
        else if (player_y < top_zone + zone_height * 5) {
            tuck_quality = "ok";
        }
        else if (player_y < water.bbox_top) {
            tuck_quality = "late";
        }
        else {
            tuck_quality = "bad";
        }
    }

    // --- CREATE POPUP TEXT ---
    var msg = "";

    switch (tuck_quality) {
        case "perfect":   msg = "PERFECT TUCK"; break;
        case "good":      msg = "GOOD TUCK"; break;
        case "ok":        msg = "OK TUCK"; break;
        case "late":      msg = "TOO LATE"; break;
        case "too_early": msg = "TOO EARLY"; break;
        default:          msg = "BAD"; break;
    }
}

// --- GROUND CHECK ---
if (place_meeting(x, y + 1, obj_platform)) {
    on_ground = true;
} else {
    on_ground = false;    
}

// --- WATER STATE ---
in_water = place_meeting(x, bbox_bottom, obj_water);

// --- AUTO UNTUCK IN WATER ---
if (in_water && keyboard_check_released(vk_down) && untuck_timer <= 0) {
    untuck_timer = 10;
}

// --- CHARGING ---
if (on_ground && crouch) {
    charging = true;

    charge += 0.5;

    if (charge > max_charge) {
        charge = max_charge;
    }
}

// --- HORIZONTAL MOVEMENT ---
if (on_ground) {
    hspeed = move * move_speed;
}

x += hspeed;

// --- WATER FRICTION ---
if (in_water) {
    hspeed *= 0.7;
    vspeed *= 0.7;
}

// --- ANGLED JUMP ---
if (charging && jump) {
	
	performed_cheesecutter = false;
trick_multiplier = 1;

    var charge_power = charge / max_charge;

    var jump_height = lerp(1, 6, charge_power);
    var jump_width  = lerp(1, 5, charge_power);

    vspeed = -jump_height;
    hspeed = jump_width;

    last_charge = charge;

    charging = false;
    charge = 0;
    on_ground = false;
}

// --- GRAVITY ---
if (!on_ground) {

// --- AIR ROTATION CONTROL ---
if (!on_ground && !in_water) {

var rotate_input = keyboard_check(vk_right) - keyboard_check(vk_left);

    var target_speed = rotate_input * 6; // max spin speed

    // smoothly move toward target speed
    rotation_speed = lerp(rotation_speed, target_speed, 0.2);
}

// --- APPLY ROTATION ---
rotation -= rotation_speed;

// --- AIR ROTATION FRICTION ---
rotation_speed *= 1;

image_angle = rotation;

if (on_ground) {
    rotation = 0;
    rotation_speed = 0;
}

    if (in_water) {
        vspeed += gravity * 3;
    } else {
        vspeed += gravity;
    }
}

// --- APPLY VERTICAL MOVEMENT ---
y += vspeed;

// --- PLATFORM COLLISION ---
if (place_meeting(x, y, obj_platform)) {

    while (place_meeting(x, y, obj_platform)) {
        y -= 1;
    }

    vspeed = 0;
    on_ground = true;
}

// --- UNTUCK TIMER ---
if (untuck_timer > 0) {
    untuck_timer--;

    if (respawn_timer > 0 || untuck_timer > 0) {
        vspeed = 0;
        hspeed = 0;
    }
}

// --- STATE SYSTEM ---
if (untuck_timer > 0) {
    state = "untuck";
}
else if (!on_ground && keyboard_check(vk_space)) {
    state = "cheesecutter";
}
else if (!on_ground && keyboard_check(vk_down)) {
    state = "tuck";
}
else if (!on_ground && keyboard_check(vk_left)) {
    state = "backflip";
}
else if (!on_ground && keyboard_check(vk_right)) {
    state = "frontflip";
}
else if (charging) {
    state = "crouch";
}
else if (!on_ground) {
    state = "jump";
}
else if (abs(hspeed) > 0.1) {
    state = "walk";
}
else {
    state = "idle";
}

// --- ANIMATION ---
var new_sprite;

switch (state) {

    case "idle": new_sprite = spr_idle; image_speed = 0.2; break;
    case "walk": new_sprite = spr_walk; image_speed = 0.4; break;

    case "jump":
        new_sprite = spr_jump;
        image_speed = 0.4;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "crouch":
        new_sprite = spr_crouch;
        image_speed = 0.2;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "tuck":
        new_sprite = spr_tuck;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "untuck":
        new_sprite = spr_untuck;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;
		
	case "backflip":
        new_sprite = spr_backflip;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;
		
	case "frontflip":
        new_sprite = spr_frontflip;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;
		
	case "cheesecutter":
        new_sprite = spr_cheesecutter;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;
}

// --- PREVENT ANIMATION STUTTER ---
if (sprite_index != new_sprite) {
    sprite_index = new_sprite;
    image_index = 0;
}

// --- SPLASH BLOCK ---
if (in_water && !was_in_water) {

    // 🔊 SPLASH SOUND (ONE SHOT)
    audio_play_sound(snd_splash2, 1, false);

    // --- CALCULATE FLIPS FIRST ---
    flip_count = floor((abs(rotation) + 90) / 360);
	
	// --- LANDING TYPE CHECK ---
	var landing_angle = (image_angle mod 360 + 360) mod 360;
	var landing_type = "clean";

	if (landing_angle > 135 && landing_angle < 225) {
	    landing_type = "back_slap";
	}
	else if ((landing_angle > 45 && landing_angle < 135) || 
	         (landing_angle > 225 && landing_angle < 315)) {
	    landing_type = "belly_flop";
	}

    var flip_type = "";
    if (rotation > 0) flip_type = "BACKFLIP";
    else if (rotation < 0) flip_type = "FRONTFLIP";

    // --- CREATE LABEL ---
    if (flip_count == 0) last_flip_label = "";
    else if (flip_count == 1) last_flip_label = flip_type;
    else if (flip_count == 2) last_flip_label = "DOUBLE " + flip_type;
    else if (flip_count == 3) last_flip_label = "TRIPLE " + flip_type;
    else if (flip_count == 4) last_flip_label = "QUADRUPLE " + flip_type;
    else last_flip_label = string(flip_count) + "x " + flip_type;

    // --- POPUP STACK ---
    var base_y = y - 40;

    // PENALTY FIRST
    if (landing_type == "back_slap") {
        var popup_penalty = instance_create_layer(x, base_y, "Instances", obj_flip_labels);
        popup_penalty.text = "BACK SLAP";
        popup_penalty.colour = c_red;
        base_y -= 25;
    }
    else if (landing_type == "belly_flop") {
        var popup_penalty = instance_create_layer(x, base_y, "Instances", obj_flip_labels);
        popup_penalty.text = "BELLY FLOP";
        popup_penalty.colour = c_red;
        base_y -= 25;
    }

    // FLIP
    if (flip_count > 0) {
        var popup_flip = instance_create_layer(x, base_y, "Instances", obj_flip_labels);
        popup_flip.text = last_flip_label;
        base_y -= 25;
    }

    // TRICK
    if (performed_cheesecutter) {
        var popup_trick = instance_create_layer(x, base_y, "Instances", obj_flip_labels);
        popup_trick.text = "CHEESECUTTER";
        base_y -= 25;
    }

    // TUCK
    if (tuck_quality != "none") {

        var msg = "";

        switch (tuck_quality) {
            case "perfect": msg = "PERFECT TUCK"; break;
            case "good": msg = "GOOD TUCK"; break;
            case "ok": msg = "OK TUCK"; break;
            case "late": msg = "TOO LATE"; break;
            case "too_early": msg = "TOO EARLY"; break;
            default: msg = "BAD TUCK"; break;
        }

        var popup_tuck = instance_create_layer(x, base_y, "Instances", obj_flip_labels);
        popup_tuck.text = msg;
    }

    // --- POWER ---
    var charge_power = last_charge / max_charge;
    var base_power = lerp(50, 200, charge_power);
    var impact_power = abs(vspeed) * 20;
    var flip_bonus = flip_count * 50;

    var zone_bonus = 0;
    switch (tuck_quality) {
        case "perfect": zone_bonus = 150; break;
        case "good": zone_bonus = 80; break;
        case "ok": zone_bonus = 30; break;
        case "late": zone_bonus = -20; break;
        case "too_early": zone_bonus = -30; break;
        default: zone_bonus = -50; break;
    }

    var raw_power = base_power + zone_bonus + impact_power + flip_bonus;

    splash_power = raw_power * trick_multiplier;
    splash_power = clamp(splash_power, 50, 600);

    // --- HEAVY LANDING PENALTIES ---
    if (landing_type == "back_slap") {
        splash_power *= 0.3;
    }
    else if (landing_type == "belly_flop") {
        splash_power *= 0.15;
    }

    // --- SCORE ---
    var splash_score = round(splash_power);
    splash_score += flip_count * 50;
    splash_score *= trick_multiplier;

    if (landing_type == "back_slap") {
        splash_score -= 300;
    }
    else if (landing_type == "belly_flop") {
        splash_score -= 500;
    }

    splash_score = max(splash_score, -300);

    last_splash_score = current_score;
    current_score = splash_score;

var rotate_input = keyboard_check(vk_right) - keyboard_check(vk_left);

    // --- SPLASH PARTICLES ---
    var count = clamp(round(splash_power / 25), 8, 40);

	var highest_splash = noone;
	var highest_y = 999999;

	repeat (count) {
    var splash = instance_create_layer(x, y, "Instances", obj_splash);

    splash.power = splash_power;

    var scale = (splash_power / 120) * random_range(0.6, 1.2);
    splash.image_xscale = scale;
    splash.image_yscale = scale;

    splash.hspeed = random_range(-4, 4);
    splash.vspeed = -random_range(5, 10) * (splash_power / 140);

    // TRACK HIGHEST SPLASH HERE
    if (splash.y < highest_y) {
        highest_y = splash.y;
        highest_splash = splash;
    }
}

camera_target = highest_splash;
camera_follow = true;
}

    // --- RESET ---
if (global.game_phase == "player" && !player_turn_started) {

    player_turn_started = true;

    x = spawn_x;
    y = spawn_y;

    vspeed = 0;
    hspeed = 0;

    charging = false;
    charge = 0;

    rotation = 0;
    rotation_speed = 0;
    image_angle = 0;

    flip_count = 0;
    last_flip_label = "";
    tuck_quality = "none";

    state = "idle";
    image_index = 0;

    //force ground detection
// Snap player down to ground
while (!place_meeting(x, y + 1, obj_platform)) {
    y += 1;
}

// Now correctly grounded
on_ground = true;
}

// --- RESPAWN SYSTEM ---
if (respawn_timer > 0) {

    respawn_timer--;

    vspeed = 0;
    hspeed = 0;

    if (respawn_timer == 0) {
        x = spawn_x;
        y = spawn_y;

        vspeed = 0;
        hspeed = 0;

        charging = false;
        charge = 0;

        want_untuck = false;
		
		// --- RESET ROTATION ---
		rotation = 0;
		rotation_speed = 0;
		image_angle = 0;

		// --- RESET FLIPS ---
		flip_count = 0;
		last_flip_label = "";

		// --- RESET SPLASH STATE ---
		has_splashed = false;
		tuck_quality = "none";

		state = "idle";
		image_index = 0;
    }
	
	// Camera Reset
	camera_follow = false;
	camera_target = noone;

	var cam = view_camera[0];
	camera_set_view_pos(cam, 0, 738);
}

// --- CAMERA FOLLOW SPLASH ---
if (camera_follow && instance_exists(camera_target)) {

    var cam = view_camera[0];

    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);

    var target_y = camera_target.y - 300;

    cam_y = lerp(cam_y, target_y, 0.08);

    cam_y = clamp(cam_y, 0, room_height - 768);

    camera_set_view_pos(cam, cam_x, cam_y);

    // STOP FOLLOWING WHEN SPLASH SLOWS
    if (abs(camera_target.vspeed) < 0.5) {
    camera_follow = false;
    respawn_timer = 20; //trigger respawn here
	}
}