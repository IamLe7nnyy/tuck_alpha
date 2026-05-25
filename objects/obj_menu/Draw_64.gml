draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(-1);

var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

draw_text(cx, cy - 40, "TUCK");
draw_text(cx, cy + 20, "PRESS ENTER TO PLAY");