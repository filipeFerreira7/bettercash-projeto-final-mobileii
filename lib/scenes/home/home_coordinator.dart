import 'package:flutter/material.dart';

/// Coordinator handling navigation flow and route transitions for Home Scene.
class HomeCoordinator {
  const HomeCoordinator();

  /// Triggers new transaction modal or creation screen flow.
  void onAddTransaction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abrir modal de Novo Lançamento'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  /// Triggers options menu action.
  void onOpenOptions(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abrir Opções da Carteira'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  /// Coordinates navigation when switching tabs.
  void onTabSelected(BuildContext context, int index) {
    // Navigation logic for tabs (0: Carteira, 1: Lançamentos, 2: Histórico, 3: Perfil)
  }
}
