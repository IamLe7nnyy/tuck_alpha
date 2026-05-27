// safety — initialise globals if they don't exist yet
if (!variable_global_exists("ante")) {
    global.ante = 1;
}
if (!variable_global_exists("round")) {
    global.round = 1;
}
if (!variable_global_exists("gold")) {
    global.gold = 0;
}

// run tracker — safe to read globals now
global.run_ante        = global.ante;
global.run_round       = global.round;
global.run_round_cleared = global.round;
global.run_gold_earned = global.gold;


// advance the run
if (global.round < 3) {
    global.round++;
    room_goto(Room_Shop);
} else {
    global.ante++;
    global.round = 1;
    room_goto(Room_Shop);
}