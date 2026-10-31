import 'package:flutter/material.dart';

import '../theme/app_semantic_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Informational alert banner component.
///
/// Refers to the green alert banner at the bottom of section 03 in the Design System catalog.
class AlertBanner extends StatelessWidget {
  const AlertBanner({
    required this.message,
    super.key,
    this.icon = Icons.info_outline_rounded,
    this.onTap,
  });

  final String message;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final semantic = context.semanticColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: semantic.income.withValues(alpha: 0.12),
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: semantic.income.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: semantic.income,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: AppTypography.bodySmall.copyWith(
                  color: semantic.income,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
