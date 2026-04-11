import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../../project/presentation/providers/project_providers.dart';
import '../../domain/models/feature_model.dart';
import '../providers/feature_providers.dart';

/// Feature Roster Item — a single row in the site roster.
///
/// Left column: first cut contextNumber (or "—" if no cuts exist).
/// Middle: area tag + project code / licence.
/// Right: date.
class FeatureRosterItem extends ConsumerStatefulWidget {
  const FeatureRosterItem({super.key, required this.feature});

  final FeatureModel feature;

  @override
  ConsumerState<FeatureRosterItem> createState() => _FeatureRosterItemState();
}

class _FeatureRosterItemState extends ConsumerState<FeatureRosterItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final feature = widget.feature;

    final project = feature.projectId != null
        ? ref.watch(projectDetailProvider(feature.projectId!)).valueOrNull
        : null;

    final firstCut = ref.watch(firstCutByFeatureProvider(feature.id)).valueOrNull;
    final cutLabel = firstCut != null
        ? firstCut.contextNumber.toString().padLeft(3, '0')
        : '—';

    // Build the project code line: site code · licence, or project name if neither
    String? projectLine;
    if (project != null) {
      final parts = [
        if (project.rubiconCode != null) project.rubiconCode!,
        if (project.licenceNumber != null) project.licenceNumber!,
      ];
      projectLine = parts.isNotEmpty ? parts.join(' · ') : project.name;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => context.push('/features/${feature.id}'),
      onLongPress: () => _showActions(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        color: _pressed ? colors.s2 : colors.s0,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space16,
          14.0,
          AppSpacing.space16,
          14.0,
        ),
        child: Row(
          children: [
            // ── First cut number (mono, dominant) ─────────────────────────
            SizedBox(
              width: 56,
              child: Text(
                cutLabel,
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  letterSpacing: -0.5,
                  height: 1,
                  color: firstCut != null ? colors.t0 : colors.t2,
                ),
              ),
            ),

            // ── Site Information ───────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (feature.area != null)
                    Text(
                      'Area ${feature.area!}',
                      style: TextStyle(
                        fontFamily: AppTypography.sansFontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: colors.t0,
                        height: 1.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  else
                    Text(
                      'No area',
                      style: TextStyle(
                        fontFamily: AppTypography.sansFontFamily,
                        fontSize: 12,
                        color: colors.t2,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  if (projectLine != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      projectLine,
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontSize: 10,
                        letterSpacing: 0.5,
                        color: colors.t2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // ── Date ──────────────────────────────────────────────────────
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatDate(feature.date),
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontSize: 10,
                    letterSpacing: 0.5,
                    color: colors.t2,
                  ),
                ),
                const SizedBox(height: 2),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 16,
                  color: colors.t2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/'
      '${d.year}';

  void _showActions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _FeatureActionsSheet(
        feature: widget.feature,
        ref: ref,
      ),
    );
  }
}

// ── Feature actions sheet ─────────────────────────────────────────────────────

class _FeatureActionsSheet extends StatelessWidget {
  const _FeatureActionsSheet({required this.feature, required this.ref});

  final FeatureModel feature;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
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
                  'F${feature.featureNumber.toString().padLeft(3, '0')}',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: colors.t0,
                  ),
                ),
                if (feature.area != null) ...[
                  const SizedBox(width: AppSpacing.space8),
                  Text(
                    'Area ${feature.area!}',
                    style: TextStyle(
                      fontFamily: AppTypography.sansFontFamily,
                      fontSize: 14,
                      color: colors.t1,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.edit_outlined, size: 20),
            title: const Text('Edit feature'),
            onTap: () {
              Navigator.pop(context);
              context.push('/features/${feature.id}/edit');
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_outline_rounded, size: 20, color: colors.error),
            title: Text(
              'Delete feature',
              style: TextStyle(color: colors.error),
            ),
            onTap: () async {
              Navigator.pop(context);
              final confirmed = await showConfirmDeleteDialog(
                context,
                title: 'Delete Feature ${feature.featureNumber}?',
                message:
                    'This permanently deletes the feature and all associated '
                    'contexts, finds, samples, photos, drawings, and matrix data.',
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
