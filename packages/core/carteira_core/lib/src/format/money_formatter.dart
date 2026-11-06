import 'package:intl/intl.dart';

abstract final class MoneyFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  static String format(double amount) => _formatter.format(amount);

  static String formatSigned(double amount) {
    if (amount > 0) return '+ ${_formatter.format(amount)}';
    if (amount < 0) return '− ${_formatter.format(amount.abs())}';
    return _formatter.format(0);
  }
}
