draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);

var cx = display_get_gui_width()  / 2;
var cy = display_get_gui_height() / 2;
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// ============================================================
//  TITLE
// ============================================================
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_text(cx, 30, "S H O P");

// divider under title
draw_set_color(c_black);
draw_line(20, 55, sw - 20, 55);

// ============================================================
//  LEFT SIDE — GAME INFO
// ============================================================
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_text(20, 80,  "ANTE:  " + string(global.ante));
draw_text(20, 110, "ROUND: " + string(global.round));

draw_set_color(c_purple);
draw_text(20, 160, "GOLD: " + string(global.gold));

// ============================================================
//  RIGHT SIDE — SHOP ITEMS
// ============================================================
var item_x = sw - 220;
var item_y = 80;
var item_w = 200;
var item_h = 130;

// item card background
draw_set_color(c_white);
draw_set_alpha(0.9);
draw_rectangle(item_x, item_y, item_x + item_w, item_y + item_h, false);

// item card border — green if affordable, red if not
if (global.gold >= 600 && global.item_bottle == 0) {
    draw_set_color(c_lime);
} else {
    draw_set_color(c_red);
}
draw_set_alpha(1);
draw_rectangle(item_x, item_y, item_x + item_w, item_y + item_h, true);

// item sprite
draw_sprite(spr_bottle, 0, item_x + item_w / 2, item_y + 40);

// item name
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_text(item_x + item_w / 2, item_y + 75, "WATER BOTTLE");

// item cost
draw_set_color(c_black);
draw_text(item_x + item_w / 2, item_y + 95, "600 GOLD");

// owned
draw_set_color(c_black);
draw_text(item_x + item_w / 2, item_y + 113, "OWNED: " + string(global.item_bottle));

// ============================================================
//  BUY BUTTON
// ============================================================
var btn_x = item_x + item_w / 2 - 50;
var btn_y = item_y + item_h + 10;
var btn_w = 100;
var btn_h = 30;

// check if mouse is hovering over button
var mouse_hover = (mouse_x > btn_x && mouse_x < btn_x + btn_w
               &&  mouse_y > btn_y && mouse_y < btn_y + btn_h);

// check if purchase is possible
var can_buy = (global.gold >= 600 && global.item_bottle == 0);

// button colour — grey if cant buy, yellow if hover, green if can buy
if (!can_buy) {
    draw_set_color(c_gray);
} else if (mouse_hover) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_lime);
}

draw_set_alpha(1);
draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, false);

// button border
draw_set_color(c_black);
draw_rectangle(btn_x, btn_y, btn_x + btn_w, btn_y + btn_h, true);

// button text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_text(btn_x + btn_w / 2, btn_y + btn_h / 2, "BUY");

// buy on left click or enter
if (can_buy) {
    if ((mouse_check_button_pressed(mb_left) && mouse_hover)
    ||   keyboard_check_pressed(vk_enter)) {
        global.gold        -= 600;
        global.item_bottle  = 1;
    }
}

// already owned message
if (global.item_bottle > 0) {
    draw_set_color(c_lime);
    draw_text(item_x + item_w / 2, btn_y + btn_h / 2, "OWNED!");
}

// ============================================================
//  BOTTOM — CONTINUE
// ============================================================
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_black);

// continue button
var cont_x = cx - 60;
var cont_y = sh - 50;
var cont_w = 120;
var cont_h = 30;

var cont_hover = (mouse_x > cont_x && mouse_x < cont_x + cont_w
              &&  mouse_y > cont_y && mouse_y < cont_y + cont_h);

if (cont_hover) {
    draw_set_color(c_yellow);
} else {
    draw_set_color(c_white);
}

draw_rectangle(cont_x, cont_y, cont_x + cont_w, cont_y + cont_h, false);
draw_set_color(c_black);
draw_rectangle(cont_x, cont_y, cont_x + cont_w, cont_y + cont_h, true);
draw_text(cx, cont_y + cont_h / 2, "CONTINUE");

if ((mouse_check_button_pressed(mb_left) && cont_hover)
||   keyboard_check_pressed(vk_space)) {
    room_goto(Room_Game);
}