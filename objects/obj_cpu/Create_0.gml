is_cpu = true;
move = 0;
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
perfect_window = 6;
just_tucked = false;

// --- TUCK TIMING VISUAL ZONES ---
show_zones = false;
current_score = 0;
last_splash_score = 0;

// --- AIR ROTATION ---
tuck_quality = "none";

// --- ROTATION TRACKING ---
rotation = 0;
rotation_speed = 0;
flip_count = 0;
last_flip_label = "";

// --- TRICKS ---
trick_multiplier = 1;
performed_cheesecutter = false;

// --- one jump per attempt ---
has_jumped = false;
last_rotation = 0;
water_frames = 0;
cpu_score = 0;
cpu_last_score = 0;
air_action = "none";
cpu_release_threshold = 0;

// --- Turn attempts
dive_complete = false;

// --- AI DECISIONS (set at jump time, not per frame) ---
cpu_will_cheesecut = false;    // ← decided once per jump
cpu_rotate_dir = 0;            // ← -1, 0, or 1 — decided once per jump
cpu_tuck_y = 0;                // ← y position to trigger tuck — decided once per jump
impact_vspeed = 0;