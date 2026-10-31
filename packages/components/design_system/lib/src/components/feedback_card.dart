import 'package:flutter/material.dart';

import '../theme/app_semantic_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';
import 'app_button.dart';
import 'better_cash_logo.dart';

enum FeedbackTone { success, error, warning, info, empty, loading }

/// Complete feedback card family widget.
///
/// Refers to "Feedback / família completa" in the Design System catalog.
class FeedbackCard extends StatelessWidget {
  const FeedbackCard.success({
    required this.title,
    required this.description,
    super.key,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  })  : tone = FeedbackTone.success,
        icon = Icons.check_circle_outline_rounded;

  const FeedbackCard.error({
    required this.title,
    required this.description,
    super.key,
    this.subtitle,
    this.actionLabel = 'Tentar novamente',
    this.onAction,
  })  : tone = FeedbackTone.error,
        icon = Icons.highlight_off_rounded;

  const FeedbackCard.warning({
    required this.title,
    required this.description,
    super.key,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  })  : tone = FeedbackTone.warning,
        icon = Icons.warning_amber_rounded;

  const FeedbackCard.info({
    required this.description,
    super.key,
    this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  })  : tone = FeedbackTone.info,
        icon = Icons.info_outline_rounded;

  const FeedbackCard.empty({
    required this.title,
    required this.subtitle,
    required this.description,
    super.key,
    this.actionLabel = 'Limpar busca',
    this.onAction,
  })  : tone = FeedbackTone.empty,
        icon = Icons.search_off_rounded;

  const FeedbackCard.loading({
    required this.title,
    super.key,
    this.description = 'Buscando os lançamentos mais recentes.',
  })  : tone = FeedbackTone.loading,
        icon = null,
        actionLabel = null,
        onAction = null,
        subtitle = null;

  final FeedbackTone tone;
  final String? title;
  final String? subtitle;
  final String description;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.semanticColors;

    if (tone == FeedbackTone.empty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Column(
          children: [
            Text(
              (title ?? '').toUpperCase(),
              style: AppTypography.labelSmall.copyWith(
                color: semantic.muted,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const BetterCashLogo(size: 48, showText: false),
            const SizedBox(height: AppSpacing.md),
            Text(
              subtitle ?? 'Nada por aqui ainda',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(color: semantic.muted),
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton.secondary(
                label: actionLabel!,
                onPressed: onAction,
                expanded: false,
              ),
            ],
          ],
        ),
      );
    }

    if (tone == FeedbackTone.loading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(semantic.income),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    title ?? 'Atualizando...',
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            // Skeleton placeholders
            const _SkeletonPlaceholder(),
            const SizedBox(height: AppSpacing.xs),
            const _SkeletonPlaceholder(widthFactor: 0.7),
            const SizedBox(height: AppSpacing.md),
            Text(
              description,
              style: AppTypography.bodySmall.copyWith(color: semantic.muted),
            ),
          ],
        ),
      );
    }

    final (bgColor, accentColor) = switch (tone) {
      FeedbackTone.success => (
          semantic.income.withValues(alpha: 0.1),
          semantic.income
        ),
      FeedbackTone.error => (
          semantic.expense.withValues(alpha: 0.1),
          semantic.expense
        ),
      FeedbackTone.warning => (
          semantic.warning.withValues(alpha: 0.12),
          semantic.warning
        ),
      FeedbackTone.info => (
          theme.colorScheme.primary.withValues(alpha: 0.1),
          theme.colorScheme.primary
        ),
      _ => (theme.colorScheme.surface, theme.colorScheme.onSurface),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Icon(icon, color: accentColor, size: 22),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    if (title != null) const SizedBox(height: AppSpacing.xxs),
                    Text(
                      description,
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (onAction != null && actionLabel != null) ...[
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton.secondary(
                label: actionLabel!,
                onPressed: onAction,
                expanded: false,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SkeletonPlaceholder extends StatelessWidget {
  const _SkeletonPlaceholder({this.widthFactor = 1.0});

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 12,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          borderRadius: AppRadius.smAll,
        ),
      ),
    );
  }
}
