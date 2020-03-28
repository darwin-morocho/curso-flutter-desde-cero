class Extras {
  static monthToText(int month) {
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
    final mins = DateTime.now().difference(date).inMinutes;

    if (mins < 60) {
      return "Hace $mins min.";
    } else if (mins >= 60 && mins <= 60 * 23) {
      // if it is below 4 weeks
      return "Hace ${(mins / 60).ceil()} h";
    } else if (mins > 60 * 23 && mins <= 60 * 24 * 4) {
      // if it is below 4 weeks
      return "Hace ${(mins / (60 * 24)).ceil()} d";
    } else {
      final day = date.day < 10 ? "0${date.day}" : "${date.day}";
      // final hour = date.hour < 10 ? "0${date.hour}" : "${date.hour}";
      // final minutes = date.minute < 10 ? "0${date.minute}" : "${date.minute}";
      return "$day / ${Extras.monthToText(date.month)} / ${date.year}";
    }
  }
}
