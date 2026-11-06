import 'dart:io';

import 'package:carteira_core/carteira_core.dart';
import 'package:test/test.dart';

void main() {
  group('SeedData Parser', () {
    test('parses seed.json correctly', () {
      final file = File('../../../seed.json');
      expect(file.existsSync(), isTrue, reason: 'seed.json must exist at project root');

      final content = file.readAsStringSync();
      final seedData = SeedData.fromJsonString(content);

      expect(seedData.users, isNotEmpty);
      expect(seedData.users.first.email, 'ana@bettercash.dev');
      expect(seedData.transactions, isNotEmpty);
    });
  });
}
