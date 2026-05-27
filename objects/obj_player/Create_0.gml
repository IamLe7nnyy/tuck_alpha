// --- MOVEMENT ---
vspeed = 0;
hspeed = 0;
move_speed = 4;

// --- GRAVITY ---
gravity = 0.1;

// --- JUMP ---
jump_strength = -0.2;

// --- CHARGE SYSTEM ---
charge = 0;
max_charge = 30;
charging = false;

// --- STATE ---
on_ground = false;
state = "idle";

// --- RESPAWN ---
spawn_x = x;
spawn_y = y;

respawn_timer = 0;

// --- UNTUCK ---
want_untuck = true;
untuck_timer = 0;

// --- SPLASH / WATER ---
in_water = false;
last_charge = 0;
tuck_time = 0;

// --- TUCK TIMING ---
perfect_window = 6;     // frames window for "perfect timing"
just_tucked = false;

// --- TUCK TIMING VISUAL ZONES ---
show_zones = false;

current_score = 0;
last_splash_score = 0;

// --- AIR ROTATION ---
rotation = 0;
rotation_speed = 0;

tuck_quality = "none";

// --- ROTATION TRACKING ---
rotation = 0;
rotation_speed = 0;

flip_count = 0;
last_flip_label = "";

// --- TRICKS ---
performed_cheesecutter = false;
trick_multiplier = 1;

// --- TURN PHASES --- (This is for future)
global.game_phase = "cpu";

global.cpu_attempt = 0;
global.player_attempt = 0;

global.cpu_best_score = 0;
global.player_best_score = 0;

global.max_attempts = 3;

player_turn_started = false;

cpu_crouch = 0;

cpu_move = 0;
cpu_jump = 0;
cpu_crouch = 0;

//turn attempts
dive_complete = false;