import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../../context/presentation/widgets/context_form_sheet.dart';
import '../../../project/presentation/providers/project_providers.dart';
import '../../../harris_matrix/domain/models/harris_relation_model.dart';
import '../../../harris_matrix/presentation/providers/harris_providers.dart';
import '../../../harris_matrix/presentation/widgets/harris_interactive_matrix.dart';
import '../../../harris_matrix/presentation/widgets/relation_form_sheet.dart';
import '../providers/feature_providers.dart';
import 'context_station_panel.dart';

/// Excavation Station — the primary workspace for a feature.
class FeatureDetailScreen extends ConsumerStatefulWidget {
  const FeatureDetailScreen({super.key, required this.featureId});

  final String featureId;

  @override
  ConsumerState<FeatureDetailScreen> createState() =>
      _FeatureDetailScreenState();
}

class _FeatureDetailScreenState extends ConsumerState<FeatureDetailScreen> {
  String? _selectedContextId;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final featureAsync = ref.watch(featureDetailProvider(widget.featureId));

    return featureAsync.when(
      loading: () => const _StationSkeleton(),
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
          backgroundColor: colors.base,
          body: Column(
            children: [
              _StationHeader(
                featureNumber: feature.featureNumber,
                area: feature.area,
                featureId: widget.featureId,
                projectId: feature.projectId,
              ),
              Container(height: 1, color: colors.rule),
              Expanded(
                child: _StationBody(
                  featureId: widget.featureId,
                  selectedContextId: _selectedContextId,
                  onContextSelected: _openContextPanel,
                ),
              ),
              Container(height: 1, color: colors.rule),
              _ActionDock(
                featureId: widget.featureId,
                onContextAdded: () {
                  ref.invalidate(contextsByFeatureProvider(widget.featureId));
                  ref.invalidate(cutsByFeatureProvider(widget.featureId));
                  ref.invalidate(fillsByFeatureProvider(widget.featureId));
                  ref.invalidate(harrisByFeatureProvider(widget.featureId));
                },
                onRelationAdded: () {
                  ref.invalidate(harrisByFeatureProvider(widget.featureId));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openContextPanel(String contextId) {
    setState(() => _selectedContextId = contextId);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withAlpha(120),
      builder: (ctx) => ContextStationPanel(
        featureId: widget.featureId,
        contextId: contextId,
        onDismiss: () {
          setState(() => _selectedContextId = null);
        },
        onNavigateToDetail: (fId, cId) {
          setState(() => _selectedContextId = null);
          context.push('/features/$fId/contexts/$cId');
        },
      ),
    ).then((_) {
      if (mounted) setState(() => _selectedContextId = null);
    });
  }
}

// ── Station header ─────────────────────────────────────────────────────────────

class _StationHeader extends ConsumerWidget {
  const _StationHeader({
    required this.featureNumber,
    required this.area,
    required this.featureId,
    this.projectId,
  });

  final String featureNumber;
  final String? area;
  final String featureId;
  final String? projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final projectAsync = projectId != null
        ? ref.watch(projectDetailProvider(projectId!))
        : null;
    final project = projectAsync?.valueOrNull;

    String? projectLine;
    if (project != null) {
      final parts = [
        if (project.rubiconCode != null && project.rubiconCode!.isNotEmpty)
          project.rubiconCode!,
        if (project.licenceNumber != null && project.licenceNumber!.isNotEmpty)
          project.licenceNumber!,
      ];
      projectLine = parts.isNotEmpty ? parts.join(' · ') : project.name;
    }

    return Container(
      color: colors.s0,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, size: 20),
                color: colors.t1,
                onPressed: () => context.pop(),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space12),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      area != null ? 'Area $area' : '—',
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 8,
                        letterSpacing: 2.0,
                        color: colors.t2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      project != null
                          ? project.name.toUpperCase()
                          : 'EXCAVATION STATION',
                      style: TextStyle(
                        fontFamily: AppTypography.sansFontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: -0.3,
                        height: 1.1,
                        color: area != null ? colors.t0 : colors.t2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (projectLine != null) ...[
                      const SizedBox(height: 1),
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
              IconButton(
                icon: const Icon(Icons.open_in_full_rounded, size: 18),
                color: colors.t1,
                tooltip: 'Expand matrix',
                onPressed: () => context.push('/features/$featureId/matrix'),
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                color: colors.t1,
                tooltip: 'Edit feature',
                onPressed: () => context.push('/features/$featureId/edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Station body ───────────────────────────────────────────────────────────────

class _StationBody extends ConsumerWidget {
  const _StationBody({
    required this.featureId,
    required this.selectedContextId,
    required this.onContextSelected,
  });

  final String featureId;
  final String? selectedContextId;
  final void Function(String contextId) onContextSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final relationsAsync = ref.watch(harrisByFeatureProvider(featureId));
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return relationsAsync.when(
      loading: () => Center(
        child: CircularProgressIndicator(color: colors.primary, strokeWidth: 2),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (relations) => contextsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: colors.primary, strokeWidth: 2),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (contexts) => Column(
          children: [
            // ── Stratigraphy zone ──────────────────────────────────────────
            Expanded(
              flex: 56,
              child: _StratigraphyZone(
                featureId: featureId,
                contexts: contexts,
                relations: relations,
                selectedContextId: selectedContextId,
                onNodeTap: onContextSelected,
              ),
            ),

            // ── Zone separator with context count ──────────────────────────
            _ZoneSeparator(
              label: 'CONTEXTS',
              count: contexts.length,
              featureId: featureId,
            ),

            // ── Context manifest ───────────────────────────────────────────
            Expanded(
              flex: 44,
              child: _ContextManifest(
                featureId: featureId,
                contexts: contexts,
                selectedContextId: selectedContextId,
                onContextTap: onContextSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stratigraphy zone ─────────────────────────────────────────────────────────

class _StratigraphyZone extends StatelessWidget {
  const _StratigraphyZone({
    required this.featureId,
    required this.contexts,
    required this.relations,
    required this.selectedContextId,
    required this.onNodeTap,
  });

  final String featureId;
  final List<ContextModel> contexts;
  final List<HarrisRelationModel> relations;
  final String? selectedContextId;
  final void Function(String) onNodeTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (contexts.isEmpty) {
      return _EmptyMatrixHint();
    }

    return Container(
      color: colors.base,
      child: HarrisInteractiveMatrix(
        contexts: contexts,
        relations: relations,
        selectedContextId: selectedContextId,
        onNodeTap: onNodeTap,
      ),
    );
  }
}

class _EmptyMatrixHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      color: colors.base,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.s1,
                borderRadius: AppRadius.smBorderRadius,
                border: Border.all(color: colors.ruleMid, width: 1),
              ),
              child: Icon(
                Icons.account_tree_outlined,
                size: 22,
                color: colors.t2,
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            Text(
              'NO STRATIGRAPHY',
              style: TextStyle(
                fontFamily: AppTypography.monoFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                letterSpacing: 2.0,
                color: colors.t2,
              ),
            ),
            const SizedBox(height: AppSpacing.space6),
            Text(
              'Add a context below to begin recording.',
              style: TextStyle(
                fontFamily: AppTypography.sansFontFamily,
                fontSize: 12,
                color: colors.t2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Zone separator ─────────────────────────────────────────────────────────────

class _ZoneSeparator extends StatelessWidget {
  const _ZoneSeparator({
    required this.label,
    required this.count,
    required this.featureId,
  });

  final String label;
  final int count;
  final String featureId;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      height: 30,
      color: colors.s1,
      child: Row(
        children: [
          Container(
            width: 3,
            height: 30,
            color: colors.primary.withAlpha(60),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space12),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                    letterSpacing: 2.0,
                    color: colors.t2,
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: colors.s3,
                    borderRadius: AppRadius.xsBorderRadius,
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 9,
                      color: count > 0 ? colors.primary : colors.t2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(height: 1, color: colors.rule),
        ],
      ),
    );
  }
}

// ── Context manifest ──────────────────────────────────────────────────────────

class _ContextManifest extends StatelessWidget {
  const _ContextManifest({
    required this.featureId,
    required this.contexts,
    required this.selectedContextId,
    required this.onContextTap,
  });

  final String featureId;
  final List<ContextModel> contexts;
  final String? selectedContextId;
  final void Function(String) onContextTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (contexts.isEmpty) {
      return Container(
        color: colors.s0,
        child: Center(
          child: Text(
            'No contexts — use Add Context below',
            style: TextStyle(
              fontFamily: AppTypography.sansFontFamily,
              fontSize: 12,
              color: colors.t2,
            ),
          ),
        ),
      );
    }

    return Container(
      color: colors.s0,
      child: ListView.separated(
        itemCount: contexts.length,
        separatorBuilder: (_, __) => Container(
          height: 1,
          color: colors.rule,
        ),
        itemBuilder: (context, index) {
          final ctx = contexts[index];
          return _ContextManifestRow(
            context_: ctx,
            isSelected: selectedContextId == ctx.id,
            onTap: () => onContextTap(ctx.id),
          );
        },
      ),
    );
  }
}

class _ContextManifestRow extends StatefulWidget {
  const _ContextManifestRow({
    required this.context_,
    required this.isSelected,
    required this.onTap,
  });

  final ContextModel context_;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_ContextManifestRow> createState() => _ContextManifestRowState();
}

class _ContextManifestRowState extends State<_ContextManifestRow> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final ctx = widget.context_;
    final isCut = ctx is CutModel;
    final accentColor = isCut ? colors.cut : colors.fill;
    final textColor = isCut ? colors.cutText : colors.fillText;
    final surfaceColor = isCut ? colors.cutSurface : colors.fillSurface;
    final typeLabel = isCut ? 'CUT' : 'FILL';
    final num = ctx.contextNumber.toString().padLeft(3, '0');

    String? subtitle;
    if (ctx is CutModel && ctx.cutType != null) {
      subtitle = ctx.cutType!.displayName;
    } else if (ctx is FillModel && ctx.composition != null) {
      subtitle = ctx.composition!.displayName;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        color: widget.isSelected
            ? colors.primaryContainer.withAlpha(100)
            : _pressed
                ? colors.s2
                : colors.s0,
        padding: const EdgeInsets.fromLTRB(
          0,
          AppSpacing.space8,
          AppSpacing.space16,
          AppSpacing.space8,
        ),
        child: Row(
          children: [
            // ── Left accent bar ─────────────────────────────────────────
            Container(
              width: AppBorder.accentStripe,
              height: 36,
              margin: const EdgeInsets.only(right: AppSpacing.space12),
              color: widget.isSelected ? colors.primary : accentColor,
            ),

            // ── Type badge ──────────────────────────────────────────────
            Container(
              width: 40,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? colors.primaryContainer
                    : surfaceColor,
                borderRadius: AppRadius.xsBorderRadius,
              ),
              alignment: Alignment.center,
              child: Text(
                typeLabel,
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w800,
                  fontSize: 8,
                  letterSpacing: 1.5,
                  color: widget.isSelected ? colors.primary : textColor,
                ),
              ),
            ),

            const SizedBox(width: 10.0),

            // ── Number + subtitle ────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    num,
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: -0.3,
                      height: 1,
                      color: widget.isSelected
                          ? colors.primary
                          : colors.t0,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: AppTypography.sansFontFamily,
                        fontSize: 11,
                        color: colors.t1,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // ── Chevron ──────────────────────────────────────────────────
            Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: widget.isSelected ? colors.primary : colors.t2,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Action dock ───────────────────────────────────────────────────────────────

class _ActionDock extends ConsumerWidget {
  const _ActionDock({
    required this.featureId,
    required this.onContextAdded,
    required this.onRelationAdded,
  });

  final String featureId;
  final VoidCallback onContextAdded;
  final VoidCallback onRelationAdded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    return Container(
      color: colors.s1,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space12,
            10.0,
            AppSpacing.space12,
            10.0,
          ),
          child: Row(
            children: [
              // ── Primary: Add Context ──────────────────────────────────
              Expanded(
                flex: 3,
                child: FilledButton.icon(
                  onPressed: () => _addContext(context, ref),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(
                    'ADD CONTEXT',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.s0,
                    minimumSize: const Size(0, 44),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.smBorderRadius,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space12),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space8),

              // ── Secondary: Relation ───────────────────────────────────
              Expanded(
                flex: 2,
                child: _DockSecondaryButton(
                  icon: Icons.add_link_rounded,
                  label: 'RELATION',
                  onTap: () => _addRelation(context, ref),
                ),
              ),
              const SizedBox(width: AppSpacing.space8),

              // ── Secondary: Evidence ───────────────────────────────────
              Expanded(
                flex: 2,
                child: _DockSecondaryButton(
                  icon: Icons.folder_outlined,
                  label: 'EVIDENCE',
                  onTap: () => _showEvidence(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addContext(BuildContext context, WidgetRef ref) {
    final featureType = ref
            .read(featureDetailProvider(featureId))
            .valueOrNull
            ?.featureType ??
        FeatureType.standard;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ContextFormSheet(
        featureId: featureId,
        featureType: featureType,
        onSaved: onContextAdded,
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
        onSaved: onRelationAdded,
      ),
    );
  }

  void _showEvidence(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (_) => _EvidenceSheet(featureId: featureId),
    );
  }
}

class _DockSecondaryButton extends StatelessWidget {
  const _DockSecondaryButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Material(
      color: colors.s2,
      borderRadius: AppRadius.smBorderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.smBorderRadius,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: AppRadius.smBorderRadius,
            border: Border.all(color: colors.ruleMid, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: colors.t1),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 8,
                  letterSpacing: 1.2,
                  color: colors.t1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Evidence sheet ─────────────────────────────────────────────────────────────

class _EvidenceSheet extends StatelessWidget {
  const _EvidenceSheet({required this.featureId});
  final String featureId;

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
                  'EVIDENCE',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 2.0,
                    color: colors.t0,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18),
                  color: colors.t1,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Container(height: 1, color: colors.rule),
          _EvidenceTile(
            icon: Icons.photo_library_outlined,
            label: 'Photos',
            color: colors.doc,
            onTap: () {
              Navigator.pop(context);
              context.push('/features/$featureId/evidence/photos');
            },
          ),
          Container(height: 1, color: colors.rule),
          _EvidenceTile(
            icon: Icons.draw_outlined,
            label: 'Drawings',
            color: colors.doc,
            onTap: () {
              Navigator.pop(context);
              context.push('/features/$featureId/evidence/drawings');
            },
          ),
          Container(height: 1, color: colors.rule),
          _EvidenceTile(
            icon: Icons.category_outlined,
            label: 'All Finds',
            color: colors.find,
            onTap: () {
              Navigator.pop(context);
              context.push('/features/$featureId/evidence/finds');
            },
          ),
          Container(height: 1, color: colors.rule),
          _EvidenceTile(
            icon: Icons.science_outlined,
            label: 'All Samples',
            color: colors.sample,
            onTap: () {
              Navigator.pop(context);
              context.push('/features/$featureId/evidence/samples');
            },
          ),
          const SizedBox(height: AppSpacing.space16),
        ],
      ),
    );
  }
}

class _EvidenceTile extends StatelessWidget {
  const _EvidenceTile({
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
    final colors = AppColors.of(context);
    return ListTile(
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: AppRadius.xsBorderRadius,
        ),
        child: Icon(icon, size: 16, color: color),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: AppTypography.sansFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: colors.t0,
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, size: 16, color: colors.t2),
      onTap: onTap,
    );
  }
}

// ── Loading skeleton ───────────────────────────────────────────────────────────

class _StationSkeleton extends StatelessWidget {
  const _StationSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.base,
      body: Column(
        children: [
          Container(color: colors.s0, height: 60),
          Container(height: 1, color: colors.rule),
          Expanded(child: Container(color: colors.base)),
          Container(height: 1, color: colors.rule),
          Container(color: colors.s1, height: 64),
        ],
      ),
    );
  }
}
