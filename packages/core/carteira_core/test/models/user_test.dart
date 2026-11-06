import 'package:carteira_core/carteira_core.dart';
import 'package:test/test.dart';

void main() {
  group('User Model', () {
    test('serializes to and from JSON', () {
      final user = User(
        id: 'usr_01',
        name: 'Ana Ribeiro',
        email: 'ana@bettercash.dev',
        createdAt: DateTime.utc(2024, 3, 11),
      );

      final json = user.toJson();
      expect(json['id'], 'usr_01');
      expect(json['name'], 'Ana Ribeiro');

      final deserialized = User.fromJson(json);
      expect(deserialized.id, user.id);
      expect(deserialized.name, user.name);
    });
  });
}
