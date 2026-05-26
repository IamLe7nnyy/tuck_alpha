draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);

var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

// background
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// title
draw_set_color(c_red);
draw_text(cx, cy - 80, "WIPED OUT!");

// how far they got
draw_set_color(c_white);
draw_text(cx, cy - 30, "ANTE " + string(global.ante) + "  |  ROUND " + string(global.round));

// prompt
draw_set_color(c_white);
draw_text(cx, cy + 40, "PRESS ENTER TO RETURN TO MENU");

// on enter — reset everything and go back to menu
if (keyboard_check_pressed(vk_enter)) {
    global.ante       = 1;
    global.round      = 1;
    global.run_active = true;
    room_goto(Room_Menu);
}