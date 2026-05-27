if (obj_turn_system.turn != "cpu" && obj_turn_system.turn != "boss_demo") {
    exit;
}

// --- RESPAWN SYSTEM ---
if (respawn_timer > 0) {

    respawn_timer--;

    vspeed = 0;
    hspeed = 0;

    if (respawn_timer > 0) exit;

    x = spawn_x;
    y = spawn_y;

    vspeed = 0;
    hspeed = 0;

    charging = false;
    charge = 0;
    cpu_release_threshold = 0;

    rotation = 0;
    rotation_speed = 0;
    image_angle = 0;

    flip_count = 0;
    last_flip_label = "";
    tuck_quality = "none";

    performed_cheesecutter = false;
    trick_multiplier = 1;

    // reset AI decisions — always safe to wipe on respawn
    cpu_will_cheesecut = false;
    cpu_rotate_dir     = 0;
    cpu_tuck_y         = 0;

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


// --- CPU INPUT ---
var crouch = false;


// --- GROUND ---
if (on_ground) {
    move = 0;
    hspeed = 0;
    crouch = true;
}


// --- SET RELEASE THRESHOLD ONCE ---
if (charging && cpu_release_threshold == 0) {
    cpu_release_threshold = irandom_range(max_charge * 0.4, max_charge * 0.9);
}

// --- RELEASE JUMP ---
if (charging && charge > cpu_release_threshold) {
    crouch = false;
}


// --- GROUND CHECK ---
on_ground = place_meeting(x, y + 1, obj_platform);

if (on_ground) {
    air_action = "none";
}


// --- WATER STATE ---
if (place_meeting(x, bbox_bottom, obj_water)) {
    water_frames++;
} else {
    water_frames = 0;
}

var was_in_water = in_water;
in_water = (water_frames >= 2);


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


// --- MOVE ---
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

    var charge_power = charge / max_charge;

    vspeed = -lerp(1, 6, charge_power);
    hspeed = lerp(1, 5, charge_power);

    last_charge = charge;

    charging = false;
    charge = 0;
    on_ground = false;
    cpu_release_threshold = 0;

    tuck_quality = "none";

    // force tuck for demo dive
    if (is_demo) {
        air_action = "tuck";
    } else {
        air_action = choose("frontflip", "backflip", "tuck", "none");
    }

    // --- DECIDE ALL AI TRICKS AT JUMP TIME ---
    // if is_demo, keep cpu_will_cheesecut as set at spawn (true)
if (!is_demo) {
    if (global.round == 3 && !performed_cheesecutter 
    &&  global.cheesecutter_cooldown == 0) {    // ← add this check
        cpu_will_cheesecut = (random(1) < 0.5);
    } else {
        cpu_will_cheesecut = false;
    }
}
    trick_multiplier = 1;
    performed_cheesecutter = false;

    // rotation direction driven by air_action
    switch (air_action) {
        case "frontflip": cpu_rotate_dir = -1; break;
        case "backflip":  cpu_rotate_dir = 1;  break;
        case "tuck":      cpu_rotate_dir = 0;  break;
        default:          cpu_rotate_dir = 0;  break;
    }

    // decide tuck y position based on water location
    var water = instance_nearest(x, y, obj_water);
    if (water != noone) {
        var total_height = 100;
        var zone_height = total_height / 2;
        var zone_offset = 120;
        var top_zone = water.bbox_top - total_height - zone_offset;
        var zone_pick = irandom(4);
        cpu_tuck_y = top_zone + (zone_height * zone_pick) + (zone_height * 0.5);
        switch (zone_pick) {
            case 0: tuck_quality = "ok";      break;
            case 1: tuck_quality = "good";    break;
            case 2: tuck_quality = "perfect"; break;
            case 3: tuck_quality = "good";    break;
            case 4: tuck_quality = "ok";      break;
        }
    } else {
        cpu_tuck_y = 99999;
        tuck_quality = "bad";
    }

    state = "jump";
}


// --- AIR CONTROL ---
if (!on_ground) {
    show_debug_message("in air — cpu_will_cheesecut: " + string(cpu_will_cheesecut) + " vspeed: " + string(vspeed) + " performed: " + string(performed_cheesecutter));
if (cpu_will_cheesecut && !performed_cheesecutter && vspeed > 0) {
    performed_cheesecutter = true;
    trick_multiplier = 2;
    cpu_will_cheesecut = false;
    global.cheesecutter_cooldown = 1; // same cooldown as player
    show_debug_message("CHEESECUTTER FIRED");
}
}


// --- GRAVITY ---
if (!on_ground) {

    var target_speed = cpu_rotate_dir * 6;
    rotation_speed = lerp(rotation_speed, target_speed, 0.2);
    rotation_speed = clamp(rotation_speed, -6, 6);

    rotation -= rotation_speed;
    image_angle = rotation;

    vspeed += in_water ? gravity * 3 : gravity;
}


// --- APPLY Y ---
y += vspeed;


// --- CAPTURE IMPACT SPEED ---
if (!in_water) {
    impact_vspeed = vspeed;
}


// --- COLLISION ---
if (place_meeting(x, y, obj_platform)) {

    while (place_meeting(x, y, obj_platform)) {
        y -= 1;
    }

    vspeed = 0;
    on_ground = true;
}


// --- UNTUCK ---
if (untuck_timer > 0) untuck_timer--;


