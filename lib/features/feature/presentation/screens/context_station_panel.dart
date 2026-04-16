import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/constants/enums.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../../context/presentation/widgets/context_form_sheet.dart';
import '../providers/feature_providers.dart';
import '../../../find/domain/models/find_model.dart';
import '../../../find/presentation/providers/find_providers.dart';
import '../../../find/presentation/widgets/find_form_sheet.dart';
import '../../../photo/presentation/providers/photo_providers.dart';
import '../../../photo/presentation/widgets/photo_form_sheet.dart';
import '../../../sample/presentation/providers/sample_providers.dart';
import '../../../sample/presentation/widgets/sample_form_sheet.dart';

/// Context Station Panel — a draggable overlay showing context detail.
///
/// This is the core navigation change from the previous design:
/// - Previously: tapping a context pushed to ContextFocusScreen (new page)
/// - Now: tapping a context opens this DraggableScrollableSheet overlay
///   over the Excavation Station, without leaving the station.
///
/// This means the Harris Matrix stays visible beneath the panel.
/// The user can see their stratigraphic context at all times.
///
/// The panel has two heights:
/// - Collapsed (45%): shows type badge + number + key properties + evidence counts
/// - Expanded (88%): shows full detail + evidence list + quick-add actions
class ContextStationPanel extends ConsumerWidget {
  const ContextStationPanel({
    super.key,
    required this.featureId,
    required this.contextId,
    required this.onDismiss,
    required this.onNavigateToDetail,
  });

  final String featureId;
  final String contextId;
  final VoidCallback onDismiss;
  final void Function(String featureId, String contextId) onNavigateToDetail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return contextsAsync.when(
      loading: () => _PanelSkeleton(),
      error: (e, _) => _PanelError(message: e.toString()),
      data: (contexts) {
        final ctx = contexts.where((c) => c.id == contextId).firstOrNull;
        if (ctx == null) return _PanelError(message: 'Context not found');

        final featureType = ref
                .read(featureDetailProvider(featureId))
                .valueOrNull
                ?.featureType ??
            FeatureType.standard;

        return switch (ctx) {
          final CutModel cut => _CutPanel(
              cut: cut,
              featureId: featureId,
              featureType: featureType,
              allContexts: contexts,
              onNavigateToDetail: onNavigateToDetail,
              ref: ref,
            ),
          final FillModel fill => _FillPanel(
              fill: fill,
              featureId: featureId,
              featureType: featureType,
              onNavigateToDetail: onNavigateToDetail,
              ref: ref,
            ),
        };
      },
    );
  }
}

// ── Shared panel shell ────────────────────────────────────────────────────────

class _PanelShell extends StatelessWidget {
  const _PanelShell({
    required this.typeLabel,
    required this.number,
    required this.accentColor,
    required this.textColor,
    required this.surfaceColor,
    required this.featureId,
    required this.featureType,
    required this.contextModel,
    required this.onNavigateToDetail,
    required this.ref,
    required this.body,
    this.actionBar,
  });

