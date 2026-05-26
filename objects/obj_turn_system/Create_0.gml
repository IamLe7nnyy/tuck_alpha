// --- GLOBAL RUN STATE (safe fallback) ---
if (!variable_global_exists("ante")) {
    global.ante  = 1;
}
if (!variable_global_exists("round")) {
    global.round = 1;
}
if (!variable_global_exists("run_active")) {
    global.run_active = true;
}

cpu_scored_this_attempt    = false;
player_scored_this_attempt = false;

turn = "cpu";           // "cpu" | "player" | "results"

cpu_attempt  = 0;       // counts completed dives (0 before any)
player_attempt = 0;

cpu_best    = 0;
player_best = 0;

max_attempts = 3;

// spawn positions
cpu_spawn_x    = 300;
cpu_spawn_y    = 100;
player_spawn_x = 300;
player_spawn_y = 100;

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