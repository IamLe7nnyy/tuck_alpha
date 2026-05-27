// --- DEBUG TOGGLE ---
if (keyboard_check_pressed(ord("D"))) {
    cpu_debug = !cpu_debug;
}

// --- DEBUG: FORCE CPU PERFECT DIVE ---
if (cpu_debug && instance_exists(obj_cpu)) {
    obj_cpu.tuck_quality       = "perfect";
    obj_cpu.cpu_rotate_dir     = 1;
    obj_cpu.cpu_will_cheesecut = true;
}

// ============================================================
//  CPU TURN
// ============================================================
if (turn == "cpu" && instance_exists(obj_cpu)) {

    if (obj_cpu.dive_complete && !cpu_scored_this_attempt) {

        cpu_scored_this_attempt = true;
        cpu_attempt++;

        // ADD to total instead of tracking best
        cpu_total += obj_cpu.cpu_score;
        cpu_last   = obj_cpu.cpu_score;

        obj_cpu.dive_complete = false;

        if (cpu_attempt >= max_attempts) {

            // grade the cpu
            cpu_grade = scr_get_grade(cpu_total);

            // spawn player
            turn = "player";
            instance_destroy(cpu);

            var player = instance_create_layer(player_spawn_x, player_spawn_y,
                                               "Instances", obj_player);
            var safety = 0;
            while (!place_meeting(player.x, player.y + 1, obj_platform) && safety < 200) {
                player.y += 1;
                safety++;
            }
            player.vspeed    = 0;
            player.hspeed    = 0;
            player.on_ground = true;

            // reset camera
            camera_follow = false;
            camera_target = noone;
            var cam = view_camera[0];
            camera_set_view_pos(cam, 0, 738);

        } else {
            cpu_scored_this_attempt = false;
        }
    }

    if (instance_exists(obj_cpu)) {
        cpu_score = obj_cpu.cpu_score;
        cpu_last  = obj_cpu.cpu_last_score;
    }
}

// ============================================================
//  PLAYER TURN
// ============================================================
if (turn == "player" && instance_exists(obj_player)) {

    if (obj_player.dive_complete && !player_scored_this_attempt) {

        player_scored_this_attempt = true;
        player_attempt++;

        // ADD to total instead of tracking best
        player_total += obj_player.current_score;
        player_last   = obj_player.current_score;

        obj_player.dive_complete = false;

        if (player_attempt >= max_attempts) {

            // grade the player
            player_grade = scr_get_grade(player_total);

            // award gold if player wins
            if (player_total > cpu_total) {
                var earned = scr_get_gold(player_grade);
                global.gold += earned;
            }
			
			// set cleared label before going to results
switch (global.round) {
    case 1: round_cleared_label = "OPPONENT 1 CLEARED!"; break;
    case 2: round_cleared_label = "OPPONENT 2 CLEARED!"; break;
    case 3: round_cleared_label = "BOSS CLEARED!";       break;
}

turn = "results";

            turn = "results";

        } else {
            player_scored_this_attempt = false;
        }
    }

    player_score = obj_player.current_score;
    player_last  = obj_player.last_splash_score;
}

// ============================================================
//  RESULTS
// ============================================================
if (turn == "results") {
    // handled in Draw GUI
}

// --- CAMERA FOLLOW ---
if (camera_follow && instance_exists(camera_target)) {

    var cam = view_camera[0];
    var cam_y = camera_get_view_y(cam);
    var target_y = camera_target.y - 300;

    cam_y = lerp(cam_y, target_y, 0.08);
    cam_y = clamp(cam_y, 0, room_height - 768);

    camera_set_view_pos(cam, 0, cam_y);

    if (abs(camera_target.vspeed) < 0.5) {
        camera_follow = false;
        camera_target = noone;
        camera_set_view_pos(cam, 0, 738);

        if (turn == "cpu" && instance_exists(obj_cpu)) {
            obj_cpu.respawn_timer = 40;
        }
        if (turn == "player" && instance_exists(obj_player)) {
            obj_player.respawn_timer = 20;
        }
    }
}