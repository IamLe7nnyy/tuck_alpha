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
if (!variable_global_exists("item_bottle")) {
    global.item_bottle = 0;
}
if (!variable_global_exists("bottle_equipped")) {
    global.bottle_equipped = false;
}
if (!variable_global_exists("has_cheesecutter")) {
    global.has_cheesecutter = false;
}
if (!variable_global_exists("cheesecutter_cooldown")) {
    global.cheesecutter_cooldown = 0;
}
if (!variable_global_exists("cheesecutter_unlocked_shown")) {
    global.cheesecutter_unlocked_shown = false;
}

turn           = "cpu";
cpu_attempt    = 0;
player_attempt = 0;

// grade system
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

// --- CAMERA ---
camera_follow = false;
camera_target = noone;

cpu_debug           = false;
round_cleared_label = "";

// --- BOSS DEMO SETUP --- must be before spawn
is_boss_round = (global.round == 3);
demo_phase    = "none";
demo_timer    = 0;
demo_cpu      = noone;

// --- SPAWN CPU ---
if (is_boss_round) {

    turn       = "boss_demo";
    demo_phase = "diving";

    demo_cpu = instance_create_layer(cpu_spawn_x, cpu_spawn_y, "Instances", obj_cpu);
    var safety = 0;
    while (!place_meeting(demo_cpu.x, demo_cpu.y + 1, obj_platform) && safety < 200) {
        demo_cpu.y += 1;
        safety++;
    }
    demo_cpu.vspeed    = 0;
    demo_cpu.hspeed    = 0;
    demo_cpu.on_ground = true;

    // force demo dive settings
    demo_cpu.cpu_will_cheesecut = true;
    demo_cpu.is_demo            = true;

} else {

    turn = "cpu";
    cpu = instance_create_layer(cpu_spawn_x, cpu_spawn_y, "Instances", obj_cpu);
    var safety = 0;
    while (!place_meeting(cpu.x, cpu.y + 1, obj_platform) && safety < 200) {
        cpu.y += 1;
        safety++;
    }
    cpu.vspeed    = 0;
    cpu.hspeed    = 0;
    cpu.on_ground = true;
}

game_paused = false;
pause_click_ready = false;

time_scale = 1;

