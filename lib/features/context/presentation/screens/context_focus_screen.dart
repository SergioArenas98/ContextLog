import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../find/domain/models/find_model.dart';
import '../../../find/presentation/widgets/find_form_sheet.dart';
import '../../../find/presentation/providers/find_providers.dart';
import '../../../sample/presentation/widgets/sample_form_sheet.dart';
import '../../../sample/presentation/providers/sample_providers.dart';
import '../../../photo/presentation/widgets/photo_form_sheet.dart';
import '../../../photo/presentation/providers/photo_providers.dart';
import '../../domain/models/context_model.dart';
import '../providers/context_providers.dart';
import '../widgets/context_form_sheet.dart';

/// Context Detail Screen — full edit/detail view for a context.
class ContextFocusScreen extends ConsumerWidget {
  const ContextFocusScreen({
    super.key,
    required this.featureId,
    required this.contextId,
  });

  final String featureId;
  final String contextId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return contextsAsync.when(
      loading: () => const _FocusSkeleton(),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Context')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (contexts) {
        final ctx = contexts.where((c) => c.id == contextId).firstOrNull;

        if (ctx == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Context')),
            body: const Center(child: Text('Context not found')),
          );
        }

        return switch (ctx) {
          final CutModel cut => _CutFocusScaffold(
              cut: cut,
              featureId: featureId,
              allContexts: contexts,
            ),
          final FillModel fill => _FillFocusScaffold(
              fill: fill,
              featureId: featureId,
            ),
        };
      },
    );
  }
}

// ── Cut detail ────────────────────────────────────────────────────────────────

class _CutFocusScaffold extends StatelessWidget {
  const _CutFocusScaffold({
    required this.cut,
    required this.featureId,
    required this.allContexts,
  });

  final CutModel cut;
  final String featureId;
  final List<ContextModel> allContexts;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final fills = allContexts
        .whereType<FillModel>()
        .where((f) => f.parentCutId == cut.id)
        .toList();

    return Scaffold(
      backgroundColor: colors.s0,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _ContextHeader(
              typeLabel: 'CUT',
              accentColor: colors.cut,
              textColor: colors.cutText,
              surfaceColor: colors.cutSurface,
              number: cut.contextNumber,
              featureId: featureId,
              context_: cut,
            ),
          ),
          SliverToBoxAdapter(
            child: _PropertiesSection(rows: [
              if (cut.cutType != null)
                _PropRow('Type', cut.cutType!.displayName),
              if (cut.height != null)
                _PropRow('Height', '${cut.height!.toStringAsFixed(2)} m'),
              if (cut.width != null)
                _PropRow('Width', '${cut.width!.toStringAsFixed(2)} m'),
              if (cut.depth != null)
                _PropRow('Depth', '${cut.depth!.toStringAsFixed(2)} m'),
              if (cut.notes != null) _PropRow('Notes', cut.notes!),
            ]),
          ),
          SliverToBoxAdapter(
            child: _SectionDivider(label: 'FILLS (${fills.length})'),
          ),
          if (fills.isEmpty)
            const SliverToBoxAdapter(
              child: _EmptySection(
                message: 'No fills reference this cut.',
              ),
            )
          else
            SliverList.separated(
              itemCount: fills.length,
              separatorBuilder: (_, __) =>
                  Container(height: 1, color: colors.rule),
              itemBuilder: (context, index) =>
                  _FillRow(fill: fills[index], featureId: featureId),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.space80)),
        ],
      ),
    );
  }
}

