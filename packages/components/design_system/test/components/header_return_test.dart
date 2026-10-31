import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('HeaderReturn', () {
    testWidgets('renders title and triggers back and close callbacks', (tester) async {
      var backTapped = false;
      var closeTapped = false;

      await tester.pumpWidget(
        wrap(
          HeaderReturn(
            title: 'Novo lançamento',
            onBack: () => backTapped = true,
            onClose: () => closeTapped = true,
          ),
        ),
      );

      expect(find.text('Novo lançamento'), findsOneWidget);

      await tester.tap(find.byKey(const Key('header_return_back')));
      expect(backTapped, isTrue);

      await tester.tap(find.byKey(const Key('header_return_close')));
      expect(closeTapped, isTrue);
    });
  });
}
