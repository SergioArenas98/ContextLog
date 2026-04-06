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

/// Context Focus Screen — context as a first-class navigatable destination.
///
/// Structural change: contexts were list rows inside tab #1 of the feature detail.
/// Now: tapping a context from the workbench strip opens a dedicated screen.
///
/// For Fill contexts: shows properties + all finds linked to this fill.
/// For Cut contexts: shows properties + all child fills.
///
/// The evidence (finds) can be added directly from this screen,
/// making the fill/context the organizational hub for evidence rather than
/// having finds floating in a parallel tab list.
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

// ── Cut focus ─────────────────────────────────────────────────────────────────

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
    final fills = allContexts
        .whereType<FillModel>()
        .where((f) => f.parentCutId == cut.id)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.base,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _ContextHeader(
              typeLabel: 'CUT',
              accentColor: AppColors.cut,
              textColor: AppColors.cutText,
              surfaceColor: AppColors.cutSurface,
              number: cut.contextNumber,
              featureId: featureId,
              context_: cut,
            ),
          ),
          SliverToBoxAdapter(
            child: _PropertiesSection(
              title: 'Excavation Properties',
              rows: [
                if (cut.cutType != null)
                  _PropRow('Type', cut.cutType!.displayName),
                if (cut.height != null)
                  _PropRow('Height', '${cut.height!.toStringAsFixed(2)} m'),
                if (cut.width != null)
                  _PropRow('Width', '${cut.width!.toStringAsFixed(2)} m'),
                if (cut.depth != null)
                  _PropRow('Depth', '${cut.depth!.toStringAsFixed(2)} m'),
                if (cut.notes != null) _PropRow('Notes', cut.notes!),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _SectionDivider(label: 'FILLS (${fills.length})'),
          ),
          if (fills.isEmpty)
            const SliverToBoxAdapter(
              child: _EmptySection(
                message:
                    'No fills recorded for this cut.\nFills must reference this cut as parent.',
              ),
            )
          else
            SliverList.separated(
              itemCount: fills.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                indent: AppSpacing.space16,
                endIndent: AppSpacing.space16,
                color: AppColors.rule,
              ),
              itemBuilder: (context, index) =>
                  _FillRow(fill: fills[index], featureId: featureId),
            ),
          const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.space80)),
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
    return ListTile(
      onTap: () =>
          context.push('/features/$featureId/contexts/${fill.id}'),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.fillSurface,
          borderRadius: AppRadius.smBorderRadius,
        ),
        alignment: Alignment.center,
        child: Text(
          fill.contextNumber.toString().padLeft(3, '0'),
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: AppColors.fillText,
          ),
        ),
      ),
      title: Text(
        'Fill ${fill.contextNumber.toString().padLeft(3, '0')}',
        style: TextStyle(
          fontFamily: AppTypography.monoFontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: AppColors.t0,
        ),
      ),
      subtitle: fill.composition != null
          ? Text(
              fill.composition!,
              style: TextStyle(fontSize: 12, color: AppColors.t1),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.t2,
        size: 20,
      ),
    );
  }
}

// ── Fill focus ─────────────────────────────────────────────────────────────────

class _FillFocusScaffold extends ConsumerWidget {
  const _FillFocusScaffold({
    required this.fill,
    required this.featureId,
  });

  final FillModel fill;
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final findsAsync = ref.watch(findsByFeatureProvider(featureId));

    return Scaffold(
      backgroundColor: AppColors.base,
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
                  accentColor: AppColors.fill,
                  textColor: AppColors.fillText,
                  surfaceColor: AppColors.fillSurface,
                  number: fill.contextNumber,
                  featureId: featureId,
                  context_: fill,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space16,
                    AppSpacing.space8,
                    AppSpacing.space16,
                    AppSpacing.space4,
                  ),
                  child: _StatsRow(findCount: fillFinds.length),
                ),
              ),
              SliverToBoxAdapter(
                child: _PropertiesSection(
                  title: 'Deposit Properties',
                  rows: [
                    if (fill.composition != null)
                      _PropRow('Composition', fill.composition!),
                    if (fill.color != null) _PropRow('Color', fill.color!),
                    if (fill.compaction != null)
                      _PropRow('Compaction', fill.compaction!),
                    if (fill.inclusions != null)
                      _PropRow('Inclusions', fill.inclusions!),
                    if (fill.notes != null) _PropRow('Notes', fill.notes!),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child:
                    _SectionDivider(label: 'FINDS (${fillFinds.length})'),
              ),
              if (fillFinds.isEmpty)
                const SliverToBoxAdapter(
                  child: _EmptySection(
                    message: 'No finds recorded for this fill.\nUse the button below to add one.',
                  ),
                )
              else
                SliverList.separated(
                  itemCount: fillFinds.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    indent: AppSpacing.space16,
                    endIndent: AppSpacing.space16,
                    color: AppColors.rule,
                  ),
                  itemBuilder: (context, index) =>
                      _FindRow(find: fillFinds[index]),
                ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.space80 + 80)),
            ],
          );
        },
      ),
      bottomNavigationBar: _FillActionBar(
        fill: fill,
        featureId: featureId,
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.findCount});
  final int findCount;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.space8,
      children: [
        _StatChip(
          icon: Icons.category_rounded,
          count: findCount,
          label: 'Finds',
          color: AppColors.find,
          surface: AppColors.findSurface,
          textColor: AppColors.findText,
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space12,
        vertical: AppSpacing.space8,
      ),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppRadius.smBorderRadius,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.space6),
          Text(
            '$count $label',
            style: TextStyle(
              fontFamily: AppTypography.monoFontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FindRow extends StatelessWidget {
  const _FindRow({required this.find});
  final FindModel find;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.findSurface,
          borderRadius: AppRadius.smBorderRadius,
        ),
        alignment: Alignment.center,
        child: Text(
          find.findNumber.toString().padLeft(3, '0'),
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: AppColors.findText,
          ),
        ),
      ),
      title: Text(
        find.materialType.displayName,
        style: TextStyle(
          fontFamily: AppTypography.sansFontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: AppColors.t0,
        ),
      ),
      subtitle: Text(
        'qty: ${find.quantity}',
        style: TextStyle(
          fontFamily: AppTypography.monoFontFamily,
          fontSize: 11,
          color: AppColors.t2,
        ),
      ),
    );
  }
}