  final String typeLabel;
  final int number;
  final Color accentColor;
  final Color textColor;
  final Color surfaceColor;
  final String featureId;
  final FeatureType featureType;
  final ContextModel contextModel;
  final void Function(String, String) onNavigateToDetail;
  final WidgetRef ref;
  final Widget body;
  final Widget? actionBar;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.48,
      minChildSize: 0.3,
      maxChildSize: 0.88,
      snap: true,
      snapSizes: const [0.48, 0.88],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.s1,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
            border: Border(
              top: BorderSide(color: colors.ruleMid, width: 1),
              left: BorderSide(color: colors.ruleMid, width: 1),
              right: BorderSide(color: colors.ruleMid, width: 1),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 6),
                  width: 36,
                  height: 3,
                  decoration: BoxDecoration(
                    color: colors.ruleStrong,
                    borderRadius: AppRadius.fullBorderRadius,
                  ),
                ),
              ),

              // Panel header
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.space16,
                  AppSpacing.space4,
                  AppSpacing.space8,
                  AppSpacing.space12,
                ),
                child: Row(
                  children: [
                    // Type badge + number
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.space12,
                        AppSpacing.space8,
                        AppSpacing.space12,
                        AppSpacing.space8,
                      ),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: AppRadius.smBorderRadius,
                        border: Border(
                          left: BorderSide(color: accentColor, width: AppBorder.accentStripe),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            typeLabel,
                            style: TextStyle(
                              fontFamily: AppTypography.monoFontFamily,
                              fontWeight: FontWeight.w800,
                              fontSize: 8,
                              letterSpacing: 2.0,
                              color: accentColor,
                            ),
                          ),
                          Text(
                            number.toString().padLeft(3, '0'),
                            style: TextStyle(
                              fontFamily: AppTypography.monoFontFamily,
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                              letterSpacing: -2,
                              height: 1,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Edit + expand
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          color: colors.t1,
                          tooltip: 'Edit context',
                          onPressed: () => _editContext(context, ref),
                        ),
                        IconButton(
                          icon: const Icon(Icons.open_in_full_rounded, size: 16),
                          color: colors.t1,
                          tooltip: 'Full detail view',
                          onPressed: () {
                            Navigator.pop(context);
                            onNavigateToDetail(featureId, contextModel.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(height: 1, color: colors.rule),

              // Scrollable body
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.space80,
                  ),
                  children: [body],
                ),
              ),

              // Action bar (pinned at bottom)
              if (actionBar != null) ...[
                Container(height: 1, color: colors.rule),
                actionBar!,
              ],
            ],
          ),
        );
      },
    );
  }

  void _editContext(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ContextFormSheet(
        featureId: featureId,
        featureType: featureType,
        existingContext: contextModel,
        onSaved: () {
          ref.invalidate(contextsByFeatureProvider(featureId));
          ref.invalidate(cutsByFeatureProvider(featureId));
          ref.invalidate(fillsByFeatureProvider(featureId));
        },
      ),
    );
  }
}

// ── Cut panel ─────────────────────────────────────────────────────────────────

class _CutPanel extends StatelessWidget {
  const _CutPanel({
    required this.cut,
    required this.featureId,
    required this.featureType,
    required this.allContexts,
    required this.onNavigateToDetail,
    required this.ref,
  });

  final CutModel cut;
  final String featureId;
  final FeatureType featureType;
  final List<ContextModel> allContexts;
  final void Function(String, String) onNavigateToDetail;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final fills = allContexts
        .whereType<FillModel>()
        .where((f) => f.parentCutId == cut.id)
        .toList();

