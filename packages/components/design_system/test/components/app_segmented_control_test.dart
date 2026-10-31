import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('AppSegmentedControl', () {
    testWidgets('renders options and changes selection on tap', (tester) async {
      var selected = 'Todos';
      final options = ['Todos', 'Receita', 'Despesa', 'Transf.'];

      await tester.pumpWidget(
        wrap(
          AppSegmentedControl<String>(
            options: options,
            selected: selected,
            onSelected: (value) => selected = value,
          ),
        ),
      );

      expect(find.text('Todos'), findsOneWidget);
      expect(find.text('Receita'), findsOneWidget);
      expect(find.text('Despesa'), findsOneWidget);
      expect(find.text('Transf.'), findsOneWidget);

      await tester.tap(find.text('Receita'));
      expect(selected, 'Receita');
    });
  });
}
