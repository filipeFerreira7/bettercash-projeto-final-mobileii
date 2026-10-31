import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('PreferenceTile', () {
    testWidgets('renders title, subtitle, icon and responds to tap', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrap(
          PreferenceTile(
            title: 'Privacidade e segurança',
            subtitle: 'Cuide dos seus dados',
            icon: Icons.security_rounded,
            onTap: () => tapped = true,
          ),
        ),
      );

      expect(find.text('Privacidade e segurança'), findsOneWidget);
      expect(find.text('Cuide dos seus dados'), findsOneWidget);
      expect(find.byIcon(Icons.security_rounded), findsOneWidget);

      await tester.tap(find.byType(PreferenceTile));
      expect(tapped, isTrue);
    });
  });
}
