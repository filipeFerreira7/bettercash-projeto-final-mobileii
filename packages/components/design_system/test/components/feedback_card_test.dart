import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helpers.dart';

void main() {
  group('FeedbackCard', () {
    testWidgets('renders success variant with title and description', (tester) async {
      await tester.pumpWidget(
        wrap(
          const FeedbackCard.success(
            title: 'Transação salva',
            description: 'Despesa registrada com sucesso.',
          ),
        ),
      );

      expect(find.text('Transação salva'), findsOneWidget);
      expect(find.text('Despesa registrada com sucesso.'), findsOneWidget);
    });

    testWidgets('renders error variant with action button', (tester) async {
      var retried = false;

      await tester.pumpWidget(
        wrap(
          FeedbackCard.error(
            title: 'Não foi possível sincronizar',
            description: 'Verifique a conexão.',
            onAction: () => retried = true,
          ),
        ),
      );

      expect(find.text('Não foi possível sincronizar'), findsOneWidget);
      expect(find.text('Tentar novamente'), findsOneWidget);

      await tester.tap(find.text('Tentar novamente'));
      expect(retried, isTrue);
    });

    testWidgets('renders empty variant correctly', (tester) async {
      await tester.pumpWidget(
        wrap(
          const FeedbackCard.empty(
            title: 'VAZIO · BUSCA POR "VIAGEM"',
            subtitle: 'Nada por aqui ainda',
            description: 'Não encontramos transações com esse nome.',
          ),
        ),
      );

      expect(find.text('VAZIO · BUSCA POR "VIAGEM"'), findsOneWidget);
      expect(find.text('Nada por aqui ainda'), findsOneWidget);
      expect(find.text('Não encontramos transações com esse nome.'), findsOneWidget);
    });
  });
}
