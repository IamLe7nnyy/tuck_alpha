draw_set_font(-1);

var cx = display_get_gui_width()  / 2;
var cy = display_get_gui_height() / 2;

// ============================================================
//  RESULTS SCREEN
// ============================================================
if (turn == "results") {

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // dim background
    draw_set_color(c_black);
    draw_set_alpha(0.55);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    // scores
    draw_set_color(c_white);
    draw_text(cx, cy - 100, "=== RESULTS ===");
    draw_text(cx, cy -  60, "YOUR BEST:  " + string(player_best));
    draw_text(cx, cy -  30, "CPU BEST:   " + string(cpu_best));

    // winner
    if (player_best > cpu_best) {
        draw_set_color(c_lime);
        draw_text(cx, cy + 20, "YOU WIN!");
    } else if (cpu_best > player_best) {
        draw_set_color(c_red);
        draw_text(cx, cy + 20, "CPU WINS!");
    } else {
        draw_set_color(c_yellow);
        draw_text(cx, cy + 20, "IT'S A TIE!");
    }

    draw_set_color(c_white);
    draw_text(cx, cy + 60, "PRESS ENTER TO CONTINUE");

    if (keyboard_check_pressed(vk_enter)) {
        if (player_best >= cpu_best) {
            scr_advance();
        } else {
            scr_lose();
        }
    }

    exit;
}

// ============================================================
//  IN-GAME HUD
// ============================================================
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);

var turn_label = (turn == "cpu") ? "CPU'S TURN" : "YOUR TURN";
draw_text(20, 20, turn_label);

var current_attempt = (turn == "cpu") ? cpu_attempt + 1 : player_attempt + 1;
draw_text(20, 45, "DIVE " + string(min(current_attempt, max_attempts)) + " / " + string(max_attempts));

draw_text(20, 80,  "YOUR BEST:  " + string(player_best));
draw_text(20, 100, "CPU BEST:   " + string(cpu_best));

if (turn == "player" && player_last != 0) {
    draw_text(20, 130, "LAST DIVE:  " + string(player_last));
}
if (turn == "cpu" && cpu_last != 0) {
    draw_text(20, 130, "LAST DIVE:  " + string(cpu_last));
}