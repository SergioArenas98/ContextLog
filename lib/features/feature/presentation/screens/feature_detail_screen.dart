import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../../context/presentation/widgets/context_form_sheet.dart';
import '../../../drawing/presentation/widgets/drawing_list_tab.dart';
import '../../../find/presentation/widgets/find_list_tab.dart';
import '../../../harris_matrix/presentation/widgets/harris_matrix_painter.dart';
import '../../../harris_matrix/presentation/providers/harris_providers.dart';
import '../../../harris_matrix/presentation/widgets/matrix_tab.dart';
import '../../../harris_matrix/presentation/widgets/relation_form_sheet.dart';
import '../../../photo/presentation/widgets/photo_list_tab.dart';
import '../../../sample/presentation/widgets/sample_list_tab.dart';
import '../providers/feature_providers.dart';

/// Feature Workbench — replaces the 6-tab FeatureDetailScreen.
///
/// What was eliminated:
/// - 6-tab structure (Contexts / Photos / Drawings / Finds / Samples / Matrix)
/// - Harris Matrix buried at tab position #6
/// - Independent FAB per tab (6 separate entry points)
/// - No way to see contexts as a whole across tabs
///
/// What replaced it:
/// - Harris Matrix as the primary view (upper ~55% of screen)
/// - Horizontal context strip (lower ~25%) replacing the tab-per-entity pattern
/// - 3-action bottom bar: Add Context | Add Relation | More Evidence
/// - Context nodes/cards navigate to a dedicated Context Focus screen
///
/// Navigation from here:
///   Tap context strip card  → ContextFocusScreen
///   Tap "More" menu item    → Evidence view in modal sheet
///   Tap "Context"           → ContextFormSheet
///   Tap "Relation"          → RelationFormSheet
class FeatureDetailScreen extends ConsumerWidget {
  const FeatureDetailScreen({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featureAsync = ref.watch(featureDetailProvider(featureId));

    return featureAsync.when(
      loading: () => const _WorkbenchSkeleton(),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Feature')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (feature) {
        if (feature == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Feature')),
            body: const Center(child: Text('Feature not found')),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.base,
          body: Column(
            children: [
              _WorkbenchHeader(
                featureNumber: feature.featureNumber,
                area: feature.area,
                featureId: featureId,
              ),
              const _SectionLabel(label: 'STRATIGRAPHY'),
              Expanded(
                flex: 55,
                child: _MatrixPanel(featureId: featureId),
              ),
              const _SectionLabel(label: 'CONTEXTS'),
              SizedBox(
                height: 130,
                child: _ContextStrip(featureId: featureId),
              ),
              _WorkbenchActionRow(featureId: featureId),
            ],
          ),
        );
      },
    );
  }
}

// ── Workbench header ───────────────────────────────────────────────────────────

class _WorkbenchHeader extends ConsumerWidget {
  const _WorkbenchHeader({
    required this.featureNumber,
    required this.area,
    required this.featureId,
  });

