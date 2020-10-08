class Utils {
  static int getWeekNumberFromDate(DateTime date) {
    int dayOfTheYear = date.difference(DateTime(date.year, 01, 01)).inDays + 1;
    int weekNumber = ((dayOfTheYear - date.weekday + 10) / 7).floor();
    if (weekNumber < 1) {
      weekNumber = getWeekNumberFromDate(DateTime(date.year - 1, 12, 31));
    }
    return weekNumber;
  }

  static String validateDay(String day) {
    int dayNumber = int.tryParse(day);
    return dayNumber > 0 && dayNumber <= 31 ? null : "Invalid value";
  }

  static String validateMonth(String month) {
    int monthNumber = int.tryParse(month);
    return monthNumber > 1 && monthNumber <= 12 ? null : "Invalid value";
  }

  static String validateYear(String year) {
    if (year.length < 4 || int.tryParse(year) < 1971) {
      return "Invalid value";
    } else {
      return null;
    }
  }
}
