// safety checks
if (!variable_global_exists("ante")) {
    global.ante = 1;
}
if (!variable_global_exists("round")) {
    global.round = 1;
}
if (!variable_global_exists("gold")) {
    global.gold = 0;
}
if (!variable_global_exists("cheesecutter_cooldown")) {
    global.cheesecutter_cooldown = 0;
}
if (!variable_global_exists("has_cheesecutter")) {
    global.has_cheesecutter = false;
}
if (!variable_global_exists("bottle_equipped")) {
    global.bottle_equipped = false;
}

// tick down cheesecutter cooldown each round
if (global.cheesecutter_cooldown > 0) {
    global.cheesecutter_cooldown--;
}

// reset bottle equip between rounds
global.bottle_equipped = false;

// run tracker
global.run_ante        = global.ante;
global.run_round       = global.round;
global.run_gold_earned = global.gold;

// advance the run
if (global.round < 2) {
    global.round++;
    room_goto(Room_Shop);
} else if (global.round == 2) {
    global.round++;
    room_goto(Room_Boss_Intro);  // go to boss intro before shop
} else {
    global.ante++;
    global.round = 1;
    // show ability unlock screen on first boss defeat
    if (global.has_cheesecutter && global.cheesecutter_unlocked_shown 
    &&  global.ante == 2) {
        room_goto(Room_Ability_Unlock);
    } else {
        room_goto(Room_Shop);
    }
}