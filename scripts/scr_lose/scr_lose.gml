// ensure globals exist before reading them
if (!variable_global_exists("run_active")) {
    global.run_active = true;
}
if (!variable_global_exists("ante")) {
    global.ante = 1;
}
if (!variable_global_exists("round")) {
    global.round = 1;
}
if (!variable_global_exists("gold")) {
    global.gold = 0;
}
if (!variable_global_exists("run_ante")) {
    global.run_ante = 1;
}
if (!variable_global_exists("run_round")) {
    global.run_round = 1;
}
if (!variable_global_exists("run_gold_earned")) {
    global.run_gold_earned = 0;
}

show_debug_message("SCR_LOSE FIRED");
show_debug_message("run_active before: " + string(global.run_active));

// save run progress before wiping
global.run_ante        = global.ante;
global.run_round       = global.round;
global.run_gold_earned = global.gold;

// wipe gold and reset run
global.gold       = 0;
global.ante       = 1;
global.round      = 1;
global.run_active = false;

show_debug_message("run_active after: " + string(global.run_active));

room_goto(Room_Menu);