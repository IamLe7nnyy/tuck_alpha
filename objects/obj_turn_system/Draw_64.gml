draw_set_font(-1);

var cx = display_get_gui_width()  / 2;
var cy = display_get_gui_height() / 2;
var sw = display_get_gui_width();

// ============================================================
//  RESULTS SCREEN
// ============================================================
if (turn == "results") {

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // dim background
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, sw, display_get_gui_height(), false);
    draw_set_alpha(1);

    // title
    draw_set_color(c_white);
    draw_text(cx, cy - 160, "=== RESULTS ===");

    // player results
    draw_set_color(c_white);
    draw_text(cx - 100, cy - 110, "YOU");
    draw_text(cx - 100, cy - 80, "Total: " + string(player_total));

    var pg_col = scr_grade_colour(player_grade);
    draw_set_color(pg_col);
    draw_text(cx - 100, cy - 50, "Grade: " + player_grade);

    // cpu results
    draw_set_color(c_white);
    draw_text(cx + 100, cy - 110, "CPU");
    draw_text(cx + 100, cy - 80, "Total: " + string(cpu_total));

    var cg_col = scr_grade_colour(cpu_grade);
    draw_set_color(cg_col);
    draw_text(cx + 100, cy - 50, "Grade: " + cpu_grade);

    // winner
    if (player_total > cpu_total) {

        // cleared label
        draw_set_color(c_lime);
        draw_text(cx, cy, round_cleared_label);

        draw_set_color(c_lime);
        draw_text(cx, cy + 35, "YOU WIN!");

        draw_set_color(c_yellow);
        var earned = scr_get_gold(player_grade);
        draw_text(cx, cy + 65, "+" + string(earned) + " GOLD  |  TOTAL: " + string(global.gold));

    } else if (cpu_total > player_total) {

        draw_set_color(c_red);
        draw_text(cx, cy, "CPU WINS!");
        draw_set_color(c_white);
        draw_text(cx, cy + 35, "ANTE " + string(global.ante) + "  |  ROUND " + string(global.round));
        draw_set_color(c_yellow);
        draw_text(cx, cy + 65, "GOLD EARNED THIS RUN: " + string(global.gold));

    } else {

        draw_set_color(c_yellow);
        draw_text(cx, cy, "IT'S A TIE!");
        draw_set_color(c_white);
        draw_text(cx, cy + 35, "No gold earned.");
    }

    draw_set_color(c_white);
    draw_text(cx, cy + 110, "PRESS ENTER TO CONTINUE");

    if (keyboard_check_pressed(vk_enter)) {
        if (player_total >= cpu_total) {
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

// left side — turn info
var turn_label = (turn == "cpu") ? "CPU'S TURN" : "YOUR TURN";
draw_text(20, 20, turn_label);

var current_attempt = (turn == "cpu") ? cpu_attempt + 1 : player_attempt + 1;
draw_text(20, 45, "DIVE " + string(min(current_attempt, max_attempts)) + " / " + string(max_attempts));

draw_text(20, 80,  "YOUR TOTAL:  " + string(player_total));
draw_text(20, 100, "CPU TOTAL:   " + string(cpu_total));

if (player_last != 0) draw_text(20, 130, "LAST DIVE:  " + string(player_last));

// right side — run info and gold
draw_set_halign(fa_right);
draw_set_color(c_black);
draw_text(sw - 20, 20, "ANTE " + string(global.ante) + "  |  ROUND " + string(global.round));
draw_set_color(c_yellow);
draw_text(sw - 20, 45, "GOLD: " + string(global.gold));
// ============================================================
//  DEBUG
// ============================================================
if (cpu_debug) {
    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    draw_text(20, 200, "DEBUG ON — CPU PERFECT DIVE");
    draw_text(20, 220, "CPU TOTAL:    " + string(cpu_total));
    draw_text(20, 240, "PLAYER TOTAL: " + string(player_total));
}