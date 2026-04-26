draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_color(c_black);
draw_set_font(-1);

// --- CURRENT SCORE ---
draw_text(20, 20, "SCORE: " + string(current_score));

// --- LAST SCORE ---
draw_text(20, 50, "LAST SCORE: " + string(last_splash_score));

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

var cx = display_get_gui_width() / 2;

// ========================
// CPU TURN
// ========================
if (global.game_phase == "cpu") {

    draw_text(cx, 20, "CPU TURN (" + string(global.cpu_attempt) + "/" + string(global.max_attempts) + ")");
    draw_text(cx, 50, "BEST: " + string(global.cpu_best_score));
}

// ========================
// PLAYER TURN
// ========================
//else if (global.game_phase == "player") {

   // draw_text(cx, 20, "PLAYER TURN (" + string(global.player_attempt) + "/" + string(global.max_attempts) + ")");
   // draw_text(cx, 50, "BEST: " + string(global.player_best_score));
   // draw_text(cx, 80, "TARGET: " + string(global.cpu_best_score));
//}

// ========================
// RESULT
// ========================
else if (global.game_phase == "result") {

    var result_text;

    if (global.player_best_score > global.cpu_best_score) {
        result_text = "YOU WIN!";
    } else {
        result_text = "CPU WINS!";
    }

    draw_text(cx, 20, result_text);
    draw_text(cx, 60, "PLAYER: " + string(global.player_best_score));
    draw_text(cx, 90, "CPU: " + string(global.cpu_best_score));
}