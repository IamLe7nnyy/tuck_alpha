draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_set_font(-1);

// PLAYER
draw_text(20, 20, "PLAYER SCORE: " + string(player_score));
draw_text(20, 50, "PLAYER LAST: " + string(player_last));

// CPU
draw_text(20, 80, "CPU SCORE: " + string(cpu_score));
draw_text(20, 110, "CPU LAST: " + string(cpu_last));

