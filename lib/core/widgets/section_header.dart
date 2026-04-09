import 'package:flutter/material.dart';

import '../design/app_colors.dart';
import '../design/app_tokens.dart';
import '../design/app_typography.dart';

/// DEEP FIELD: ALL-CAPS tracked section label with count badge and rule line.
///
/// Replaces the old accent-bar header. This looks like a technical legend marker.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.label,
    this.count,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.space16,
      vertical: AppSpacing.space12,
    ),
    this.showRule = true,
  });

  final String label;
  final int? count;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final bool showRule;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: colors.t2,
                  letterSpacing: 2.0,
                  height: 1.2,
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: AppSpacing.space8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: AppRadius.xsBorderRadius,
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onPrimaryContainer,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
          if (showRule) ...[
            const SizedBox(height: AppSpacing.space8),
            Container(
              height: 1,
              color: colors.rule,
            ),
          ],
        ],
      ),
    );
  }
}
