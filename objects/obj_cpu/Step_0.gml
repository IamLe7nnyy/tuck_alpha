// --- RESPAWN SYSTEM ---
if (respawn_timer > 0) {

    respawn_timer--;

    vspeed = 0;
    hspeed = 0;

    if (respawn_timer > 0) exit;

    // --- RESPAWN ---
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

    performed_cheesecutter = false;
    trick_multiplier = 1;

    state = "idle";
    image_index = 0;

    var safety = 0;
    while (!place_meeting(x, y + 1, obj_platform) && safety < 1000) {
        y += 1;
        safety++;
    }

    on_ground = true;

    exit;
}


// --- WATER STATE ---
var was_in_water = in_water;


// --- CPU INPUT ---
var crouch = false;


// --- GROUND BEHAVIOUR ---
if (on_ground) {

    // stay still on ground (prevents jitter)
    move = 0;
    hspeed = 0;

    crouch = true;
}


// --- RELEASE JUMP ---
if (charging && charge > irandom_range(max_charge * 0.4, max_charge * 0.9)) {
    crouch = false;
}


// --- AIR CONTROL (STABLE) ---
if (!on_ground) {

    // choose direction ONCE per jump
    if (abs(hspeed) < 0.1) {
        move = choose(-1, 1);
    }

    // occasional trick
    if (random(1) < 0.02 && !performed_cheesecutter) {
        performed_cheesecutter = true;
        trick_multiplier = 2;
    }
	
	if (!on_ground && random(1) < 0.03) {
    tuck_quality = choose("bad", "ok", "good", "perfect");
}
}


// --- GROUND CHECK ---
on_ground = place_meeting(x, y + 1, obj_platform);

//RESET AIR ACTION WHEN LANDED
if (on_ground) {
    air_action = "none";
}


// --- WATER STATE ---
in_water = place_meeting(x, bbox_bottom, obj_water);


// --- AUTO UNTUCK ---
if (in_water && !crouch && untuck_timer <= 0) {
    untuck_timer = 10;
}


// --- CHARGING ---
if (on_ground && crouch) {
    charging = true;

    charge += 0.5;
    charge = min(charge, max_charge);
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


// --- JUMP ---
if (charging && !crouch) {

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
	air_action = choose("frontflip", "backflip", "tuck", "none");
}


// --- GRAVITY ---
if (!on_ground) {

    var rotate_input = move;
    var target_speed = rotate_input * 6;
    rotation_speed = lerp(rotation_speed, target_speed, 0.2);

    rotation -= rotation_speed;
    image_angle = rotation;

    if (in_water) {
        vspeed += gravity * 3;
    } else {
        vspeed += gravity;
    }
}


// --- APPLY VERTICAL ---
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
}


// --- STATE SYSTEM ---
if (untuck_timer > 0) {
    state = "untuck";
}
else if (charging) {
    state = "crouch";
}
else if (!on_ground) {

    if (performed_cheesecutter) {
        state = "cheesecutter";
    }
    else {

        switch (air_action) {

            case "tuck":
                state = "tuck";
                break;

            case "backflip":
                state = "backflip";
                break;

            case "frontflip":
                state = "frontflip";
                break;

            default:
                state = "jump";
        }
    }
}
else if (abs(hspeed) > 0.5) {
    state = "walk";
}
else {
    state = "idle";
}


// --- ANIMATION ---
var new_sprite;

switch (state) {

    case "idle": new_sprite = spr_idle_1; image_speed = 0.1; break;
    case "walk": new_sprite = spr_walk_1; image_speed = 0.3; break;

    case "jump": new_sprite = spr_jump_1; break;
    case "crouch": new_sprite = spr_crouch_1; break;
    case "tuck": new_sprite = spr_tuck_1; break;
    case "untuck": new_sprite = spr_untuck_1; break;
    case "backflip": new_sprite = spr_backflip_1; break;
    case "frontflip": new_sprite = spr_frontflip_1; break;
    case "cheesecutter": new_sprite = spr_cheesecutter_1; break;
}

if (sprite_index != new_sprite) {
    sprite_index = new_sprite;
    image_index = 0;
}


// --- SPLASH ---
if (in_water && !was_in_water && vspeed > 1) {

    audio_play_sound(snd_splash2, 1, false);

    flip_count = floor((abs(rotation) + 90) / 360);

    var charge_power = last_charge / max_charge;
    var splash_power = lerp(50, 200, charge_power);

    // --- POPUP TEXT ---
var base_y = y - 40;

// flip label
if (flip_count > 0) {
    var popup_flip = instance_create_layer(x, base_y, "Instances", obj_flip_labels);
    popup_flip.text = string(flip_count) + "x FLIP";
    base_y -= 25;
}

// trick
if (performed_cheesecutter) {
    var popup_trick = instance_create_layer(x, base_y, "Instances", obj_flip_labels);
    popup_trick.text = "CHEESECUTTER";
    base_y -= 25;
}

// tuck
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

    var count = clamp(round(splash_power / 25), 8, 40);

    highest_splash = noone;
    var highest_y = 999999;

    repeat (count) {
        var splash = instance_create_layer(x, y, "Instances", obj_splash);

        splash.vspeed = -random_range(5, 10);

        if (splash.y < highest_y) {
            highest_y = splash.y;
            highest_splash = splash;
        }
    }

    camera_target = highest_splash;
    camera_follow = true;

    // --- TRIGGER RESPAWN ---
    respawn_timer = 15;

    vspeed = 0;
    hspeed = 0;
}