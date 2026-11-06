import 'package:carteira_core/carteira_core.dart';
import 'package:test/test.dart';

void main() {
  group('InMemoryAiRepository', () {
    late InMemoryAiRepository repository;

    setUp(() {
      repository = InMemoryAiRepository(delay: Duration.zero);
    });

    test('generateInsights returns AI recommendations and score', () async {
      final res = await repository.generateInsights('2026-09');

      expect(res.isOk, isTrue);
      final insight = res.valueOrNull!;
      expect(insight.month, '2026-09');
      expect(insight.recommendations, isNotEmpty);
      expect(insight.score, greaterThan(0));
    });
  });
}
