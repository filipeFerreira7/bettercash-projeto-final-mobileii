import 'package:carteira_core/carteira_core.dart';
import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_bettercash/scenes/home/home_factory.dart';

void main() {
  group('Home Scene (MVVM + Factory)', () {
    testWidgets('renders Home View with balance and categories from repository', (WidgetTester tester) async {
      final repo = InMemoryDashboardRepository(delay: Duration.zero);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: HomeFactory.create(dashboardRepository: repo),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Carteira'), findsWidgets);
      expect(find.text('Setembro de 2026'), findsOneWidget);
      expect(find.text('Saldo do mês'), findsOneWidget);
      expect(find.text('POR CATEGORIA'), findsOneWidget);
      expect(find.text('Moradia'), findsOneWidget);

      // Toggles balance visibility on eye icon tap
      await tester.tap(find.byKey(const Key('home_toggle_balance')));
      await tester.pumpAndSettle();
      expect(find.text('R\$ ••••••'), findsOneWidget);
    });
  });
}
