import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_bettercash/main.dart';

void main() {
  testWidgets('BetterCashApp renders showcase screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BetterCashApp());
    expect(find.text('BetterCash — Protótipo Design System'), findsOneWidget);
  });
}
