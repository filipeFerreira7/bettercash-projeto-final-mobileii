import 'package:carteira_core/carteira_core.dart';
import 'package:flutter/material.dart';

import 'home_coordinator.dart';
import 'home_view.dart';
import 'home_view_model.dart';

abstract final class HomeFactory {
  static Widget create({
    DashboardRepository? dashboardRepository,
    HomeCoordinator? coordinator,
    ValueNotifier<ThemeMode>? themeNotifier,
  }) {
    final repository = dashboardRepository ?? InMemoryDashboardRepository();
    final coord = coordinator ?? const HomeCoordinator();

    final viewModel = HomeViewModel(
      dashboardRepository: repository,
      themeNotifier: themeNotifier ?? ValueNotifier<ThemeMode>(ThemeMode.light),
    );

    return HomeView(viewModel: viewModel, coordinator: coord);
  }
}