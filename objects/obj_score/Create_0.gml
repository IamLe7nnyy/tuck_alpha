player_score = 0;
player_last = 0;

cpu_score = 0;
cpu_last = 0;

turn = "cpu"; // CPU starts first

turn = "cpu";

// spawn CPU at start
instance_create_layer(100, 50, "Instances", obj_cpu);