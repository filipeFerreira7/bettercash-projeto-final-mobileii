import '../../api/api_client.dart';
import '../../models/dashboard.dart';
import '../../models/json.dart';
import '../../models/summary.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../dashboard_repository.dart';

class RemoteDashboardRepository implements DashboardRepository {
  RemoteDashboardRepository({required ApiClient client}) : _client = client;

  final ApiClient _client;

  @override
  Future<Result<Summary>> getSummary(String month) async {
    final res = await _client.get('/summary', query: {'month': month});
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid summary response'));
      return Ok(Summary.fromJson(Map<String, Object?>.from(data)));
    });
  }

  @override
  Future<Result<Dashboard>> getDashboard(String month) async {
    final res = await _client.get('/dashboard', query: {'month': month});
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid dashboard response'));
      return Ok(Dashboard.fromJson(Map<String, Object?>.from(data)));
    });
  }

  @override
  Future<Result<List<int>>> exportDashboard({
    required String month,
    required String format,
  }) async {
    final res = await _client.get(
      '/dashboard/export',
      query: {'month': month, 'format': format},
    );
    return res.flatMap((data) {
      if (data is List<int>) return Ok(data);
      return const Ok([]);
    });
  }
}
