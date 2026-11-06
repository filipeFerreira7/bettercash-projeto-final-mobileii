import 'package:intl/intl.dart';

abstract final class AppDateFormat {
  static final DateFormat fullDate = DateFormat("d 'de' MMMM 'de' yyyy", 'pt_BR');
  static final DateFormat dayAndMonth = DateFormat("d 'de' MMMM", 'pt_BR');
  static final DateFormat monthAndYear = DateFormat("MMMM 'de' yyyy", 'pt_BR');
  static final DateFormat monthAbbrev = DateFormat("MMM", 'pt_BR');
  static final DateFormat weekdayAndDate = DateFormat("EEEE, d 'DE' MMMM", 'pt_BR');

  static String formatFull(DateTime dt) => fullDate.format(dt);
  static String formatDayMonth(DateTime dt) => dayAndMonth.format(dt);
  static String formatMonthYear(DateTime dt) => monthAndYear.format(dt);
  static String formatMonthKey(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}';
}
