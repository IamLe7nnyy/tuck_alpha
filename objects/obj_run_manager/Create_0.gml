// Only initialise if this is a fresh run
// (persistent means this runs once for the whole game)

room_goto(Room_Menu);

global.ante  = 1;   // which set of 3 opponents (ante 1, ante 2, etc.)
global.round = 1;   // 1 = first opponent, 2 = second, 3 = boss

global.run_active = true;