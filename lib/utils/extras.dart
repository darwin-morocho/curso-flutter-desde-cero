class Extras {
  static String monthToText(int month) {
    final months = [
      "ENE",
      "FEB",
      "MAR",
      "ABR",
      "MAY",
      "JUN",
      "JUL",
      "AGO",
      "SEP",
      "OCT",
      "NOV",
      "DIC"
    ];

    return months[month - 1];
  }

  static String fromNow(DateTime date) {
    final DateTime currentDate = DateTime.now();

    final int mins = currentDate.difference(date).inMinutes;

    if (mins < 60) {
      return "Hace $mins min.";
    } else if (mins >= 60 && mins <= 60 * 23) {
      return "Hace ${(mins / 60).ceil()} h.";
    } else if (mins > 60 * 23 && mins < 60 * 24 * 4) {
      return "Hace ${(mins / (60 * 24)).ceil()}  d.";
    } else {
      return "${date.day < 10 ? '0' : ''}${date.day}  ${monthToText(date.month)}  ${date.year}";
    }
  }
}
