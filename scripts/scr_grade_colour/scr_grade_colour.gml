function scr_grade_colour(grade) {
    switch (grade) {
        case "S": return c_yellow;
        case "A": return make_color_rgb(255, 165, 0);
        case "B": return c_lime;
        case "C": return c_aqua;
        case "D": return c_silver;
        default:  return c_red;
    }
}