    return _PanelShell(
      typeLabel: 'CUT',
      number: cut.contextNumber,
      accentColor: colors.cut,
      textColor: colors.cutText,
      surfaceColor: colors.cutSurface,
      featureId: featureId,
      featureType: featureType,
      contextModel: cut,
      onNavigateToDetail: onNavigateToDetail,
      ref: ref,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PropertiesBlock(rows: [
            if (cut.cutType != null) _PropEntry('Type', cut.cutType!.displayName),
            if (cut.height != null) _PropEntry('Longitude', '${cut.height!.toStringAsFixed(2)} m'),
            if (cut.width != null) _PropEntry('Width', '${cut.width!.toStringAsFixed(2)} m'),
            if (cut.depth != null) _PropEntry('Depth', '${cut.depth!.toStringAsFixed(2)} m'),
            if (cut.notes != null) _PropEntry('Notes', cut.notes!),
          ]),
          _SectionLabel(label: 'FILLS', count: fills.length),
          if (fills.isEmpty)
            const _EmptyHint(message: 'No fills reference this cut.')
          else
            Column(
              children: fills
                  .map((f) => _FillChip(fill: f, featureId: featureId))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

// ── Fill panel ────────────────────────────────────────────────────────────────

class _FillPanel extends ConsumerWidget {
  const _FillPanel({
    required this.fill,
    required this.featureId,
    required this.featureType,
    required this.onNavigateToDetail,
    required this.ref,
  });

  final FillModel fill;
  final String featureId;
  final FeatureType featureType;
  final void Function(String, String) onNavigateToDetail;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef consumerRef) {
    final colors = AppColors.of(context);
    final findsAsync = consumerRef.watch(findsByFeatureProvider(featureId));
    final samplesAsync = consumerRef.watch(samplesByFeatureProvider(featureId));
    final photosAsync = consumerRef.watch(photosByFeatureProvider(featureId));

    final fillFinds = findsAsync.when(
      data: (all) => all.where((f) => f.fillId == fill.id).toList(),
      loading: () => <FindModel>[],
      error: (_, __) => <FindModel>[],
    );

    final sampleCount = samplesAsync.when(
      data: (all) => all.where((s) => s.fillId == fill.id).length,
      loading: () => 0,
      error: (_, __) => 0,
    );

    final photoCount = photosAsync.when(
      data: (all) => all.length,
      loading: () => 0,
      error: (_, __) => 0,
    );

    return _PanelShell(
      typeLabel: 'FILL',
      number: fill.contextNumber,
      accentColor: colors.fill,
      textColor: colors.fillText,
      surfaceColor: colors.fillSurface,
      featureId: featureId,
      featureType: featureType,
      contextModel: fill,
      onNavigateToDetail: onNavigateToDetail,
      ref: ref,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Evidence count chips
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space12,
              AppSpacing.space16,
              AppSpacing.space4,
            ),
            child: Wrap(
              spacing: AppSpacing.space8,
              runSpacing: AppSpacing.space6,
              children: [
                _EvidenceChip(
                  icon: Icons.category_outlined,
                  count: fillFinds.length,
                  label: 'finds',
                  color: colors.find,
                  surface: colors.findSurface,
                  textColor: colors.findText,
                ),
                _EvidenceChip(
                  icon: Icons.science_outlined,
                  count: sampleCount,
                  label: 'samples',
                  color: colors.sample,
                  surface: colors.sampleSurface,
                  textColor: colors.sampleText,
                ),
                _EvidenceChip(
                  icon: Icons.photo_outlined,
                  count: photoCount,
                  label: 'photos',
                  color: colors.doc,
                  surface: colors.docSurface,
                  textColor: colors.docText,
                ),
              ],
            ),
          ),

          _PropertiesBlock(rows: [
            if (fill.composition != null) _PropEntry('Composition', fill.composition!.displayName),
            if (fill.color != null) _PropEntry('Color', fill.color!),
            if (fill.compaction != null) _PropEntry('Compaction', fill.compaction!.displayName),
            if (fill.inclusions != null) _PropEntry('Inclusions', fill.inclusions!),
            if (fill.notes != null) _PropEntry('Notes', fill.notes!),
          ]),

          _SectionLabel(label: 'FINDS', count: fillFinds.length),
          if (fillFinds.isEmpty)
            const _EmptyHint(message: 'No finds recorded for this fill.')
          else
            Column(
              children: fillFinds.map(_FindChip.new).toList(),
            ),
        ],
      ),
      actionBar: _FillActionBar(
        fill: fill,
        featureId: featureId,
        consumerRef: consumerRef,
      ),
    );
  }
}

// ── Panel sub-components ──────────────────────────────────────────────────────

class _PropertiesBlock extends StatelessWidget {
  const _PropertiesBlock({required this.rows});
  final List<_PropEntry> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < rows.length; i++) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              10.0,
              AppSpacing.space16,
              10.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 88,
                  child: Text(
                    rows[i].label,
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: colors.t2,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                Expanded(
                  child: Text(
                    rows[i].value,
                    style: TextStyle(
                      fontFamily: AppTypography.sansFontFamily,
                      fontSize: 13,
                      color: colors.t0,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (i < rows.length - 1)
            Container(
              height: 1,
              color: colors.rule,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
            ),
        ],
      ],
    );
  }
}

