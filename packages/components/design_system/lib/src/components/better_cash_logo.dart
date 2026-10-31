import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Official BetterCash logo widget displaying the brand asset image or fallback icon.
class BetterCashLogo extends StatelessWidget {
  const BetterCashLogo({
    super.key,
    this.assetPath = 'assets/logo.png',
    this.size = 32.0,
    this.showText = true,
    this.badgeText,
  });

  final String assetPath;
  final double size;
  final bool showText;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final logoImage = Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback placeholder widget when asset is not loaded/found in tests
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: AppRadius.smAll,
          ),
          child: Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.white,
            size: size * 0.6,
          ),
        );
      },
    );

    if (!showText) {
      return Semantics(
        label: 'BetterCash Logo',
        child: logoImage,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoImage,
        const SizedBox(width: AppSpacing.sm),
        Text(
          'BetterCash',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        if (badgeText != null) ...[
          const SizedBox(width: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.15),
              borderRadius: AppRadius.pillAll,
            ),
            child: Text(
              badgeText!,
              style: AppTypography.labelSmall.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
