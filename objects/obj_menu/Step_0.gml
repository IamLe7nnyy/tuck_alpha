// initialise globals on first launch only
if (!variable_global_exists("ante")) {
    global.ante            = 1;
    global.round           = 1;
    global.run_active      = true;
    global.gold            = 0;
    global.run_ante        = 1;
    global.run_round       = 1;
    global.run_gold_earned = 0;
}

// start new run on enter
if (keyboard_check_pressed(vk_enter)) {
    global.ante       = 1;
    global.round      = 1;
    global.run_active = true;
    room_goto(Room_Game);
}