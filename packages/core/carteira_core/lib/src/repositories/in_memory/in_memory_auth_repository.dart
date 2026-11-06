import '../../models/session.dart';
import '../../models/user.dart';
import '../../result/app_error.dart';
import '../../result/result.dart';
import '../../storage/in_memory_session_storage.dart';
import '../../storage/session_storage.dart';
import '../auth_repository.dart';
import 'sample_data.dart';

/// In-memory Mock Auth Repository that simulates authenticated sessions.
class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository({
    List<User>? users,
    SessionStorage? storage,
    this.delay = const Duration(milliseconds: 300),
  })  : _users = users ?? [SampleData.userAna, SampleData.userBruno],
        _storage = storage ?? InMemorySessionStorage();

  final List<User> _users;
  final SessionStorage _storage;
  final Duration delay;

  Session? _session;

  @override
  Session? get currentSession => _session;

  @override
  Future<Result<Session>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(delay);

    final cleanEmail = email.trim().toLowerCase();
    final user = _users.firstWhere(
      (u) => u.email.toLowerCase() == cleanEmail,
      orElse: () => User(
        id: '',
        name: '',
        email: '',
        createdAt: DateTime.now(),
      ),
    );

    if (user.id.isEmpty || password != SampleData.defaultPassword) {
      return const Failure(UnauthorizedError(invalidCredentials: true));
    }

    final session = Session(
      token: 'tok_${DateTime.now().millisecondsSinceEpoch}',
      user: user,
    );
    _session = session;
    await _storage.write(session);
    return Ok(session);
  }

  @override
  Future<Result<void>> logout() async {
    await Future<void>.delayed(delay);
    _session = null;
    await _storage.clear();
    return const Ok(null);
  }

  @override
  Future<Result<Session?>> restore() async {
    await Future<void>.delayed(delay);
    _session = await _storage.read();
    return Ok(_session);
  }
}
