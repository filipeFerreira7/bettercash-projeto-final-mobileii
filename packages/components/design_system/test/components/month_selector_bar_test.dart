import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('MonthSelectorBar', () {
    testWidgets('renders month chips and triggers selection and navigation', (tester) async {
      String selected = 'SET';
      var prevTapped = false;
      var nextTapped = false;

      await tester.pumpWidget(
        wrap(
          StatefulBuilder(
            builder: (context, setState) {
              return MonthSelectorBar(
                months: const ['JUL', 'AGO', 'SET', 'OUT'],
                selectedMonth: selected,
                onMonthSelected: (month) => setState(() => selected = month),
                onPrevious: () => prevTapped = true,
                onNext: () => nextTapped = true,
              );
            },
          ),
        ),
      );

      expect(find.text('SET'), findsOneWidget);
      expect(find.text('JUL'), findsOneWidget);

      await tester.tap(find.text('AGO'));
      await tester.pumpAndSettle();
      expect(selected, 'AGO');

      await tester.tap(find.byKey(const Key('month_previous')));
      expect(prevTapped, isTrue);

      await tester.tap(find.byKey(const Key('month_next')));
      expect(nextTapped, isTrue);
    });
  });
}
