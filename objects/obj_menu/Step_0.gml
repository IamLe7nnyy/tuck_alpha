time_scale = 1;

// initialise globals on first launch only
if (!variable_global_exists("ante")) {
    global.ante            = 1;
    global.round           = 1;
    global.run_active      = true;
    global.gold            = 0;
    global.run_ante        = 1;
    global.run_round       = 1;
    global.run_gold_earned = 0;
	
	if (!variable_global_exists("has_cheesecutter")) {
    global.has_cheesecutter = false;
}
if (!variable_global_exists("cheesecutter_cooldown")) {
    global.cheesecutter_cooldown = 0;
}
}

if (!variable_global_exists("item_bottle")) {
    global.item_bottle = 0;
}

if (!variable_global_exists("bottle_equipped")) {
    global.bottle_equipped = false;
}

// start new run on enter
if (keyboard_check_pressed(vk_enter)) {
    global.ante            = 1;
    global.round           = 1;
    global.run_active      = true;
    global.item_bottle     = 0;
    global.bottle_equipped = false;
	global.has_cheesecutter      = false;
global.cheesecutter_cooldown = 0;
    room_goto(Room_Game);
}