// ── Fill action bar ────────────────────────────────────────────────────────────

class _FillActionBar extends ConsumerWidget {
  const _FillActionBar({required this.fill, required this.featureId});
  final FillModel fill;
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
                vertical: AppSpacing.space12,
              ),
              child: Row(
                children: [
                  _EvidenceButton(
                    icon: Icons.category_rounded,
                    label: 'Add Find',
                    color: AppColors.find,
                    onTap: () => _addFind(context, ref),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  _EvidenceButton(
                    icon: Icons.science_outlined,
                    label: 'Add Sample',
                    color: AppColors.doc,
                    onTap: () => _addSample(context, ref),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  _EvidenceButton(
                    icon: Icons.photo_camera_outlined,
                    label: 'Photo',
                    color: AppColors.doc,
                    onTap: () => _addPhoto(context, ref),
                  ),
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

class _EvidenceButton extends StatelessWidget {
  const _EvidenceButton({
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
    return Expanded(
      child: InkWell(
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
              Icon(icon, size: 18, color: color),
              const SizedBox(height: AppSpacing.space4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppTypography.sansFontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: AppColors.t1,
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
    return Container(
      color: AppColors.s0,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space4,
                AppSpacing.space4,
                AppSpacing.space8,
                0,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: AppColors.t1,
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      'Feature ${featureId.substring(0, 8)}…',
                      style: TextStyle(
                        fontFamily: AppTypography.monoFontFamily,
                        fontSize: 11,
                        color: AppColors.t2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_rounded, size: 20),
                    color: AppColors.t1,
                    tooltip: 'Edit context',
                    onPressed: () => _editContext(context, ref),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(
                AppSpacing.space16,
                AppSpacing.space8,
                AppSpacing.space16,
                AppSpacing.space16,
              ),
              padding: const EdgeInsets.all(AppSpacing.space16),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: AppRadius.mdBorderRadius,
                border: Border(
                  left: BorderSide(
                    color: accentColor,
                    width: AppBorder.accentStripeLg,
                  ),
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
                      fontSize: 10,
                      letterSpacing: 2.5,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    number.toString().padLeft(3, '0'),
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w800,
                      fontSize: 48,
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
        onSaved: () =>
            ref.invalidate(contextsByFeatureProvider(featureId)),
      ),
    );
  }
}

class _PropertiesSection extends StatelessWidget {
  const _PropertiesSection({required this.title, required this.rows});
  final String title;
  final List<_PropRow> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space16,
        AppSpacing.space16,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: AppTypography.monoFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 10,
              letterSpacing: 1.8,
              color: AppColors.t2,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.s1,
              borderRadius: AppRadius.mdBorderRadius,
              border: Border.all(color: AppColors.rule, width: 1),
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
                          width: 100,
                          child: Text(
                            rows[i].label,
                            style: TextStyle(
                              fontFamily: AppTypography.monoFontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: AppColors.t2,
                              letterSpacing: 0.3,
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
                              color: AppColors.t0,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < rows.length - 1)
                    const Divider(
                      height: 1,
                      indent: AppSpacing.space16,
                      endIndent: AppSpacing.space16,
                      color: AppColors.rule,
                    ),
                ],
              ],
            ),
          ),
        ],
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
              fontSize: 10,
              letterSpacing: 2.0,
              color: AppColors.t2,
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          const Expanded(child: Divider(height: 1, color: AppColors.ruleMid)),
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
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space32),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontFamily: AppTypography.sansFontFamily,
            fontSize: 12,
            color: AppColors.t2,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _FocusSkeleton extends StatelessWidget {
  const _FocusSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.base,
      body: Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
