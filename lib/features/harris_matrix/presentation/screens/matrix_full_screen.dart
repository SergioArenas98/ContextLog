import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/app_colors.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/design/app_typography.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../providers/harris_providers.dart';
import '../widgets/harris_interactive_matrix.dart';
import '../widgets/relation_form_sheet.dart';

/// Full-screen Harris Matrix view.
class MatrixFullScreen extends ConsumerStatefulWidget {
  const MatrixFullScreen({super.key, required this.featureId});

  final String featureId;

  @override
  ConsumerState<MatrixFullScreen> createState() => _MatrixFullScreenState();
}

class _MatrixFullScreenState extends ConsumerState<MatrixFullScreen> {
  String? _selectedContextId;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final relationsAsync = ref.watch(harrisByFeatureProvider(widget.featureId));
    final contextsAsync = ref.watch(contextsByFeatureProvider(widget.featureId));

    return Scaffold(
      backgroundColor: colors.base,
      body: Column(
        children: [
          // ── Header ────────────────────────────────────────────────────
          _MatrixHeader(featureId: widget.featureId),
          Container(height: 1, color: colors.rule),

          // ── Canvas ────────────────────────────────────────────────────
          Expanded(
            child: relationsAsync.when(
              loading: () => Center(
                child: CircularProgressIndicator(
                    color: colors.primary, strokeWidth: 2),
              ),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (relations) => contextsAsync.when(
                loading: () => Center(
                  child: CircularProgressIndicator(
                      color: colors.primary, strokeWidth: 2),
                ),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (contexts) {
                  if (contexts.isEmpty) {
                    return EmptyStateWidget(
                      icon: Icons.account_tree_outlined,
                      title: 'No contexts',
                      message: 'Add contexts from the Excavation Station.',
                    );
                  }

                  return HarrisInteractiveMatrix(
                    contexts: contexts,
                    relations: relations,
                    selectedContextId: _selectedContextId,
                    onNodeTap: (id) => setState(() {
                      _selectedContextId =
                          _selectedContextId == id ? null : id;
                    }),
                  );
                },
              ),
            ),
          ),

          // ── Selected context info bar ────────────────────────────────
          if (_selectedContextId != null)
            _SelectedContextBar(
              featureId: widget.featureId,
              contextId: _selectedContextId!,
              onClear: () => setState(() => _selectedContextId = null),
            ),

          // ── Legend bar ────────────────────────────────────────────────
          _LegendBar(),

          // ── Bottom action bar ─────────────────────────────────────────
          Container(height: 1, color: colors.rule),
          _MatrixActionBar(
            featureId: widget.featureId,
            onRelationAdded: () =>
                ref.invalidate(harrisByFeatureProvider(widget.featureId)),
          ),
        ],
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _MatrixHeader extends ConsumerWidget {
  const _MatrixHeader({required this.featureId});
  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final relationsAsync = ref.watch(harrisByFeatureProvider(featureId));
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    final relationCount = relationsAsync.when(
      data: (r) => r.length,
      loading: () => 0,
      error: (_, __) => 0,
    );
    final contextCount = contextsAsync.when(
      data: (c) => c.length,
      loading: () => 0,
      error: (_, __) => 0,
    );

    return Container(
      color: colors.s0,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 52,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, size: 20),
                color: colors.t1,
                onPressed: () => context.pop(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'STRATIGRAPHY',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 8,
                      letterSpacing: 2.0,
                      color: colors.t2,
                    ),
                  ),
                  Text(
                    '$contextCount ctx · $relationCount rel',
                    style: TextStyle(
                      fontFamily: AppTypography.monoFontFamily,
                      fontSize: 11,
                      color: colors.t1,
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

// ── Selected context info bar ─────────────────────────────────────────────────

class _SelectedContextBar extends ConsumerWidget {
  const _SelectedContextBar({
    required this.featureId,
    required this.contextId,
    required this.onClear,
  });

  final String featureId;
  final String contextId;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return contextsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (contexts) {
        final ctx = contexts.where((c) => c.id == contextId).firstOrNull;
        if (ctx == null) return const SizedBox.shrink();

        final isCut = ctx is CutModel;
        final accentColor = isCut ? colors.cut : colors.fill;
        final textColor = isCut ? colors.cutText : colors.fillText;
        final typeLabel = isCut ? 'CUT' : 'FILL';

        return Container(
          color: colors.s1,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
            vertical: AppSpacing.space8,
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 32,
                color: accentColor,
                margin: const EdgeInsets.only(right: 10.0),
              ),
              Text(
                typeLabel,
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 9,
                  letterSpacing: 1.5,
                  color: accentColor,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Text(
                ctx.contextNumber.toString().padLeft(3, '0'),
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: -0.5,
                  color: textColor,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onClear,
                style: TextButton.styleFrom(
                  foregroundColor: colors.t1,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 32),
                ),
                child: const Text('clear'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Legend bar ────────────────────────────────────────────────────────────────

class _LegendBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      color: colors.s1,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space6,
      ),
      child: Row(
        children: [
          _LegendItem(
            shape: _LegendShape.square,
            color: colors.cut,
            surface: colors.cutSurface,
            label: 'Cut',
          ),
          const SizedBox(width: AppSpacing.space16),
          _LegendItem(
            shape: _LegendShape.rounded,
            color: colors.fill,
            surface: colors.fillSurface,
            label: 'Fill',
          ),
          const SizedBox(width: AppSpacing.space16),
          Row(
            children: [
              Container(
                width: 20,
                height: 1,
                color: colors.ruleStrong,
              ),
              const SizedBox(width: AppSpacing.space4),
              Text(
                'Sequence',
                style: TextStyle(
                  fontFamily: AppTypography.monoFontFamily,
                  fontSize: 9,
                  color: colors.t2,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _LegendShape { square, rounded }

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.shape,
    required this.color,
    required this.surface,
    required this.label,
  });

  final _LegendShape shape;
  final Color color;
  final Color surface;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: surface,
            borderRadius: shape == _LegendShape.rounded
                ? AppRadius.fullBorderRadius
                : AppRadius.xsBorderRadius,
            border: Border.all(color: color, width: 1.5),
          ),
        ),
        const SizedBox(width: AppSpacing.space6),
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTypography.monoFontFamily,
            fontSize: 9,
            color: colors.t2,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ── Action bar ────────────────────────────────────────────────────────────────

class _MatrixActionBar extends ConsumerWidget {
  const _MatrixActionBar({
    required this.featureId,
    required this.onRelationAdded,
  });

  final String featureId;
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
            AppSpacing.space16,
            10.0,
            AppSpacing.space16,
            10.0,
          ),
          child: FilledButton.icon(
            onPressed: () => _addRelation(context, ref),
            icon: const Icon(Icons.add_link_rounded, size: 18),
            label: Text(
              'ADD RELATION',
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
              minimumSize: const Size(double.infinity, 44),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.smBorderRadius,
              ),
            ),
          ),
        ),
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
}
