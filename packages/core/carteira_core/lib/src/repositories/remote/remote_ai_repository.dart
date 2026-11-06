import '../../api/api_client.dart';
import '../../models/ai_insight.dart';
import '../../models/json.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../ai_repository.dart';

class RemoteAiRepository implements AiRepository {
  RemoteAiRepository({required ApiClient client}) : _client = client;

  final ApiClient _client;

  @override
  Future<Result<AiInsight>> generateInsights(String month) async {
    final res = await _client.post(
      '/ai/insights',
      body: {'month': month},
    );
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid AI insights response'));
      return Ok(AiInsight.fromJson(Map<String, Object?>.from(data)));
    });
  }

  @override
  Future<Result<AiInsight>> getInsightById(String id) async {
    final res = await _client.get('/ai/insights/$id');
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid AI insight response'));
      return Ok(AiInsight.fromJson(Map<String, Object?>.from(data)));
    });
  }
}
