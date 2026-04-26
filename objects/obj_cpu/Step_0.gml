// ==============================
// 0. SAFETY CHECK (only exist during CPU turn)
// ==============================
if (global.game_phase != "cpu") {
    instance_destroy();
    exit;
}

// ==============================
// 1. CPU INPUT (AI)
// ==============================

// Reset inputs
cpu_move = 0;
cpu_jump = 0;
cpu_crouch = 0;

// Always move right
cpu_move = 1;

// Charge jump
if (on_ground && vspeed == 0 && !in_water) {
    has_jumped = false;
}

if (on_ground && !has_jumped) {

    cpu_crouch = 1;

    if (charge >= irandom_range(max_charge * 0.6, max_charge)) {
        cpu_jump = 1;
        cpu_crouch = 0;

        has_jumped = true;
    }
}

// Tuck timing
if (!on_ground && !in_water) {

    var water = instance_nearest(x, y, obj_water);

    if (water != noone) {

        var trigger_y = water.bbox_top - 150;

        if (y > trigger_y && y < water.bbox_top) {
            cpu_crouch = 1;
        }
    }
}

// CPU commits to a flip
if (!on_ground && !in_water) {

    if (rotation_speed == 0) {
        rotation_speed = choose(-6, 6); // left or right flip
    }
}

// Force CPU to spin mid-air
if (!on_ground && !in_water) {

    if (rotation_speed == 0) {
        rotation_speed = choose(-6, 6);
    }
}

// ==============================
// 2. FLAG AS CPU
// ==============================
is_cpu = true;


// ==============================
// 3. PLAYER LOGIC (CPU USES THIS)
// ==============================

// --- WATER STATE ---
var was_in_water = in_water;

// --- INPUT ---
var move;
var jump;
var crouch;

move = cpu_move;
jump = cpu_jump;
crouch = cpu_crouch;


// --- GROUND CHECK ---
if (place_meeting(x, y + 1, obj_platform)) {
    on_ground = true;
} else {
    on_ground = false;    
}

// --- WATER STATE ---
in_water = place_meeting(x, y, obj_water);


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


// --- ANGLED JUMP ---
if (charging && jump) {

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

// --- VERTICAL MOVEMENT WITH COLLISION ---
vspeed += gravity;

// Move step-by-step to prevent tunneling
var steps = ceil(abs(vspeed));

repeat (steps) {

    var step_amount = sign(vspeed);

    if (!place_meeting(x, y + step_amount, obj_platform)) {
        y += step_amount;
    }
    else {
        vspeed = 0;
        on_ground = true;
        break;
    }
}


// --- PLATFORM COLLISION ---
if (place_meeting(x, y, obj_platform)) {

    while (place_meeting(x, y, obj_platform)) {
        y -= 1;
    }

    vspeed = 0;
    on_ground = true;
}


// ==============================
// 4. SPLASH BLOCK
// ==============================
if (in_water && !was_in_water) {

    var splash_score = current_score;

    global.cpu_attempt++;
    global.cpu_best_score = max(global.cpu_best_score, splash_score);

    // 🔥 SWITCH TURN
    if (global.cpu_attempt >= global.max_attempts) {
        global.game_phase = "player";
    }

    instance_destroy();
}