class Period {
  final String date;
  final String timeFrom;
  final String timeTo;

  Period({required this.timeTo, required this.timeFrom, required this.date});

  static Period fromMap(Map<String, dynamic> map) {
    return Period(
        timeFrom: map['time_from'], date: map['date'], timeTo: map['time_to']);
  }
}