class _FillRow extends StatelessWidget {
  const _FillRow({required this.fill, required this.featureId});
  final FillModel fill;
  final String featureId;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return InkWell(
      onTap: () => context.push('/features/$featureId/contexts/${fill.id}'),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          0,
          AppSpacing.space12,
          AppSpacing.space16,
          AppSpacing.space12,
        ),
        child: Row(
          children: [
            Container(
              width: AppBorder.accentStripe,
              height: 32,
              color: colors.fill,
              margin: const EdgeInsets.only(
                left: AppSpacing.space16,
                right: AppSpacing.space12,
              ),
            ),
            Container(
              width: 36,
              height: 28,
              decoration: BoxDecoration(
                color: colors.fillSurface,
                borderRadius: AppRadius.xsBorderRadius,
              ),
              alignment: Alignment.center,
              child: Text(
                fill.contextNumber.toString().padLeft(3, '0'),
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: colors.fillText,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.space12),
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
                      color: colors.t0,
                    ),
                  ),
                  if (fill.composition != null)
                    Text(
                      fill.composition!.displayName,
                      style: TextStyle(
                        fontFamily: AppTypography.sansFontFamily,
                        fontSize: 12,
                        color: colors.t1,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colors.t2,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Fill detail ────────────────────────────────────────────────────────────────

class _FillFocusScaffold extends ConsumerWidget {
  const _FillFocusScaffold({
    required this.fill,
    required this.featureId,
  });

  final FillModel fill;
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final findsAsync = ref.watch(findsByFeatureProvider(featureId));

    return Scaffold(
      backgroundColor: colors.s0,
      body: findsAsync.when(
        loading: () => const _FocusSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (allFinds) {
          final fillFinds =
              allFinds.where((f) => f.fillId == fill.id).toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ContextHeader(
                  typeLabel: 'FILL',
                  accentColor: colors.fill,
                  textColor: colors.fillText,
                  surfaceColor: colors.fillSurface,
                  number: fill.contextNumber,
                  featureId: featureId,
                  context_: fill,
                ),
              ),
              SliverToBoxAdapter(
                child: _PropertiesSection(rows: [
                  if (fill.composition != null)
                    _PropRow('Composition', fill.composition!.displayName),
                  if (fill.color != null) _PropRow('Color', fill.color!),
                  if (fill.compaction != null)
                    _PropRow('Compaction', fill.compaction!.displayName),
                  if (fill.inclusions != null)
                    _PropRow('Inclusions', fill.inclusions!),
                  if (fill.notes != null) _PropRow('Notes', fill.notes!),
                ]),
              ),
              SliverToBoxAdapter(
                child: _SectionDivider(label: 'FINDS (${fillFinds.length})'),
              ),
              if (fillFinds.isEmpty)
                const SliverToBoxAdapter(
                  child: _EmptySection(message: 'No finds for this fill.'),
                )
              else
                SliverList.separated(
                  itemCount: fillFinds.length,
                  separatorBuilder: (_, __) =>
                      Container(height: 1, color: colors.rule),
                  itemBuilder: (context, index) =>
                      _FindRow(find: fillFinds[index]),
                ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.space80 + 80)),
            ],
          );
        },
      ),
      bottomNavigationBar: _FillActionBar(fill: fill, featureId: featureId),
    );
  }
}

