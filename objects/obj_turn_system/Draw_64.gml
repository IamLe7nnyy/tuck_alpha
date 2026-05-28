draw_set_font(-1);
draw_set_alpha(1);

var cx = display_get_gui_width()  / 2;
var cy = display_get_gui_height() / 2;
var sw = display_get_gui_width();
var sh = display_get_gui_height();

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

        draw_set_color(c_lime);
        draw_text(cx, cy, round_cleared_label);
        draw_text(cx, cy + 35, "YOU WIN!");

        draw_set_color(c_yellow);
        var earned = scr_get_gold(player_grade);
        draw_text(cx, cy + 65, "+" + string(earned) + " GOLD  |  TOTAL: " + string(global.gold));

    } else if (cpu_total > player_total) {

        draw_set_color(c_red);
        draw_text(cx, cy, "CPU WINS!");
        draw_set_color(c_white);
        draw_text(cx, cy + 35, "LOCATION " + string(global.ante) + "  |  ROUND " + string(global.round));
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

    exit;  // ← only one exit, only inside results block
}

// ============================================================
//  IN-GAME HUD — LEFT SIDE
// ============================================================
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);

var turn_label = (turn == "cpu") ? "CPU'S TURN" : "YOUR TURN";
draw_text(20, 20, turn_label);

var current_attempt = (turn == "cpu") ? cpu_attempt + 1 : player_attempt + 1;
draw_text(20, 45, "DIVE " + string(min(current_attempt, max_attempts)) + " / " + string(max_attempts));

draw_text(20, 80,  "YOUR TOTAL:  " + string(player_total));
draw_text(20, 100, "CPU TOTAL:   " + string(cpu_total));

if (player_last != 0) draw_text(20, 130, "LAST DIVE: " + string(player_last));

// boss demo overlay
if (turn == "boss_demo" && demo_phase == "diving") {

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(-1);

    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, sw, 60, false);
    draw_set_alpha(1);

    draw_set_color(c_red);
    draw_text(cx, 20, "- BOSS SHOWCASE -");

    draw_set_color(c_white);
    draw_text(cx, 45, "WATCH CLOSELY...");
}

if (turn == "boss_demo" && demo_phase == "pause") {

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(-1);

    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, sw, 60, false);
    draw_set_alpha(1);

    draw_set_color(c_yellow);
    draw_text(cx, 20, "CHEESECUTTER");

    draw_set_color(c_white);
    draw_text(cx, 45, "GET READY...");
}

// ============================================================
//  IN-GAME HUD — RIGHT SIDE
// ============================================================
draw_set_halign(fa_right);

draw_set_color(c_black);
draw_text(sw - 20, 20, "LOCATION " + string(global.ante) + "  |  ROUND " + string(global.round));

draw_set_color(c_purple);
draw_text(sw - 20, 45, "GOLD: " + string(global.gold));

// cheesecutter ability HUD
if (global.has_cheesecutter) {

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var ab_x = 20;
    var ab_y = 170;

    if (global.cheesecutter_cooldown == 0) {
        draw_set_color(c_lime);
    } else {
        draw_set_color(c_gray);
    }

    draw_rectangle(ab_x, ab_y, ab_x + 50, ab_y + 50, false);
    draw_set_color(c_black);
    draw_rectangle(ab_x, ab_y, ab_x + 50, ab_y + 50, true);

    draw_sprite(spr_cheesecutter, 0, ab_x + 25, ab_y + 25);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    if (global.cheesecutter_cooldown == 0) {
        draw_set_color(c_lime);
        draw_text(ab_x + 55, ab_y + 10, "CHEESECUTTER");
        draw_text(ab_x + 55, ab_y + 28, "PRESS Z");
    } else {
        draw_set_color(c_gray);
        draw_text(ab_x + 55, ab_y + 10, "CHEESECUTTER");
        draw_text(ab_x + 55, ab_y + 28, "COOLDOWN: " + string(global.cheesecutter_cooldown) + " rounds");
    }
}

// ============================================================
//  BOTTLE ITEM HUD — player turn only
// ============================================================
if (turn == "player" && global.item_bottle > 0) {

    draw_set_halign(fa_right);
    draw_set_valign(fa_top);

    draw_sprite(spr_bottle, 0, sw - 60, 120);
    draw_set_color(c_white);
    draw_text(sw - 20, 180, "x" + string(global.item_bottle));

    var btn_x = sw - 120;
    var btn_y = 150;
    var btn_w = 100;
    var btn_h = 25;

    var btn_hover = (mouse_x > btn_x && mouse_x < btn_x + btn_w
                 &&  mouse_y > btn_y && mouse_y < btn_y + btn_h);

    if (global.bottle_equipped) {
        draw_set_color(c_lime);
    } else if (btn_hover) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(make_color_rgb(100, 180, 255));
    }

    draw_set_alpha(1);
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);
    draw_set_color(c_black);
    draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);

    if (global.bottle_equipped) {
        draw_text(btn_x + btn_w / 2, btn_y + btn_h / 2, "EQUIPPED");
    } else {
        draw_text(btn_x + btn_w / 2, btn_y + btn_h / 2, "UNEQUIPPED");
    }

    if ((mouse_check_button_pressed(mb_left) && btn_hover)
    ||   keyboard_check_pressed(ord("E"))) {
        global.bottle_equipped = !global.bottle_equipped;
    }
}

// ============================================================
//  DEBUG
// ============================================================
if (cpu_debug) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_yellow);
    draw_text(20, 200, "DEBUG ON — CPU PERFECT DIVE");
    draw_text(20, 220, "CPU TOTAL:    " + string(cpu_total));
    draw_text(20, 240, "PLAYER TOTAL: " + string(player_total));
}