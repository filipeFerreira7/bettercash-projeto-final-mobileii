extension DateTimeX on DateTime {
  String get monthKey => '${year}-${month.toString().padLeft(2, '0')}';

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool get isToday => isSameDay(DateTime.now());
}
