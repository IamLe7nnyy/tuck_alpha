function scr_get_grade(score) {
    if (score >= 2800) return "S";
    if (score >= 2200) return "A";
    if (score >= 1600) return "B";
    if (score >= 1000) return "C";
    if (score >= 400)  return "D";
    return "F";
}