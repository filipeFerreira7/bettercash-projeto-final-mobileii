import '../../api/api_client.dart';
import '../../models/json.dart';
import '../../models/session.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../../storage/in_memory_session_storage.dart';
import '../../storage/session_storage.dart';
import '../auth_repository.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository({
    required ApiClient client,
    SessionStorage? storage,
  })  : _client = client,
        _storage = storage ?? InMemorySessionStorage();

  final ApiClient _client;
  final SessionStorage _storage;
  Session? _session;

  @override
  Session? get currentSession => _session;

  @override
  Future<Result<Session>> login({
    required String email,
    required String password,
  }) async {
    final res = await _client.post(
      '/auth/login',
      body: {'email': email, 'password': password},
    );

    return res.flatMap((data) {
      if (data is! Map) return Failure(const UnknownError('Malformed login response'));
      final session = Session.fromJson(Map<String, Object?>.from(data));
      _session = session;
      _client.token = session.token;
      _storage.write(session);
      return Ok(session);
    });
  }

  @override
  Future<Result<void>> logout() async {
    final res = await _client.post('/auth/logout');
    _session = null;
    _client.token = null;
    await _storage.clear();
    return res.map((_) => null);
  }

  @override
  Future<Result<Session?>> restore() async {
    _session = await _storage.read();
    if (_session != null) {
      _client.token = _session!.token;
    }
    return Ok(_session);
  }
}
