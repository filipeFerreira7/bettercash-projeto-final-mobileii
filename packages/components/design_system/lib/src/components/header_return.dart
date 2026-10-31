import 'package:flutter/material.dart';

import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Top app bar header with return back action (<-), title, and close action (X).
///
/// Refers to "Cabeçalho / retorno" in the Design System catalog.
class HeaderReturn extends StatelessWidget implements PreferredSizeWidget {
  const HeaderReturn({
    required this.title,
    super.key,
    this.onBack,
    this.onClose,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onClose;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Row(
          children: [
            IconButton(
              key: const Key('header_return_back'),
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Voltar',
              onPressed: onBack ?? () => Navigator.maybePop(context),
            ),
            Expanded(
              child: Text(
                title,
                style: AppTypography.titleLarge.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onClose != null)
              IconButton(
                key: const Key('header_return_close'),
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Fechar',
                onPressed: onClose,
              ),
          ],
        ),
      ),
    );
  }
}
