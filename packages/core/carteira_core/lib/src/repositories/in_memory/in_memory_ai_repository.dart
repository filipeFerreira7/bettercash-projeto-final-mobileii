import '../../models/ai_insight.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../ai_repository.dart';
import 'sample_data.dart';

/// In-memory Mock AI Repository simulating deterministic AI financial insights generation.
class InMemoryAiRepository implements AiRepository {
  InMemoryAiRepository({
    Map<String, AiInsight>? initialInsights,
    this.delay = const Duration(milliseconds: 400),
  }) : _insights = {...initialInsights ?? SampleData.sampleInsights()};

  final Map<String, AiInsight> _insights;
  final Duration delay;

  @override
  Future<Result<AiInsight>> generateInsights(String month) async {
    await Future<void>.delayed(delay);

    final existing = _insights[month];
    if (existing != null) return Ok(existing);

    // Generate dynamic fallback insight if not seeded
    final newInsight = AiInsight(
      id: 'ins_${DateTime.now().millisecondsSinceEpoch}',
      month: month,
      generatedAt: DateTime.now(),
      summary: 'Sua saúde financeira está estável este mês. Suas despesas estão sob controle.',
      recommendations: const [
        AiRecommendation(
          title: 'Mantenha sua reserva',
          description: 'Direcionar R\$ 200 adicionais para investimento pode aumentar seu rendimento em 12% ao ano.',
          potentialSaving: 200.00,
          priority: AiPriority.medium,
        ),
      ],
      score: 80,
    );

    _insights[month] = newInsight;
    return Ok(newInsight);
  }

  @override
  Future<Result<AiInsight>> getInsightById(String id) async {
    await Future<void>.delayed(delay);

    for (final insight in _insights.values) {
      if (insight.id == id) return Ok(insight);
    }
    return Failure(NotFoundError(id));
  }
}
