function scr_get_gold(grade) {
    switch (grade) {
        case "S": return 500;
        case "A": return 350;
        case "B": return 250;
        case "C": return 150;
        case "D": return 50;
        default:  return 0;
    }
}