class _PropEntry {
  const _PropEntry(this.label, this.value);
  final String label;
  final String value;
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.count});
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space8,
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
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
          const SizedBox(width: AppSpacing.space12),
          Expanded(child: Divider(height: 1, color: colors.ruleMid)),
        ],
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space8,
        AppSpacing.space16,
        AppSpacing.space16,
      ),
      child: Text(
        message,
        style: TextStyle(
          fontFamily: AppTypography.sansFontFamily,
          fontSize: 12,
          color: colors.t2,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class _FillChip extends StatelessWidget {
  const _FillChip({required this.fill, required this.featureId});
  final FillModel fill;
  final String featureId;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        10.0,
        AppSpacing.space16,
        10.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colors.rule, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 28,
            color: colors.fill,
            margin: const EdgeInsets.only(right: 10.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fill ${fill.contextNumber.toString().padLeft(3, '0')}',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: colors.fillText,
                  ),
                ),
                if (fill.composition != null)
                  Text(
                    fill.composition!.displayName,
                    style: TextStyle(
                      fontFamily: AppTypography.sansFontFamily,
                      fontSize: 11,
                      color: colors.t1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FindChip extends StatelessWidget {
  const _FindChip(this.find);
  final FindModel find;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        10.0,
        AppSpacing.space16,
        10.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colors.rule, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 28,
            color: colors.find,
            margin: const EdgeInsets.only(right: 10.0),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  find.findNumber.toString().padLeft(3, '0'),
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: colors.findText,
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Text(
                  find.materialType.displayName,
                  style: TextStyle(
                    fontFamily: AppTypography.sansFontFamily,
                    fontSize: 13,
                    color: colors.t0,
                  ),
                ),
                const Spacer(),
                Text(
                  '×${find.quantity}',
                  style: TextStyle(
                    fontFamily: AppTypography.monoFontFamily,
                    fontSize: 11,
                    color: colors.t2,
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

class _EvidenceChip extends StatelessWidget {
  const _EvidenceChip({
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
    required this.surface,
    required this.textColor,
  });

  final IconData icon;
  final int count;
  final String label;
  final Color color;
  final Color surface;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppRadius.xsBorderRadius,
        border: Border.all(color: color.withAlpha(60), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            '$count $label',
            style: TextStyle(
              fontFamily: AppTypography.monoFontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Fill action bar ────────────────────────────────────────────────────────────

class _FillActionBar extends StatelessWidget {
  const _FillActionBar({
    required this.fill,
    required this.featureId,
    required this.consumerRef,
  });

  final FillModel fill;
  final String featureId;
  final WidgetRef consumerRef;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return SafeArea(
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
            Expanded(
              child: _QuickAddButton(
                icon: Icons.category_outlined,
                label: 'FIND',
                color: colors.find,
                onTap: () => _addFind(context),
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: _QuickAddButton(
                icon: Icons.science_outlined,
                label: 'SAMPLE',
                color: colors.sample,
                onTap: () => _addSample(context),
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Expanded(
              child: _QuickAddButton(
                icon: Icons.photo_camera_outlined,
                label: 'PHOTO',
                color: colors.doc,
                onTap: () => _addPhoto(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addFind(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => FindFormSheet(
        featureId: featureId,
        onSaved: () => consumerRef.invalidate(findsByFeatureProvider(featureId)),
      ),
    );
  }

  void _addSample(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => SampleFormSheet(
        featureId: featureId,
        onSaved: () => consumerRef.invalidate(samplesByFeatureProvider(featureId)),
      ),
    );
  }

  void _addPhoto(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => PhotoFormSheet(
        featureId: featureId,
        onSaved: () => consumerRef.invalidate(photosByFeatureProvider(featureId)),
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  const _QuickAddButton({
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
    return Material(
      color: color.withAlpha(18),
      borderRadius: AppRadius.smBorderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.smBorderRadius,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: AppRadius.smBorderRadius,
            border: Border.all(color: color.withAlpha(60), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_rounded, size: 8, color: color.withAlpha(200)),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 8,
                      letterSpacing: 1.2,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Skeleton / error ──────────────────────────────────────────────────────────

class _PanelSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.48,
      minChildSize: 0.3,
      maxChildSize: 0.88,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          color: colors.s1,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        child: Center(
          child: CircularProgressIndicator(color: colors.primary, strokeWidth: 2),
        ),
      ),
    );
  }
}

class _PanelError extends StatelessWidget {
  const _PanelError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.5,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          color: colors.s1,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              fontFamily: AppTypography.monoFontFamily,
              color: colors.error,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
