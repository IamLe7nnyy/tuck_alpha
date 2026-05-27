draw_set_font(-1);
draw_set_alpha(alpha);

var cx = display_get_gui_width()  / 2;
var cy = display_get_gui_height() / 2;
var sw = display_get_gui_width();
var sh = display_get_gui_height();

// background
draw_set_color(c_black);
draw_set_alpha(alpha * 0.85);
draw_rectangle(0, 0, sw, sh, false);
draw_set_alpha(alpha);

// top label
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_yellow);
draw_text(cx, cy - 180, "ABILITY UNLOCKED!");

// ability name
draw_set_color(c_white);
draw_text(cx, cy - 140, "CHEESECUTTER");

// divider
draw_set_color(c_yellow);
draw_line(cx - 180, cy - 115, cx + 180, cy - 115);

// large sprite — drawn at 3x scale, slow loop
draw_sprite_ext(
    spr_cheesecutter,   // sprite
    anim_frame,         // frame
    cx,                 // x
    cy - 30,            // y
    3,                  // xscale
    3,                  // yscale
    0,                  // angle
    c_white,            // colour
    alpha               // alpha
);

// divider
draw_set_color(c_yellow);
draw_line(cx - 180, cy + 60, cx + 180, cy + 60);

// description
draw_set_color(c_white);
draw_text(cx, cy + 85,  "Perform mid-air for a 2x score multiplier");
draw_text(cx, cy + 110, "Press Z to activate");

// cooldown info
draw_set_color(c_gray);
draw_text(cx, cy + 140, "1 round cooldown after use");

// prompt
draw_set_color(c_white);
draw_set_alpha(alpha * (0.5 + sin(current_time / 300) * 0.5)); // pulse effect
draw_text(cx, cy + 190, "PRESS ENTER TO CONTINUE");

draw_set_alpha(1);