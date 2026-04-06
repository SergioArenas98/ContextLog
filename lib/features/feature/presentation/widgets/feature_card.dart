import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../domain/models/feature_model.dart';
import '../providers/feature_providers.dart';

/// Feature block for the site dashboard grid.
///
/// Structural change: was a horizontal card in a list with title + badges.
/// Now: a square block with the feature number as the dominant visual element.
/// The number-first approach reflects how archaeologists actually reference features
/// (they say "Feature 003", not "the feature recorded on 24/01/2025").
class FeatureCard extends ConsumerStatefulWidget {
  const FeatureCard({super.key, required this.feature});

  final FeatureModel feature;

  @override
  ConsumerState<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends ConsumerState<FeatureCard>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final feature = widget.feature;
    final num = feature.featureNumber.toString().padLeft(3, '0');

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => context.push('/features/${feature.id}'),
      onLongPress: () => _showMenu(context),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: _BlockContent(feature: feature, num: num),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _FeatureActionsSheet(
        feature: widget.feature,
        ref: ref,
      ),
    );
  }
}

class _BlockContent extends StatelessWidget {
  const _BlockContent({required this.feature, required this.num});

  final FeatureModel feature;
  final String num;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.s1,
        borderRadius: AppRadius.lgBorderRadius,
        border: Border.all(color: AppColors.rule, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top: accent stripe + feature number ──────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.space16),
            decoration: const BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.lg),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'F',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: 2,
                    color: AppColors.onPrimaryContainer.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: AppSpacing.space2),
                Text(
                  num,
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 38,
                    letterSpacing: -2,
                    height: 1,
                    color: AppColors.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom: metadata ─────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (feature.area != null) ...[
                    _MetaLine(
                      icon: Icons.place_outlined,
                      text: feature.area!,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                  ],
                  if (feature.rubiconCode != null) ...[
                    _MetaLine(
                      icon: Icons.tag_rounded,
                      text: feature.rubiconCode!,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                  ],
                  const Spacer(),
                  _MetaLine(
                    icon: Icons.calendar_today_rounded,
                    text: _formatDate(feature.date),
                    dim: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/'
      '${d.year}';
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.text, this.dim = false});

  final IconData icon;
  final String text;
  final bool dim;

  @override
  Widget build(BuildContext context) {
    final color = dim ? AppColors.t2 : AppColors.t1;
    return Row(
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: AppSpacing.space4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontSize: 11,
              color: color,
              height: 1.3,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ── Feature actions bottom sheet ───────────────────────────────────────────────

class _FeatureActionsSheet extends StatelessWidget {
  const _FeatureActionsSheet({required this.feature, required this.ref});

  final FeatureModel feature;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.space8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            child: Row(
              children: [
                Text(
                  'Feature ${feature.featureNumber.toString().padLeft(3, '0')}',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.t0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.edit_rounded),
            title: const Text('Edit feature'),
            onTap: () {
              Navigator.pop(context);
              context.push('/features/${feature.id}/edit');
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_rounded, color: AppColors.error),
            title: Text(
              'Delete feature',
              style: TextStyle(color: AppColors.error),
            ),
            onTap: () async {
              Navigator.pop(context);
              final confirmed = await showConfirmDeleteDialog(
                context,
                title: 'Delete Feature ${feature.featureNumber}?',
                message:
                    'This will permanently delete the feature and all associated '
                    'contexts, finds, samples, photos, drawings, and Harris Matrix data.',
              );
              if (confirmed) {
                await ref.read(featureRepositoryProvider).delete(feature.id);
                ref.invalidate(filteredFeatureListProvider);
                ref.invalidate(featureListProvider);
              }
            },
          ),
          const SizedBox(height: AppSpacing.space8),
        ],
      ),
    );
  }
}
