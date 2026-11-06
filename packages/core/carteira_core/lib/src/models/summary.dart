import 'json.dart';

/// Monthly summary of income, expense and net balance.
class Summary {
  const Summary({
    required this.month,
    required this.income,
    required this.expense,
  });

  factory Summary.fromJson(Json json) {
    return Summary(
      month: json['month'] as String? ?? '',
      income: (json['income'] as num?)?.toDouble() ?? 0.0,
      expense: (json['expense'] as num?)?.toDouble() ?? 0.0,
    );
  }

  final String month;
  final double income;
  final double expense;

  double get balance => income - expense;

  Json toJson() => {
        'month': month,
        'income': income,
        'expense': expense,
        'balance': balance,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Summary &&
          runtimeType == other.runtimeType &&
          month == other.month &&
          income == other.income &&
          expense == other.expense;

  @override
  int get hashCode => Object.hash(month, income, expense);
}
