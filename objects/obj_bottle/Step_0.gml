// fly upward
vspeed += 0.15;  // gravity — lighter than splash so it goes higher
y += vspeed;
image_angle = -90; // point upward

// track peak
if (y < peak_y) {
    peak_y = y;
}

// once it starts falling back down — score and destroy
if (vspeed > 2 && !has_peaked) {
    has_peaked = true;

    // apply 1.5x multiplier to player score
    if (instance_exists(obj_player)) {
        obj_player.current_score = round(obj_player.current_score * 1.5);
    }

    // hand camera back
    obj_turn_system.camera_follow = false;
    obj_turn_system.camera_target = noone;

    var cam = view_camera[0];
    camera_set_view_pos(cam, 0, 738);

    // trigger respawn
    if (instance_exists(obj_player)) {
        obj_player.respawn_timer = 20;
        obj_player.dive_complete = true;
    }
}

// destroy when offscreen
if (y > room_height) {
    instance_destroy();
}