class _FindRow extends StatelessWidget {
  const _FindRow({required this.find});
  final FindModel find;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, AppSpacing.space16, 10.0),
      child: Row(
        children: [
          Container(
            width: AppBorder.accentStripe,
            height: 32,
            color: colors.find,
            margin: const EdgeInsets.only(
              left: AppSpacing.space16,
              right: AppSpacing.space12,
            ),
          ),
          Container(
            width: 36,
            height: 28,
            decoration: BoxDecoration(
              color: colors.findSurface,
              borderRadius: AppRadius.xsBorderRadius,
            ),
            alignment: Alignment.center,
            child: Text(
              find.findNumber.toString().padLeft(3, '0'),
              style: TextStyle(
                fontFamily: AppTypography.monoFontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: colors.findText,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  find.materialType.displayName,
                  style: TextStyle(
                    fontFamily: AppTypography.sansFontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: colors.t0,
                  ),
                ),
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

class _FillActionBar extends ConsumerWidget {
  const _FillActionBar({required this.fill, required this.featureId});
  final FillModel fill;
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    return Container(
      color: colors.s1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 1, color: colors.rule),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space12,
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  Expanded(child: _ActionButton(
                    icon: Icons.category_outlined,
                    label: 'FIND',
                    color: colors.find,
                    onTap: () => _addFind(context, ref),
                  )),
                  const SizedBox(width: AppSpacing.space8),
                  Expanded(child: _ActionButton(
                    icon: Icons.science_outlined,
                    label: 'SAMPLE',
                    color: colors.sample,
                    onTap: () => _addSample(context, ref),
                  )),
                  const SizedBox(width: AppSpacing.space8),
                  Expanded(child: _ActionButton(
                    icon: Icons.photo_camera_outlined,
                    label: 'PHOTO',
                    color: colors.doc,
                    onTap: () => _addPhoto(context, ref),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addFind(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => FindFormSheet(
        featureId: featureId,
        onSaved: () => ref.invalidate(findsByFeatureProvider(featureId)),
      ),
    );
  }

  void _addSample(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => SampleFormSheet(
        featureId: featureId,
        onSaved: () => ref.invalidate(samplesByFeatureProvider(featureId)),
      ),
    );
  }

  void _addPhoto(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => PhotoFormSheet(
        featureId: featureId,
        onSaved: () => ref.invalidate(photosByFeatureProvider(featureId)),
      ),
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
        ),
      ),
    );
  }
}

// ── Shared components ─────────────────────────────────────────────────────────

class _ContextHeader extends ConsumerWidget {
  const _ContextHeader({
    required this.typeLabel,
    required this.accentColor,
    required this.textColor,
    required this.surfaceColor,
    required this.number,
    required this.featureId,
    required this.context_,
  });

  final String typeLabel;
  final Color accentColor;
  final Color textColor;
  final Color surfaceColor;
  final int number;
  final String featureId;
  final ContextModel context_;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    return Container(
      color: colors.s0,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nav bar
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, size: 20),
                    color: colors.t1,
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      'CONTEXT DETAIL',
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontSize: 9,
                        letterSpacing: 1.8,
                        color: colors.t2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    color: colors.t1,
                    tooltip: 'Edit',
                    onPressed: () => _editContext(context, ref),
                  ),
                ],
              ),
            ),
            // Identity block
            Container(
              margin: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                0,
                AppSpacing.space16,
                AppSpacing.space16,
              ),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space12,
                10.0,
                AppSpacing.space12,
                AppSpacing.space12,
              ),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: AppRadius.smBorderRadius,
                border: Border(
                  left: BorderSide(color: accentColor, width: AppBorder.accentStripeLg),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    typeLabel,
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 9,
                      letterSpacing: 2.0,
                      color: accentColor,
                    ),
                  ),
                  Text(
                    number.toString().padLeft(3, '0'),
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 44,
                      letterSpacing: -3,
                      height: 1,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editContext(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ContextFormSheet(
        featureId: featureId,
        existingContext: context_,
        onSaved: () {
          ref.invalidate(contextsByFeatureProvider(featureId));
          ref.invalidate(cutsByFeatureProvider(featureId));
          ref.invalidate(fillsByFeatureProvider(featureId));
        },
      ),
    );
  }
}

class _PropertiesSection extends StatelessWidget {
  const _PropertiesSection({required this.rows});
  final List<_PropRow> rows;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (rows.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.s1,
          borderRadius: AppRadius.smBorderRadius,
          border: Border.all(color: colors.rule, width: 1),
        ),
        child: Column(
          children: [
            for (int i = 0; i < rows.length; i++) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                  vertical: AppSpacing.space12,
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
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          letterSpacing: 0.5,
                          color: colors.t2,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space12),
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space16),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PropRow {
  const _PropRow(this.label, this.value);
  final String label;
  final String value;
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space24,
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
          const SizedBox(width: AppSpacing.space12),
          Expanded(child: Divider(height: 1, color: colors.ruleMid)),
        ],
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space24),
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

class _FocusSkeleton extends StatelessWidget {
  const _FocusSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.s0,
      body: Center(
        child: CircularProgressIndicator(color: colors.primary, strokeWidth: 2),
      ),
    );
  }
}
