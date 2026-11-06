import 'package:carteira_core/carteira_core.dart';
import 'package:test/test.dart';

void main() {
  group('Transaction Model', () {
    test('parses income, expense and transfer correctly', () {
      final incomeJson = {
        'id': 'tx_01',
        'type': 'income',
        'amount': 8500.0,
        'description': 'Salário',
        'category': 'Salário',
        'date': '2026-09-05T09:00:00Z',
        'account': 'Itaú',
      };

      final tx = Transaction.fromJson(incomeJson);
      expect(tx, isA<Income>());
      expect(tx.amount, 8500.0);
      expect(tx.type, TransactionType.income);
    });
  });
}
