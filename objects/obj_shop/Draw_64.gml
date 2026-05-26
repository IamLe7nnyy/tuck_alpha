draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1);

var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

// show where the player is in the run
var round_label = "";
switch (global.round) {
    case 1: round_label = "OPPONENT 1 CLEARED!"; break;
    case 2: round_label = "OPPONENT 2 CLEARED!"; break;
    case 3: round_label = "BOSS CLEARED!"; break;
}

draw_set_color(c_lime);
draw_text(cx, cy - 100, round_label);

draw_set_color(c_black);
draw_text(cx, cy - 60, "ANTE " + string(global.ante) + "  |  ROUND " + string(global.round));

draw_text(cx, cy, "[ SHOP COMING SOON ]");

draw_text(cx, cy + 80, "PRESS ENTER TO CONTINUE");

if (keyboard_check_pressed(vk_enter)) {
    room_goto(Room_Game);
}