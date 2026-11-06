import 'dart:typed_data';

import '../../models/dashboard.dart';
import '../../models/summary.dart';
import '../../models/transaction.dart';
import '../../result/result.dart';
import '../dashboard_repository.dart';
import 'in_memory_transaction_repository.dart';

/// In-memory Mock Dashboard Repository computing analytics and reports.
class InMemoryDashboardRepository implements DashboardRepository {
  InMemoryDashboardRepository({
    InMemoryTransactionRepository? transactionRepository,
    this.delay = const Duration(milliseconds: 300),
  }) : _txRepo = transactionRepository ?? InMemoryTransactionRepository();

  final InMemoryTransactionRepository _txRepo;
  final Duration delay;

  @override
  Future<Result<Summary>> getSummary(String month) => _txRepo.summary(month);

  @override
  Future<Result<Dashboard>> getDashboard(String month) async {
    await Future<void>.delayed(delay);

    final txs = _txRepo.items.where((t) => _toMonthKey(t.date) == month).toList();

    var income = 0.0;
    var expense = 0.0;
    final catTotals = <String, double>{};
    final dailyTotals = <String, double>{};

    for (final t in txs) {
      final dateKey = '${t.date.year}-${t.date.month.toString().padLeft(2, '0')}-${t.date.day.toString().padLeft(2, '0')}';

      switch (t) {
        case Income():
          income += t.amount;
          dailyTotals[dateKey] = (dailyTotals[dateKey] ?? 0.0) + t.amount;
        case Expense():
          expense += t.amount;
          dailyTotals[dateKey] = (dailyTotals[dateKey] ?? 0.0) - t.amount;
          final cat = t.category ?? 'Outros';
          catTotals[cat] = (catTotals[cat] ?? 0.0) + t.amount;
        case Transfer():
          break;
      }
    }

    final balance = income - expense;

    // Calculate category shares
    final byCategory = catTotals.entries.map((entry) {
      final catAmount = entry.value;
      final percent = expense > 0 ? (catAmount / expense) * 100 : 0.0;
      return CategoryShare(
        category: entry.key,
        amount: catAmount,
        percent: double.parse(percent.toStringAsFixed(1)),
      );
    }).toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));

    // Calculate daily balance curve
    final dailyBalance = dailyTotals.entries.map((entry) {
      return DailyBalance(
        date: entry.key,
        balance: entry.value,
      );
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    // Top expenses
    final topExpenses = txs
        .whereType<Expense>()
        .toList()
      ..sort((a, b) => b.amount.compareTo(a.amount));

    return Ok(
      Dashboard(
        month: month,
        income: income,
        expense: expense,
        balance: balance,
        byCategory: byCategory,
        dailyBalance: dailyBalance,
        topExpenses: topExpenses.take(5).toList(),
      ),
    );
  }

  @override
  Future<Result<List<int>>> exportDashboard({
    required String month,
    required String format,
  }) async {
    await Future<void>.delayed(delay);
    // Simulates PDF or PNG byte array generation
    final dummyBytes = Uint8List.fromList([0x25, 0x50, 0x44, 0x46, 0x2D, 0x31, 0x2E, 0x35]);
    return Ok(dummyBytes);
  }

  static String _toMonthKey(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}';
}
