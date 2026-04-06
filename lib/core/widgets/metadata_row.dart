import 'package:flutter/material.dart';

import '../design/app_tokens.dart';

/// A label–value pair row for detail views and card subtitles.
///
/// Replaces the private `_InfoRow` in [FeatureSummaryTab].
class MetadataRow extends StatelessWidget {
  const MetadataRow({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
    this.icon,
  });

  final String label;
  final String value;
  final TextStyle? valueStyle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: theme.colorScheme.outline),
            const SizedBox(width: AppSpacing.space4),
          ],
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: valueStyle ?? theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
