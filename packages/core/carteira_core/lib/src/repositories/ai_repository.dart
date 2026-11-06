import '../models/ai_insight.dart';
import '../result/result.dart';

abstract interface class AiRepository {
  Future<Result<AiInsight>> generateInsights(String month);
  Future<Result<AiInsight>> getInsightById(String id);
}
