draw_self();

// --- DEBUG: DRAW TUCK ZONES ---
if (show_zones) {

    var water = instance_nearest(x, y, obj_water);

    if (water != noone) {

        var total_height = 100;
        var zone_height = total_height / 2;

        var zone_offset = 120; // how much higher the zones sit
		var top_zone = water.bbox_top - total_height - zone_offset;

        // colors for each zone
        var col_ok      = c_orange;
        var col_good    = c_yellow;
        var col_perfect = c_lime;
        var col_bad     = c_red;

        draw_set_alpha(0.3);

        // OK (top)
        draw_set_color(col_ok);
        draw_rectangle(0, top_zone, room_width, top_zone + zone_height, false);

        // GOOD
        draw_set_color(col_good);
        draw_rectangle(0, top_zone + zone_height, room_width, top_zone + zone_height * 2, false);

        // PERFECT
        draw_set_color(col_perfect);
        draw_rectangle(0, top_zone + zone_height * 2, room_width, top_zone + zone_height * 3, false);

        // GOOD
        draw_set_color(col_good);
        draw_rectangle(0, top_zone + zone_height * 3, room_width, top_zone + zone_height * 4, false);

        // OK (bottom)
        draw_set_color(col_ok);
        draw_rectangle(0, top_zone + zone_height * 4, room_width, top_zone + zone_height * 5, false);
    }
}