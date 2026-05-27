draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);

var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

// title
draw_set_color(c_black);
draw_text(cx, cy - 80, "TUCK");
draw_text(cx, cy + 20, "PRESS ENTER TO PLAY");

// last run card — only after a real loss
if (variable_global_exists("run_active") && !global.run_active) {

    // card dimensions
    var card_w = 300;
    var card_h = 100;
    var card_x = cx - card_w / 2;
    var card_y = cy + 60;

    // card background
    draw_set_color(c_white);
    draw_set_alpha(0.9);
    draw_rectangle(card_x, card_y, card_x + card_w, card_y + card_h, false);

    // card border
    draw_set_color(c_red);
    draw_set_alpha(1);
    draw_rectangle(card_x, card_y, card_x + card_w, card_y + card_h, true);

    // card title
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_text(cx, card_y + 18, "LAST RUN");

    // divider line
    draw_set_color(c_red);
    draw_line(card_x + 10, card_y + 32, card_x + card_w - 10, card_y + 32);

    // run info
    draw_set_color(c_black);
    draw_text(cx, card_y + 50, "ANTE " + string(global.run_ante)
              + "  |  ROUND " + string(global.run_round));

    // gold earned
    draw_set_color(c_yellow);
    draw_text(cx, card_y + 75, "GOLD EARNED: " + string(global.run_gold_earned));

    draw_set_alpha(1);
}