  final String featureNumber;
  final String? area;
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.s0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space4,
            AppSpacing.space4,
            AppSpacing.space8,
            AppSpacing.space8,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                color: AppColors.t1,
                onPressed: () => context.pop(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'FEATURE',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 9,
                      letterSpacing: 2.5,
                      color: AppColors.t2,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        featureNumber.padLeft(3, '0'),
                        style: TextStyle(
                          fontFamily: AppTypography.monoFontFamily,
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                          letterSpacing: -1,
                          height: 1,
                          color: AppColors.t0,
                        ),
                      ),
                      if (area != null) ...[
                        const SizedBox(width: AppSpacing.space8),
                        Text(
                          area!,
                          style: TextStyle(
                            fontFamily: AppTypography.sansFontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.t1,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_rounded, size: 20),
                color: AppColors.t1,
                tooltip: 'Edit feature',
                onPressed: () => context.push('/features/$featureId/edit'),
              ),
              PopupMenuButton<String>(
                icon:
                    Icon(Icons.more_horiz_rounded, size: 22, color: AppColors.t1),
                tooltip: 'More views',
                onSelected: (value) => _openView(context, ref, value),
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'photos',
                    child: Row(children: [
                      Icon(Icons.photo_library_outlined, size: 18),
                      SizedBox(width: 10),
                      Text('Photos'),
                    ]),
                  ),
                  PopupMenuItem(
                    value: 'finds',
                    child: Row(children: [
                      Icon(Icons.category_outlined, size: 18),
                      SizedBox(width: 10),
                      Text('All Finds'),
                    ]),
                  ),
                  PopupMenuItem(
                    value: 'samples',
                    child: Row(children: [
                      Icon(Icons.science_outlined, size: 18),
                      SizedBox(width: 10),
                      Text('All Samples'),
                    ]),
                  ),
                  PopupMenuItem(
                    value: 'drawings',
                    child: Row(children: [
                      Icon(Icons.draw_outlined, size: 18),
                      SizedBox(width: 10),
                      Text('Drawings'),
                    ]),
                  ),
                  PopupMenuItem(
                    value: 'matrix_full',
                    child: Row(children: [
                      Icon(Icons.account_tree_outlined, size: 18),
                      SizedBox(width: 10),
                      Text('Full Matrix'),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openView(BuildContext context, WidgetRef ref, String view) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => _FullViewSheet(
        title: switch (view) {
          'photos' => 'Photos',
          'finds' => 'All Finds',
          'samples' => 'All Samples',
          'drawings' => 'Drawings',
          'matrix_full' => 'Stratigraphic Matrix',
          _ => '',
        },
        child: switch (view) {
          'photos' => PhotoListTab(featureId: featureId),
          'finds' => FindListTab(featureId: featureId),
          'samples' => SampleListTab(featureId: featureId),
          'drawings' => DrawingListTab(featureId: featureId),
          'matrix_full' => MatrixTab(featureId: featureId),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class _FullViewSheet extends StatelessWidget {
  const _FullViewSheet({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.space8),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space20,
            AppSpacing.space8,
            AppSpacing.space8,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: Theme.of(context).textTheme.titleLarge),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(child: child),
      ],
    );
  }
}

// ── Section label ──────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.s0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, color: AppColors.rule),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space6,
              AppSpacing.space8,
              AppSpacing.space6,
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: 2.0,
                    color: AppColors.t2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Matrix panel ───────────────────────────────────────────────────────────────

class _MatrixPanel extends ConsumerWidget {
  const _MatrixPanel({required this.featureId});
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationsAsync = ref.watch(harrisByFeatureProvider(featureId));
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return Container(
      color: AppColors.base,
      child: relationsAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (relations) => contextsAsync.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (contexts) {
            if (contexts.isEmpty) {
              return _EmptyMatrixHint(featureId: featureId);
            }
            return InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(200),
              minScale: 0.25,
              maxScale: 4,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: HarrisMatrixPainter(
                    contexts: contexts,
                    relations: relations,
                    theme: Theme.of(context),
                  ),
                  size: _canvasSize(contexts),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Size _canvasSize(List<ContextModel> contexts) {
    const nodesPerRow = 4;
    final rows = (contexts.length / nodesPerRow).ceil().clamp(1, 999);
    return Size(nodesPerRow * 160.0 + 128, rows * 120.0 + 128);
  }
}

class _EmptyMatrixHint extends StatelessWidget {
  const _EmptyMatrixHint({required this.featureId});
  final String featureId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.s2,
              borderRadius: AppRadius.lgBorderRadius,
            ),
            child: const Icon(Icons.account_tree_outlined,
                size: 28, color: AppColors.t2),
          ),
          const SizedBox(height: AppSpacing.space16),
          Text(
            'No stratigraphy yet',
            style: TextStyle(
              fontFamily: AppTypography.monoFontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.t1,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Add a context below to start\nbuilding the Harris Matrix.',
            style: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontSize: 12,
              color: AppColors.t2,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Context strip ──────────────────────────────────────────────────────────────

class _ContextStrip extends ConsumerWidget {
  const _ContextStrip({required this.featureId});
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return Container(
      color: AppColors.s0,
      child: contextsAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (contexts) {
          if (contexts.isEmpty) {
            return Center(
              child: Text(
                'No contexts — tap + below to add one',
                style: TextStyle(
                  fontFamily: AppTypography.sansFontFamily,
                  fontSize: 12,
                  color: AppColors.t2,
                ),
              ),
            );
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: 10,
            ),
            itemCount: contexts.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: AppSpacing.space8),
            itemBuilder: (context, index) => _ContextStripCard(
              context_: contexts[index],
              featureId: featureId,
            ),
          );
        },
      ),
    );
  }
}

class _ContextStripCard extends StatelessWidget {
  const _ContextStripCard({
    required this.context_,
    required this.featureId,
  });

  final ContextModel context_;
  final String featureId;

  @override
  Widget build(BuildContext context) {
    final isCut = context_ is CutModel;
    final accentColor = isCut ? AppColors.cut : AppColors.fill;
    final surfaceColor = isCut ? AppColors.cutSurface : AppColors.fillSurface;
    final textColor = isCut ? AppColors.cutText : AppColors.fillText;
    final typeLabel = isCut ? 'CUT' : 'FILL';
    final num = context_.contextNumber.toString().padLeft(3, '0');

    return GestureDetector(
      onTap: () =>
          context.push('/features/$featureId/contexts/${context_.id}'),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.s1,
          borderRadius: AppRadius.mdBorderRadius,
          border: Border(
            left: BorderSide(color: accentColor, width: AppBorder.accentStripe),
            top: const BorderSide(color: AppColors.rule, width: 1),
            right: const BorderSide(color: AppColors.rule, width: 1),
            bottom: const BorderSide(color: AppColors.rule, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space6, vertical: AppSpacing.space2),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: AppRadius.xsBorderRadius,
                ),
                child: Text(
                  typeLabel,
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                    letterSpacing: 1.5,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space6),
              Text(
                num,
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  letterSpacing: -0.5,
                  height: 1,
                  color: AppColors.t0,
                ),
              ),
              const Spacer(),
              Text(
                'view →',
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontSize: 9,
                  color: AppColors.t2,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Workbench action row ───────────────────────────────────────────────────────

class _WorkbenchActionRow extends ConsumerWidget {
  const _WorkbenchActionRow({required this.featureId});
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.s1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, color: AppColors.rule),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space16,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.layers_rounded,
                      label: 'Context',
                      color: AppColors.cut,
                      onTap: () => _addContext(context, ref),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.add_link_rounded,
                      label: 'Relation',
                      color: AppColors.primary,
                      onTap: () => _addRelation(context, ref),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.more_horiz_rounded,
                      label: 'More',
                      color: AppColors.t2,
                      onTap: () => _showMore(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addContext(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ContextFormSheet(
        featureId: featureId,
        onSaved: () {
          ref.invalidate(contextsByFeatureProvider(featureId));
        },
      ),
    );
  }

  void _addRelation(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => RelationFormSheet(
        featureId: featureId,
        onSaved: () {
          ref.invalidate(harrisByFeatureProvider(featureId));
        },
      ),
    );
  }

  void _showMore(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _MoreActionsSheet(featureId: featureId),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.smBorderRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.s2,
          borderRadius: AppRadius.smBorderRadius,
          border: Border.all(color: AppColors.ruleMid, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: AppSpacing.space4),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppTypography.sansFontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: AppColors.t1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreActionsSheet extends StatelessWidget {
  const _MoreActionsSheet({required this.featureId});
  final String featureId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.space8),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space20),
            child: Row(
              children: [
                Text(
                  'Add evidence',
                  style: TextStyle(
                    fontFamily: AppTypography.sansFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.t0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Photos'),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (_) => _FullViewSheet(
                  title: 'Photos',
                  child: PhotoListTab(featureId: featureId),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.draw_outlined),
            title: const Text('Drawings'),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (_) => _FullViewSheet(
                  title: 'Drawings',
                  child: DrawingListTab(featureId: featureId),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.space8),
        ],
      ),
    );
  }
}

// ── Loading skeleton ───────────────────────────────────────────────────────────

class _WorkbenchSkeleton extends StatelessWidget {
  const _WorkbenchSkeleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.base,
      body: Column(
        children: [
          Container(color: AppColors.s0, height: 80),
          const SizedBox(height: 1),
          Expanded(child: Container(color: AppColors.base)),
          Container(color: AppColors.s0, height: 160),
        ],
      ),
    );
  }
}
