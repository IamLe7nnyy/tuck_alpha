// --- TURN ---
turn = "cpu";

// --- SPAWN POSITIONS ---
cpu_spawn_x = 300;
cpu_spawn_y = 100;

player_spawn_x = 300;
player_spawn_y = 100;

// --- SCORE TRACKING ---
player_score = 0;
player_last = 0;

cpu_score = 0;
cpu_last = 0;

// --- CREATE CPU ONCE ---
cpu = instance_create_layer(cpu_spawn_x, cpu_spawn_y, "Instances", obj_cpu);

// snap CPU to ground
var safety = 0;
while (!place_meeting(cpu.x, cpu.y + 1, obj_platform) && safety < 1000) {
    cpu.y += 1;
    safety++;
}

cpu.vspeed = 0;
cpu.hspeed = 0;
cpu.on_ground = true;