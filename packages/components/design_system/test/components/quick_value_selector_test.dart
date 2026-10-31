import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('QuickValueSelector', () {
    testWidgets('renders quick value buttons and triggers onValueSelected', (tester) async {
      double? selectedVal;

      await tester.pumpWidget(
        wrap(
          QuickValueSelector(
            values: const [50.0, 100.0, 500.0],
            onValueSelected: (val) => selectedVal = val,
          ),
        ),
      );

      expect(find.text('+ R\$ 50'), findsOneWidget);
      expect(find.text('+ R\$ 100'), findsOneWidget);
      expect(find.text('+ R\$ 500'), findsOneWidget);

      await tester.tap(find.byKey(const Key('quick_value_100')));
      expect(selectedVal, 100.0);
    });
  });
}
