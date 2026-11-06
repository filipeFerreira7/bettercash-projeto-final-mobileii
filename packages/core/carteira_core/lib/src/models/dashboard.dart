import 'json.dart';
import 'transaction.dart';

/// Category expense share in dashboard.
class CategoryShare {
  const CategoryShare({
    required this.category,
    required this.amount,
    required this.percent,
  });

  factory CategoryShare.fromJson(Json json) {
    return CategoryShare(
      category: json['category'] as String? ?? 'Outros',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      percent: (json['percent'] as num?)?.toDouble() ?? 0.0,
    );
  }

  final String category;
  final double amount;
  final double percent;

  Json toJson() => {
        'category': category,
        'amount': amount,
        'percent': percent,
      };
}

/// Daily balance point for charts.
class DailyBalance {
  const DailyBalance({
    required this.date,
    required this.balance,
  });

  factory DailyBalance.fromJson(Json json) {
    return DailyBalance(
      date: json['date'] as String? ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  final String date; // YYYY-MM-DD
  final double balance;

  Json toJson() => {
        'date': date,
        'balance': balance,
      };
}

/// Dashboard aggregated data for charts and reports.
class Dashboard {
  const Dashboard({
    required this.month,
    required this.income,
    required this.expense,
    required this.balance,
    required this.byCategory,
    required this.dailyBalance,
    required this.topExpenses,
  });

  factory Dashboard.fromJson(Json json) {
    final rawByCat = json['byCategory'] as List<dynamic>? ?? [];
    final rawDaily = json['dailyBalance'] as List<dynamic>? ?? [];
    final rawTop = json['topExpenses'] as List<dynamic>? ?? [];

    return Dashboard(
      month: json['month'] as String? ?? '',
      income: (json['income'] as num?)?.toDouble() ?? 0.0,
      expense: (json['expense'] as num?)?.toDouble() ?? 0.0,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      byCategory: rawByCat
          .whereType<Json>()
          .map(CategoryShare.fromJson)
          .toList(),
      dailyBalance: rawDaily
          .whereType<Json>()
          .map(DailyBalance.fromJson)
          .toList(),
      topExpenses: rawTop
          .whereType<Json>()
          .map(Transaction.fromJson)
          .toList(),
    );
  }

  final String month;
  final double income;
  final double expense;
  final double balance;
  final List<CategoryShare> byCategory;
  final List<DailyBalance> dailyBalance;
  final List<Transaction> topExpenses;

  Json toJson() => {
        'month': month,
        'income': income,
        'expense': expense,
        'balance': balance,
        'byCategory': byCategory.map((c) => c.toJson()).toList(),
        'dailyBalance': dailyBalance.map((d) => d.toJson()).toList(),
        'topExpenses': topExpenses.map((t) => t.toJson()).toList(),
      };
}
