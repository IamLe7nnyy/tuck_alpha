is_cpu = true;

cpu_move = 0;
cpu_jump = 0;
cpu_crouch = 0;

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
tuck_quality = "none";

// --- ROTATION TRACKING ---
rotation = 0;
rotation_speed = 0;

flip_count = 0;
last_flip_label = "";

// --- TRICKS ---
trick_multiplier = 1;

performed_cheesecutter = false;

// --- CAMERA ---
var cam = view_camera[0];
camera_target = noone;
camera_follow = false;

// --- one jump per attempt ---
has_jumped = false;