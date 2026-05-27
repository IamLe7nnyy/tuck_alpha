// fade in
if (alpha < 1) {
    alpha += 0.05;
}

// count down
intro_timer--;

// auto advance
if (intro_timer <= 0) {
    room_goto(Room_Game);
}

// skip
if (keyboard_check_pressed(vk_enter)) {
    room_goto(Room_Game);
}