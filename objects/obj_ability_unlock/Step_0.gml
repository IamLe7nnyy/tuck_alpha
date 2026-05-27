// fade in
if (alpha < 1) {
    alpha += 0.03;
}

// slow animation loop
anim_timer++;
if (anim_timer >= anim_speed) {
    anim_timer = 0;
    anim_frame++;
    if (anim_frame >= anim_frames) {
        anim_frame = 0;
    }
}

// continue on enter
if (keyboard_check_pressed(vk_enter)) {
    room_goto(Room_Shop);
}