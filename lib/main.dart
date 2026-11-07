import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';

import 'scenes/home/home_factory.dart';

/// Notifier global de tema. Fonte única de verdade para o app inteiro.
/// Default: Light (branco por padrão).
final ValueNotifier<ThemeMode> themeModeNotifier =
ValueNotifier<ThemeMode>(ThemeMode.light);

void main() {
  runApp(const BetterCashApp());
}

class BetterCashApp extends StatelessWidget {
  const BetterCashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'BetterCash — Finanças Pessoais',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: mode,
          // ⬇️ FIX: repassa o MESMO notifier para a Home. Sem isso,
          // a HomeFactory cria um notifier paralelo e o tema nunca troca.
          home: HomeFactory.create(themeNotifier: themeModeNotifier),
        );
      },
    );
  }
}

/// Botão de troca de tema. Fonte única: `themeModeNotifier`.
/// Reutilizável em qualquer tela (Home, Perfil, etc.).
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        return IconButton(
          key: const Key('theme_toggle_button'),
          tooltip: isDark
              ? 'Alternar para tema claro'
              : 'Alternar para tema escuro',
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            themeModeNotifier.value =
            isDark ? ThemeMode.light : ThemeMode.dark;
          },
        );
      },
    );
  }
}