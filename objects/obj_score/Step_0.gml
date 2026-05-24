// Switch to player
if (keyboard_check_pressed(ord("T"))) {

    turn = "player";

    if (!instance_exists(obj_player)) {
        instance_create_layer(100, 50, "Instances", obj_player);
    }
}

// Y = cpu turn
if (keyboard_check_pressed(ord("Y"))) {
    turn = "cpu";
	
	    if (!instance_exists(obj_cpu)) {
        instance_create_layer(100, 50, "Instances", obj_cpu);
    }
}

draw_text(20, 20, "TURN: " + string_upper(turn));

if (instance_exists(obj_player)) {
    player_score = obj_player.current_score;
    player_last = obj_player.last_splash_score;
}

if (instance_exists(obj_cpu)) {
    cpu_score = obj_cpu.cpu_score;
    cpu_last = obj_cpu.cpu_last_score;
}