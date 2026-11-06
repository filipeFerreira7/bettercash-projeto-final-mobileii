import '../models/dashboard.dart';
import '../models/summary.dart';
import '../result/result.dart';

abstract interface class DashboardRepository {
  Future<Result<Summary>> getSummary(String month);
  Future<Result<Dashboard>> getDashboard(String month);
  Future<Result<List<int>>> exportDashboard({
    required String month,
    required String format, // 'pdf' or 'png'
  });
}
