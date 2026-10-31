import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('DateHeader', () {
    testWidgets('renders date text in uppercase', (tester) async {
      await tester.pumpWidget(
        wrap(const DateHeader('Domingo, 27 de Setembro')),
      );

      expect(find.text('DOMINGO, 27 DE SETEMBRO'), findsOneWidget);
    });
  });
}
