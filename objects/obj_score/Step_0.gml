// --- SWITCH TO PLAYER ---
if (keyboard_check_pressed(ord("T"))) {

    turn = "player";

    if (!instance_exists(obj_player)) {

        var player = instance_create_layer(player_spawn_x, player_spawn_y, "Instances", obj_player);

        var safety = 0;
        while (!place_meeting(player.x, player.y + 1, obj_platform) && safety < 1000) {
            player.y += 1;
            safety++;
        }

        player.vspeed = 0;
        player.hspeed = 0;
        player.on_ground = true;
    }
}


// --- SWITCH TO CPU ---
if (keyboard_check_pressed(ord("Y"))) {

    turn = "cpu";

    if (cpu != noone) {

        cpu.x = cpu_spawn_x;
        cpu.y = cpu_spawn_y;

        var safety = 0;
        while (!place_meeting(cpu.x, cpu.y + 1, obj_platform) && safety < 1000) {
            cpu.y += 1;
            safety++;
        }

        cpu.vspeed = 0;
        cpu.hspeed = 0;
        cpu.on_ground = true;
    }
}


// --- DEBUG ---
draw_text(20, 20, "TURN: " + string_upper(turn));

if (instance_exists(obj_player)) {
    player_score = obj_player.current_score;
    player_last = obj_player.last_splash_score;
}

if (instance_exists(obj_cpu)) {
    cpu_score = obj_cpu.cpu_score;
    cpu_last = obj_cpu.cpu_last_score;
}