import 'package:flutter/material.dart';

import '../theme/app_semantic_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Settings / Profile preference row tile.
///
/// Refers to "Linha de preferência / Perfil" in the Design System catalog.
class PreferenceTile extends StatelessWidget {
  const PreferenceTile({
    required this.title,
    required this.icon,
    super.key,
    this.subtitle,
    this.onTap,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = context.semanticColors.muted;
    final primaryColor = theme.colorScheme.primary;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: primaryColor.withValues(alpha: 0.12),
          borderRadius: AppRadius.mdAll,
        ),
        child: Icon(
          icon,
          color: primaryColor,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: AppTypography.titleSmall.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.bodySmall.copyWith(color: muted),
            )
          : null,
      trailing: trailing ??
          Icon(
            Icons.chevron_right_rounded,
            color: muted,
          ),
    );
  }
}
