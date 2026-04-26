direction=45+random(90)
speed=4+random(4)
gravity=0.1
image_speed=0.5+random(0.6)

// Scale based on power
var scale = power / 100;

image_xscale = scale;
image_yscale = scale;

trick_multiplier = 1;

if (trick_multiplier > 1) {
    var popup = instance_create_layer(x, y - 100, "Instances", obj_flip_labels);
    popup.text = "CHEESE CUTTER x2";
}