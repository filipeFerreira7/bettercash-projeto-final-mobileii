import 'dart:async';

import '../../api/api_client.dart';
import '../../models/json.dart';
import '../../models/page.dart';
import '../../models/summary.dart';
import '../../models/transaction.dart';
import '../../models/transaction_filter.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../transaction_repository.dart';

class RemoteTransactionRepository implements TransactionRepository {
  RemoteTransactionRepository({required ApiClient client}) : _client = client;

  final ApiClient _client;
  final _changes = StreamController<List<Transaction>>.broadcast();

  @override
  Future<Result<Page<Transaction>>> list(TransactionFilter filter) async {
    final res = await _client.get(
      '/transactions',
      query: filter.toQueryParameters(),
    );

    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid page response'));
      final json = Map<String, Object?>.from(data);
      return Ok(Page.fromJson(json, Transaction.fromJson));
    });
  }

  @override
  Future<Result<Transaction>> getById(String id) async {
    final res = await _client.get('/transactions/$id');
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid transaction response'));
      return Ok(Transaction.fromJson(Map<String, Object?>.from(data)));
    });
  }

  @override
  Future<Result<Transaction>> create(Transaction transaction) async {
    final res = await _client.post('/transactions', body: transaction.toJson());
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid create response'));
      final created = Transaction.fromJson(Map<String, Object?>.from(data));
      _emitUpdate();
      return Ok(created);
    });
  }

  @override
  Future<Result<Transaction>> update(Transaction transaction) async {
    final res = await _client.put(
      '/transactions/${transaction.id}',
      body: transaction.toJson(),
    );
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid update response'));
      final updated = Transaction.fromJson(Map<String, Object?>.from(data));
      _emitUpdate();
      return Ok(updated);
    });
  }

  @override
  Future<Result<void>> delete(String id) async {
    final res = await _client.delete('/transactions/$id');
    _emitUpdate();
    return res.map((_) => null);
  }

  @override
  Future<Result<Summary>> summary(String month) async {
    final res = await _client.get('/summary', query: {'month': month});
    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Invalid summary response'));
      return Ok(Summary.fromJson(Map<String, Object?>.from(data)));
    });
  }

  @override
  Future<Result<int>> importCsv(String csvContent) async {
    final res = await _client.post(
      '/transactions/import',
      body: {'csv': csvContent},
    );
    return res.flatMap((data) {
      if (data is Map && data['imported'] is int) {
        _emitUpdate();
        return Ok(data['imported'] as int);
      }
      return const Ok(0);
    });
  }

  @override
  Stream<List<Transaction>> watch() => _changes.stream;

  void _emitUpdate() {
    list(const TransactionFilter()).then((res) {
      if (res.isOk && !_changes.isClosed) {
        _changes.add(res.valueOrNull!.items);
      }
    });
  }
}
