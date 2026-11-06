import '../models/session.dart';

abstract interface class SessionStorage {
  Future<Session?> read();
  Future<void> write(Session session);
  Future<void> clear();
}
