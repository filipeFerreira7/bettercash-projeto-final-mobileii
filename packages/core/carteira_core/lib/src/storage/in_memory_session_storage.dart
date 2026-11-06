import '../models/session.dart';
import 'session_storage.dart';

class InMemorySessionStorage implements SessionStorage {
  InMemorySessionStorage([this._session]);

  Session? _session;

  @override
  Future<Session?> read() async => _session;

  @override
  Future<void> write(Session session) async {
    _session = session;
  }

  @override
  Future<void> clear() async {
    _session = null;
  }
}
