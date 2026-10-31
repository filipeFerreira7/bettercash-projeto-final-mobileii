import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('AlertBanner', () {
    testWidgets('renders message and icon', (tester) async {
      await tester.pumpWidget(
        wrap(
          const AlertBanner(
            message: 'Pronto para evoluir como biblioteca local.',
          ),
        ),
      );

      expect(find.text('Pronto para evoluir como biblioteca local.'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);
    });
  });
}
