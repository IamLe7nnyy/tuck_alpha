if (!variable_global_exists("ante")) {
    global.ante = 1;
}
if (!variable_global_exists("round")) {
    global.round = 1;
}

global.ante       = 1;
global.round      = 1;
global.run_active = true;

room_goto(Room_Menu);