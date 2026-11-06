import 'package:carteira_core/carteira_core.dart';
import 'package:test/test.dart';

void main() {
  group('InMemoryDashboardRepository', () {
    late InMemoryDashboardRepository repository;

    setUp(() {
      repository = InMemoryDashboardRepository(delay: Duration.zero);
    });

    test('getDashboard computes analytics for given month', () async {
      final res = await repository.getDashboard('2026-09');

      expect(res.isOk, isTrue);
      final dashboard = res.valueOrNull!;
      expect(dashboard.month, '2026-09');
      expect(dashboard.income, greaterThan(0));
      expect(dashboard.byCategory, isNotEmpty);
      expect(dashboard.topExpenses, isNotEmpty);
    });
  });
}
