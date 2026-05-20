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
tuck_quality = "none";

// --- TUCK TIMING ---
perfect_window = 6;
just_tucked = false;

// --- VISUAL ---
show_zones = false;

// --- SCORE ---
current_score = 0;
last_splash_score = 0;

// --- ROTATION ---
rotation = 0;
rotation_speed = 0;

// --- FLIPS ---
flip_count = 0;
last_flip_label = "";

// --- TRICKS ---
trick_multiplier = 1;
performed_cheesecutter = false;

// --- CAMERA ---
camera_target = noone;
camera_follow = false;

// --- SPLASH TRACKING (IMPORTANT FIX) ---
highest_splash = noone;

// --- SOUND ---
water_sound = audio_play_sound(snd_water, 1, true);
music_sound = audio_play_sound(snd_french_letter, 1, true);

// --- SET DEFAULT VOLUME ---
audio_sound_gain(water_sound, 0, 0);
audio_sound_gain(music_sound, 0, 0);