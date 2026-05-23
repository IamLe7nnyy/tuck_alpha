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