import 'package:flutter/material.dart';

import '../design/app_tokens.dart';

/// DEEP FIELD: sharp-bordered container.
///
/// Replaces the old "rounded SurfaceCard". No border radius > 4px.
/// No floating elevation. Uses a hard 1px border on dark, slightly visible on light.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.space16),
    this.color,
    this.margin,
    this.borderRadius = AppRadius.smBorderRadius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = color ?? theme.colorScheme.surfaceContainer;

    final inner = Material(
      color: surfaceColor,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius:
            borderRadius is BorderRadius ? borderRadius as BorderRadius : null,
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: ClipRRect(borderRadius: borderRadius, child: inner),
    );
  }
}
