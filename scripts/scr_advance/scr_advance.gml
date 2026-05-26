// safety — initialise globals if they don't exist yet
if (!variable_global_exists("ante")) {
    global.ante = 1;
}
if (!variable_global_exists("round")) {
    global.round = 1;
}

// advance the run
if (global.round < 3) {
    global.round++;
    room_goto(Room_Shop);
} else {
    global.ante++;
    global.round = 1;
    room_goto(Room_Shop);
}