import 'package:flutter/material.dart';

import '../theme/app_semantic_colors.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Date grouping header with uppercase, tracking-expanded typography.
///
/// Refers to "Cabeçalho de data" in the Design System catalog.
class DateHeader extends StatelessWidget {
  const DateHeader(
    this.dateText, {
    super.key,
  });

  final String dateText;

  @override
  Widget build(BuildContext context) {
    final muted = context.semanticColors.muted;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.xs,
      ),
      child: Text(
        dateText.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: muted,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
