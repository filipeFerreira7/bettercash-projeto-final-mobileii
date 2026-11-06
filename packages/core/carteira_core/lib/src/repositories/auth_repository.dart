import '../models/session.dart';
import '../result/result.dart';

abstract interface class AuthRepository {
  Session? get currentSession;

  Future<Result<Session>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> logout();

  Future<Result<Session?>> restore();
}
