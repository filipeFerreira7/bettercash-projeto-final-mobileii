import 'package:carteira_core/carteira_core.dart';
import 'package:test/test.dart';

void main() {
  group('InMemoryAuthRepository', () {
    late InMemoryAuthRepository repository;

    setUp(() {
      repository = InMemoryAuthRepository(delay: Duration.zero);
    });

    test('login with valid credentials succeeds', () async {
      final res = await repository.login(
        email: 'ana@bettercash.dev',
        password: '123456',
      );

      expect(res.isOk, isTrue);
      expect(res.valueOrNull?.user.email, 'ana@bettercash.dev');
    });

    test('login with invalid credentials fails', () async {
      final res = await repository.login(
        email: 'ana@bettercash.dev',
        password: 'wrong_password',
      );

      expect(res.isFailure, isTrue);
      expect(res.errorOrNull, isA<UnauthorizedError>());
    });

    test('logout clears session', () async {
      await repository.login(
        email: 'ana@bettercash.dev',
        password: '123456',
      );
      expect(repository.currentSession, isNotNull);

      await repository.logout();
      expect(repository.currentSession, isNull);
    });
  });
}
