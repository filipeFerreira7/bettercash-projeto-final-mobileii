import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Quick monetary value selector buttons row.
///
/// Refers to "Adição rápida" value chips (`+ R$ 50`, `+ R$ 100`, `+ R$ 500`) in the Design System catalog.
class QuickValueSelector extends StatelessWidget {
  const QuickValueSelector({
    required this.values,
    required this.onValueSelected,
    super.key,
    this.currencySymbol = 'R\$',
  });

  final List<double> values;
  final ValueChanged<double> onValueSelected;
  final String currencySymbol;

  String _formatValue(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Row(
      children: values.map((val) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: OutlinedButton(
              key: Key('quick_value_${val.toInt()}'),
              onPressed: () => onValueSelected(val),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xs,
                ),
                side: BorderSide(color: primaryColor.withValues(alpha: 0.4)),
                shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
              ),
              child: Text(
                '+ $currencySymbol ${_formatValue(val)}',
                style: AppTypography.labelMedium.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