// --- STATE ---
if (untuck_timer > 0) {
    state = "untuck";
}
else if (!on_ground) {
    if (performed_cheesecutter) state = "cheesecutter";
    else {
        switch (air_action) {
            case "tuck":      state = "tuck";      break;
            case "backflip":  state = "backflip";  break;
            case "frontflip": state = "frontflip"; break;
            default:          state = "jump";
        }
    }
}
else if (charging) {
    state = "crouch";
}
else if (abs(hspeed) > 0.5) {
    state = "walk";
}
else {
    state = "idle";
}


// --- ANIMATION ---
var new_sprite = spr_idle_1;

switch (state) {
    case "idle":
        new_sprite = spr_idle_1;
        image_speed = 0.1;
        break;

    case "walk":
        new_sprite = spr_walk_1;
        image_speed = 0.3;
        break;

    case "jump":
        new_sprite = spr_jump_1;
        image_speed = 0.4;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "crouch":
        new_sprite = spr_crouch_1;
        image_speed = 0.2;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "tuck":
        new_sprite = spr_tuck_1;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "untuck":
        new_sprite = spr_untuck_1;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "backflip":
        new_sprite = spr_backflip_1;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "frontflip":
        new_sprite = spr_frontflip_1;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;

    case "cheesecutter":
        new_sprite = spr_cheesecutter_1;
        image_speed = 0.8;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        break;
}

if (new_sprite == noone) new_sprite = spr_idle_1;

if (sprite_index != new_sprite) {
    sprite_index = new_sprite;
    image_index  = 0;
}


// --- SPLASH ---
if (in_water && !was_in_water) {
    audio_play_sound(snd_splash2, 1, false);

    if (!is_demo) {
        dive_complete = true;
    }

    flip_count = floor((abs(rotation) + 90) / 360);
    var landing_angle = (image_angle mod 360 + 360) mod 360;
    var landing_type = "clean";
    if (landing_angle > 135 && landing_angle < 225) landing_type = "back_slap";
    else if ((landing_angle > 45 && landing_angle < 135) || (landing_angle > 225 && landing_angle < 315)) landing_type = "belly_flop";
    var flip_type = image_angle > 0 ? "BACKFLIP" : "FRONTFLIP";
    if (flip_count == 0)      last_flip_label = "";
    else if (flip_count == 1) last_flip_label = flip_type;
    else if (flip_count == 2) last_flip_label = "DOUBLE " + flip_type;
    else if (flip_count == 3) last_flip_label = "TRIPLE " + flip_type;
    else if (flip_count == 4) last_flip_label = "QUADRUPLE " + flip_type;
    else                      last_flip_label = string(flip_count) + "x " + flip_type;
    var base_y = y - 40;
    if (landing_type != "clean") {
        var popup = instance_create_layer(x, base_y, layer, obj_flip_labels);
        popup.text = landing_type == "belly_flop" ? "BELLY FLOP" : "BACK SLAP";
        popup.colour = c_red;
        base_y -= 25;
    }
    if (flip_count > 0) {
        var popup = instance_create_layer(x, base_y, layer, obj_flip_labels);
        popup.text = last_flip_label;
        base_y -= 25;
    }
    if (performed_cheesecutter) {
        var popup = instance_create_layer(x, base_y, layer, obj_flip_labels);
        popup.text = "CHEESECUTTER";
        base_y -= 25;
    }
    if (tuck_quality != "none") {
        var popup = instance_create_layer(x, base_y, layer, obj_flip_labels);
        popup.text = string_upper(tuck_quality) + " TUCK";
    }

    // --- POWER ---
    var charge_power = last_charge / max_charge;
    var base_power   = lerp(50, 200, charge_power);
    var impact_power = abs(vspeed) * 20;
    var flip_bonus   = flip_count * 50;

    var zone_bonus = 0;
    switch (tuck_quality) {
        case "perfect":   zone_bonus =  150; break;
        case "good":      zone_bonus =   80; break;
        case "ok":        zone_bonus =   30; break;
        case "late":      zone_bonus =  -20; break;
        case "too_early": zone_bonus =  -30; break;
        default:          zone_bonus =  -50; break;
    }

    var raw_power = base_power + zone_bonus + impact_power + flip_bonus;
    var splash_power = raw_power * trick_multiplier;

    // --- LANDING PENALTIES ---
    if (landing_type == "back_slap")  splash_power *= 0.3;
    if (landing_type == "belly_flop") splash_power *= 0.15;

    splash_power = clamp(splash_power, 50, 1000);

    // --- SCORE ---
    var splash_score = round(splash_power);

    if (landing_type == "back_slap")  splash_score -= 300;
    if (landing_type == "belly_flop") splash_score -= 500;

    splash_score = max(splash_score, -300);

    cpu_last_score = cpu_score;
    cpu_score      = splash_score;

    var count = clamp(round(splash_power / 25), 8, 40);

    var highest_splash = noone;
    var highest_y = 999999;
    repeat (count) {
        var splash = instance_create_layer(x, y, "Instances", obj_splash);
        splash.power = splash_power;
        splash.image_xscale = (splash_power / 120) * random_range(0.6, 1.2);
        splash.image_yscale = splash.image_xscale;
        splash.hspeed = random_range(-4, 4);
        splash.vspeed = -random_range(5, 10) * (splash_power / 140);
        if (splash.y < highest_y) {
            highest_y = splash.y;
            highest_splash = splash;
        }
    }
    obj_turn_system.camera_target = highest_splash;
    obj_turn_system.camera_follow = true;
    vspeed = 0;
    hspeed = 0;
}