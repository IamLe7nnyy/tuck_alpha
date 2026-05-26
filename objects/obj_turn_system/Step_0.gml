// ============================================================
//  CPU TURN
// ============================================================
if (turn == "cpu" && instance_exists(obj_cpu)) {

    // obj_cpu sets respawn_timer = 40 the moment it hits the water.
    // We catch it on that exact frame to record the score.
    if (obj_cpu.respawn_timer == 40 && !cpu_scored_this_attempt) {

        cpu_scored_this_attempt = true;          // don't double-count
        cpu_attempt++;

        var this_score = obj_cpu.cpu_score;
        cpu_last  = this_score;
        cpu_best  = max(cpu_best, this_score);

        if (cpu_attempt >= max_attempts) {

            // --- CPU DONE: spawn player ---
            turn = "player";

            instance_destroy(cpu);   // hide CPU while player goes

            var player = instance_create_layer(player_spawn_x, player_spawn_y,
                                               "Instances", obj_player);
            var safety = 0;
            while (!place_meeting(player.x, player.y + 1, obj_platform) && safety < 200) {
                player.y += 1;
                safety++;
            }
            player.vspeed   = 0;
            player.hspeed   = 0;
            player.on_ground = true;

        } else {
            // reset flag so next attempt can be recorded
            cpu_scored_this_attempt = false;
        }
    }

    // mirror score for HUD
    if (instance_exists(obj_cpu)) {
        cpu_score = obj_cpu.cpu_score;
        cpu_last  = obj_cpu.cpu_last_score;
    }
}


// ============================================================
//  PLAYER TURN
// ============================================================
if (turn == "player" && instance_exists(obj_player)) {

    // obj_player sets respawn_timer = 20 when the splash settles
    if (obj_player.respawn_timer == 20 && !player_scored_this_attempt) {

        player_scored_this_attempt = true;
        player_attempt++;

        var this_score = obj_player.current_score;
        player_last  = this_score;
        player_best  = max(player_best, this_score);

        if (player_attempt >= max_attempts) {
            turn = "results";
        } else {
            player_scored_this_attempt = false;
        }
    }

    // mirror score for HUD
    player_score = obj_player.current_score;
    player_last  = obj_player.last_splash_score;
}


// ============================================================
//  RESULTS: wait for any key, then show winner
// ============================================================
if (turn == "results") {
    // nothing extra needed here; Draw GUI shows the winner screen
}