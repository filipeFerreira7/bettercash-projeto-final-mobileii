import 'package:carteira_core/carteira_core.dart';
import 'package:test/test.dart';

void main() {
  group('InMemoryTransactionRepository', () {
    late InMemoryTransactionRepository repository;

    setUp(() {
      repository = InMemoryTransactionRepository(delay: Duration.zero);
    });

    test('list filters by month and pagination', () async {
      final res = await repository.list(
        const TransactionFilter(month: '2026-09', page: 1, pageSize: 20),
      );

      expect(res.isOk, isTrue);
      final page = res.valueOrNull!;
      expect(page.items, isNotEmpty);
      expect(page.items.every((t) => t.date.year == 2026 && t.date.month == 9), isTrue);
    });

    test('create adds transaction to list', () async {
      final newTx = Expense(
        id: '',
        amount: 89.90,
        description: 'Mercado Teste',
        date: DateTime.now(),
        account: 'Nubank',
        category: 'Alimentação',
      );

      final res = await repository.create(newTx);
      expect(res.isOk, isTrue);
      expect(res.valueOrNull?.id, startsWith('tx_'));

      final listRes = await repository.list(const TransactionFilter(query: 'Mercado Teste'));
      expect(listRes.valueOrNull?.total, 1);
    });

    test('delete removes transaction', () async {
      final tx = repository.items.first;
      final res = await repository.delete(tx.id);
      expect(res.isOk, isTrue);

      final getRes = await repository.getById(tx.id);
      expect(getRes.isFailure, isTrue);
    });

    test('summary calculates month totals', () async {
      final res = await repository.summary('2026-09');
      expect(res.isOk, isTrue);
      final summary = res.valueOrNull!;
      expect(summary.income, greaterThan(0));
      expect(summary.expense, greaterThan(0));
    });
  });
}
