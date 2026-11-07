import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_bettercash/main.dart';

void main() {
  testWidgets('BetterCashApp renders Home Scene smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BetterCashApp());
    await tester.pumpAndSettle();
    expect(find.text('Carteira'), findsWidgets);
  });
}
