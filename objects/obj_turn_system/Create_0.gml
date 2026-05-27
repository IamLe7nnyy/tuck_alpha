// initialise globals if they don't exist
if (!variable_global_exists("ante")) {
    global.ante = 1;
}
if (!variable_global_exists("round")) {
    global.round = 1;
}
if (!variable_global_exists("run_active")) {
    global.run_active = true;
}
if (!variable_global_exists("gold")) {
    global.gold = 0;
}
if (!variable_global_exists("run_ante")) {
    global.run_ante = 1;
}
if (!variable_global_exists("run_round")) {
    global.run_round = 1;
}
if (!variable_global_exists("run_gold_earned")) {
    global.run_gold_earned = 0;
}

cpu_scored_this_attempt    = false;
player_scored_this_attempt = false;

turn = "cpu";           // "cpu" | "player" | "results"

cpu_attempt  = 0;       // counts completed dives (0 before any)
player_attempt = 0;

//Grade system
player_total = 0;
cpu_total    = 0;
player_grade = "";
cpu_grade    = "";

cpu_scored_this_attempt    = false;
player_scored_this_attempt = false;

max_attempts = 3;

// spawn positions
cpu_spawn_x    = 250;
cpu_spawn_y    = 750;
player_spawn_x = 250;
player_spawn_y = 1000;

// score display helpers
player_score = 0;
player_last  = 0;
cpu_score    = 0;
cpu_last     = 0;

// --- SPAWN CPU ---
cpu = instance_create_layer(cpu_spawn_x, cpu_spawn_y, "Instances", obj_cpu);

var safety = 0;
while (!place_meeting(cpu.x, cpu.y + 1, obj_platform) && safety < 200) {
    cpu.y += 1;
    safety++;
}
cpu.vspeed   = 0;
cpu.hspeed   = 0;
cpu.on_ground = true;

cpu_scored_this_attempt  = false;   // add to obj_turn_system Create, not obj_cpu
player_scored_this_attempt = false;

// --- CAMERA ---
camera_follow = false;
camera_target = noone;

cpu_debug = false;

round_cleared_label = "";
