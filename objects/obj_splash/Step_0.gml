image_angle=direction

if image_index > 24
{
	instance_destroy()
}

// gravity effect
vspeed += 0.3;

// slow down horizontal movement
hspeed *= 0.98;

// destroy after falling back down
if (y > room_height || vspeed > 10) {
    instance_destroy();
}