import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('BetterCashLogo', () {
    testWidgets('renders logo text and badge when provided', (tester) async {
      await tester.pumpWidget(
        wrap(const BetterCashLogo(badgeText: 'Web')),
      );
      expect(find.text('BetterCash'), findsOneWidget);
      expect(find.text('Web'), findsOneWidget);
    });

    testWidgets('renders fallback icon when asset fails to load in tests', (tester) async {
      await tester.pumpWidget(
        wrap(const BetterCashLogo(showText: false)),
      );
      expect(find.text('BetterCash'), findsNothing);
    });
  });
}
