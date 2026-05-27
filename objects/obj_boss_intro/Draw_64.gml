draw_set_font(-1);

var cx = display_get_gui_width()  / 2;
var cy = display_get_gui_height() / 2;
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// background
draw_set_color(c_black);
draw_set_alpha(alpha);
draw_rectangle(0, 0, sw, sh, false);
draw_set_alpha(1);

// warning
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_red);
draw_set_alpha(alpha);
draw_text(cx, cy - 120, "- BOSS -");

// boss name
draw_set_color(c_white);
draw_text(cx, cy - 60, boss_name);

// divider
draw_set_color(c_red);
draw_line(cx - 150, cy - 20, cx + 150, cy - 20);

// ability label
draw_set_color(c_white);
draw_text(cx, cy + 20, "SPECIAL ABILITY");

// ability name
draw_set_color(c_yellow);
draw_text(cx, cy + 60, boss_ability);

// description
draw_set_color(c_white);
draw_text(cx, cy + 95, "2x SCORE MULTIPLIER — ONCE PER ROUND");

// timer bar
var bar_w        = 300;
var bar_h        = 8;
var bar_x        = cx - bar_w / 2;
var bar_y        = sh - 40;
var bar_progress = intro_timer / 240;

draw_set_color(c_gray);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

draw_set_color(c_red);
draw_rectangle(bar_x, bar_y, bar_x + (bar_w * bar_progress), bar_y + bar_h, false);

// skip prompt
draw_set_color(c_white);
draw_set_alpha(alpha * 0.6);
draw_text(cx, sh - 60, "PRESS ENTER TO SKIP");

draw_set_alpha(1);