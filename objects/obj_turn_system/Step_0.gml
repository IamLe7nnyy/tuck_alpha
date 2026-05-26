// --- CPU TURN ---
if (turn == "cpu") {

    if (instance_exists(obj_cpu)) {

        // detect END of dive (when respawn starts)
        if (obj_cpu.respawn_timer == 40) {

            cpu_attempt++;

            cpu_best = max(cpu_best, obj_cpu.cpu_score);

            if (cpu_attempt > 3) {

    cpu_done = true;
    turn = "player";

    // --- CREATE PLAYER IF NEEDED ---
    if (!instance_exists(obj_player)) {

        var player = instance_create_layer(player_spawn_x, player_spawn_y, "Instances", obj_player);

        var safety = 0;
        while (!place_meeting(player.x, player.y + 1, obj_platform) && safety < 200) {
            player.y += 1;
            safety++;
        }

        player.vspeed = 0;
        player.hspeed = 0;
        player.on_ground = true;
    }
}
            else {
                // reset CPU for next attempt
                cpu.x = cpu_spawn_x;
                cpu.y = cpu_spawn_y;

                var safety = 0;
                while (!place_meeting(cpu.x, cpu.y + 1, obj_platform) && safety < 200) {
                    cpu.y += 1;
                    safety++;
                }

                cpu.vspeed = 0;
                cpu.hspeed = 0;
                cpu.on_ground = true;
            }
        }
    }
}


// --- PLAYER TURN ---
if (turn == "player") {

    if (instance_exists(obj_player)) {

        // detect END of dive
        if (obj_player.respawn_timer == 20) {

            player_attempt++;

            player_best = max(player_best, obj_player.current_score);

            if (player_attempt > 3) {
                player_done = true;
            }
        }
    }
}


// --- DEBUG ---
draw_text(20, 20, "TURN: " + string_upper(turn));

draw_text(20, 50, "CPU ATTEMPT: " + string(cpu_attempt));
draw_text(20, 70, "PLAYER ATTEMPT: " + string(player_attempt));

draw_text(20, 100, "CPU BEST: " + string(cpu_best));
draw_text(20, 120, "PLAYER BEST: " + string(player_best));


// --- SCORE TRACKING ---
if (instance_exists(obj_player)) {
    player_score = obj_player.current_score;
    player_last = obj_player.last_splash_score;
}

if (instance_exists(obj_cpu)) {
    cpu_score = obj_cpu.cpu_score;
    cpu_last = obj_cpu.cpu_last_score;
}