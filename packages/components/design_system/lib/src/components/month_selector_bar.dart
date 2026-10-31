import 'package:flutter/material.dart';

import '../theme/app_semantic_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Month selection chips row with navigation chevrons.
///
/// Refers to "Chip de mês / ativo e padrão" in the Design System catalog.
class MonthSelectorBar extends StatelessWidget {
  const MonthSelectorBar({
    required this.months,
    required this.selectedMonth,
    required this.onMonthSelected,
    super.key,
    this.onPrevious,
    this.onNext,
  });

  final List<String> months;
  final String selectedMonth;
  final ValueChanged<String> onMonthSelected;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final mutedColor = context.semanticColors.muted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          IconButton(
            key: const Key('month_previous'),
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: onPrevious,
            tooltip: 'Mês anterior',
            iconSize: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: months.map((month) {
                  final isSelected = month.toUpperCase() == selectedMonth.toUpperCase();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                    child: ChoiceChip(
                      label: Text(month.toUpperCase()),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) onMonthSelected(month);
                      },
                      labelStyle: AppTypography.labelSmall.copyWith(
                        color: isSelected ? Colors.white : mutedColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      selectedColor: primaryColor,
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.pillAll,
                        side: BorderSide(
                          color: isSelected ? primaryColor : theme.colorScheme.outline,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            key: const Key('month_next'),
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: onNext,
            tooltip: 'Próximo mês',
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
