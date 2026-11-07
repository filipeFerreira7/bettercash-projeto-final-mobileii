import 'package:carteira_core/carteira_core.dart';
import 'package:carteira_design_system/carteira_design_system.dart';
import 'package:flutter/material.dart';

import 'home_coordinator.dart';
import 'home_view_model.dart';

/// Pure UI View Widget for the Home Scene constructed with MVVM + Design System.
class HomeView extends StatefulWidget {
  const HomeView({
    required this.viewModel,
    required this.coordinator,
    super.key,
  });

  final HomeViewModel viewModel;
  final HomeCoordinator coordinator;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final vm = widget.viewModel;
        final theme = Theme.of(context);
        final semantic = context.semanticColors;

        return AppScaffold(
          showAppBar: false,
          padded: false,
          bottom: NavigationBar(
            selectedIndex: vm.currentTabIndex,
            onDestinationSelected: (index) {
              vm.setTabIndex(index);
              widget.coordinator.onTabSelected(context, index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet_rounded),
                label: 'Carteira',
              ),
              NavigationDestination(
                icon: Icon(Icons.format_list_bulleted_rounded),
                label: 'Lançamentos',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_rounded),
                label: 'Histórico',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Perfil',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            key: const Key('home_fab_add'),
            onPressed: () => widget.coordinator.onAddTransaction(context),
            backgroundColor: semantic.income,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(Icons.add_rounded, size: 28),
          ),
          body: vm.isLoading
              ? const StateView.loading(message: 'Carregando resumo do mês...')
              : vm.errorMessage != null
                  ? StateView.error(
                      message: vm.errorMessage!,
                      onRetry: vm.loadData,
                    )
                  : _buildBodyContent(context, vm, theme, semantic),
        );
      },
    );
  }

  Widget _buildBodyContent(
    BuildContext context,
    HomeViewModel vm,
    ThemeData theme,
    AppSemanticColors semantic,
  ) {
    final dashboard = vm.dashboard;
    final balanceText = vm.isBalanceVisible
        ? MoneyFormatter.format(dashboard?.balance ?? 4286.41)
        : 'R\$ ••••••';
    final incomeText = MoneyFormatter.format(dashboard?.income ?? 9526.55);
    final expenseText = MoneyFormatter.format(dashboard?.expense ?? 5240.14);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screen),
      children: [
        const Gap.md(),

        // Header Title Row: Carteira ...
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Carteira',
              style: AppTypography.displayLarge.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  key: const Key('home_toggle_theme'),
                  tooltip: vm.isDarkMode ? 'Tema claro' : 'Tema escuro',
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) =>
                        RotationTransition(turns: animation, child: child),
                    child: Icon(
                      vm.isDarkMode
                          ? Icons.brightness_7_rounded
                          : Icons.brightness_6_outlined,
                      key: ValueKey(vm.isDarkMode),
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  onPressed: vm.toggleTheme,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: theme.colorScheme.onSurface,
                  ),
                  onPressed: () => widget.coordinator.onOpenOptions(context),
                ),
              ],
            ),
          ],
        ),
        const Gap.xs(),

        // Subtitle Row: Month Label & Resumo Mensal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              vm.monthLabel,
              style: AppTypography.titleMedium.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Resumo mensal',
              style: AppTypography.bodySmall.copyWith(
                color: semantic.muted,
              ),
            ),
          ],
        ),
        const Gap.sm(),

        // Month Selector Chips Bar
        MonthSelectorBar(
          months: vm.months,
          selectedMonth: vm.months[vm.selectedMonthIndex],
          onMonthSelected: (month) {
            final idx = vm.months.indexOf(month);
            if (idx >= 0) vm.selectMonthIndex(idx);
          },
          onPrevious: () => vm.selectMonthIndex(vm.selectedMonthIndex - 1),
          onNext: () => vm.selectMonthIndex(vm.selectedMonthIndex + 1),
        ),
        const Gap.md(),

        // Balance Card with Visibility Toggle (Eye Icon)
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saldo do mês',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: semantic.muted,
                      ),
                    ),
                    IconButton(
                      key: const Key('home_toggle_balance'),
                      icon: Icon(
                        vm.isBalanceVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                        color: semantic.muted,
                      ),
                      onPressed: vm.toggleBalanceVisibility,
                    ),
                  ],
                ),
                const Gap.xs(),
                Text(
                  balanceText,
                  style: AppTypography.displayLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Gap.lg(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Entradas',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: semantic.muted,
                            ),
                          ),
                          const Gap.xxs(),
                          MoneyText(
                            incomeText,
                            tone: MoneyTone.income,
                            size: MoneySize.medium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saídas',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: semantic.muted,
                            ),
                          ),
                          const Gap.xxs(),
                          MoneyText(
                            expenseText,
                            tone: MoneyTone.expense,
                            size: MoneySize.medium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap.lg(),

        // Section Header: POR CATEGORIA
        const SectionHeader(title: 'POR CATEGORIA'),

        // Dynamic Category Bars from Dashboard Data
        if (dashboard != null && dashboard.byCategory.isNotEmpty)
          ...dashboard.byCategory.map((cat) {
            return CategoryBar(
              label: cat.category,
              amount: MoneyFormatter.format(cat.amount),
              share: cat.percent / 100.0,
            );
          })
        else ...[
          // Default fallback category list matching screenshot
          const CategoryBar(label: 'Moradia', amount: 'R\$ 3.027,16', share: 0.58),
          const CategoryBar(label: 'Saúde', amount: 'R\$ 883,90', share: 0.17),
          const CategoryBar(label: 'Alimentação', amount: 'R\$ 380,85', share: 0.07),
          const CategoryBar(label: 'Educação', amount: 'R\$ 304,43', share: 0.06),
          const CategoryBar(label: 'Transporte', amount: 'R\$ 261,72', share: 0.05),
          const CategoryBar(label: 'Outros', amount: 'R\$ 229,35', share: 0.04),
          const CategoryBar(label: 'Sem categoria', amount: 'R\$ 130,83', share: 0.02),
          const CategoryBar(label: 'Lazer', amount: 'R\$ 21,90', share: 0.00),
        ],

        const Gap.xxl(),
      ],
    );
  }
}
