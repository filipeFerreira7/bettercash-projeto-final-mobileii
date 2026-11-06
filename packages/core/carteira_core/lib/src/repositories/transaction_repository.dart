import '../models/page.dart';
import '../models/summary.dart';
import '../models/transaction.dart';
import '../models/transaction_filter.dart';
import '../result/result.dart';

abstract interface class TransactionRepository {
  Future<Result<Page<Transaction>>> list(TransactionFilter filter);
  Future<Result<Transaction>> getById(String id);
  Future<Result<Transaction>> create(Transaction transaction);
  Future<Result<Transaction>> update(Transaction transaction);
  Future<Result<void>> delete(String id);
  Future<Result<Summary>> summary(String month);
  Future<Result<int>> importCsv(String csvContent);
  Stream<List<Transaction>> watch();
}
