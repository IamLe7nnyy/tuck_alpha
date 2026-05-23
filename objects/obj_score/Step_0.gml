if (instance_exists(obj_player)) {
    player_score = obj_player.current_score;
    player_last = obj_player.last_splash_score;
}

if (instance_exists(obj_cpu)) {
    cpu_score = obj_cpu.cpu_score;
    cpu_last = obj_cpu.cpu_last_score;
}