import 'package:flutter/material.dart';

import '../design/app_colors.dart';
import '../design/app_tokens.dart';
import '../design/app_typography.dart';

/// PROBE empty state — instrument panel "no signal" style.
///
/// Changed from soft icon + friendly copy to technical readout presentation.
/// Icon lives in a precise square container. Copy is brief and clinical.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: colors.s1,
                borderRadius: AppRadius.smBorderRadius,
                border: Border.all(color: colors.ruleMid, width: 1),
              ),
              child: Icon(icon, size: 24, color: colors.t2),
            ),
            const SizedBox(height: AppSpacing.space20),
            Text(
              title,
              style: TextStyle(
                fontFamily: AppTypography.monoFontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: colors.t1,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.space8),
              Text(
                message!,
                style: TextStyle(
                  fontFamily: AppTypography.sansFontFamily,
                  fontSize: 12,
                  color: colors.t2,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.space24),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
