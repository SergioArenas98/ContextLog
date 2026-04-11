import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../../context/domain/models/context_model.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../domain/models/harris_relation_model.dart';
import '../providers/harris_providers.dart';
import 'harris_matrix_painter.dart';
import 'relation_form_sheet.dart';

class MatrixTab extends ConsumerWidget {
  const MatrixTab({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationsAsync = ref.watch(harrisByFeatureProvider(featureId));
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return Scaffold(
      body: relationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (relations) => contextsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (contexts) {
            if (contexts.isEmpty) {
              return const EmptyStateWidget(
                icon: Icons.account_tree_outlined,
                title: 'No contexts yet',
                message:
                    'Add cuts and fills in the Contexts tab to start building the Harris Matrix.',
              );
            }

            return Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: relations.isNotEmpty ? null : 0,
                  child: relations.isNotEmpty
                      ? _RelationInfoBar(
                          relations: relations,
                          featureId: featureId,
                          ref: ref,
                          contexts: contexts,
                        )
                      : null,
                ),
                Expanded(
                  child: relations.isEmpty
                      ? EmptyStateWidget(
                          icon: Icons.account_tree_outlined,
                          title: 'No relations yet',
                          message:
                              'Add stratigraphic relations to build the matrix.',
                          actionLabel: 'Add Relation',
                          onAction: () => _showAdd(context, ref),
                        )
                      : _HarrisMatrixView(
                          featureId: featureId,
                          relations: relations,
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: relationsAsync.valueOrNull?.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: () => _showAdd(context, ref),
              tooltip: 'Add stratigraphic relation',
              icon: const Icon(Icons.add_link_rounded),
              label: const Text('Add Relation'),
            )
          : null,
    );
  }

  void _showAdd(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => RelationFormSheet(
        featureId: featureId,
        onSaved: () => ref.invalidate(harrisByFeatureProvider(featureId)),
      ),
    );
  }
}

// ── Relation info bar ──────────────────��───────────────────────────────────────

class _RelationInfoBar extends StatelessWidget {
  const _RelationInfoBar({
    required this.relations,
    required this.featureId,
    required this.ref,
    required this.contexts,
  });

  final List<HarrisRelationModel> relations;
  final String featureId;
  final WidgetRef ref;
  final List<ContextModel> contexts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = relations.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space16,
        AppSpacing.space8,
        AppSpacing.space16,
        0,
      ),
      child: SurfaceCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space8,
        ),
        child: Row(
          children: [
            Icon(
              Icons.account_tree_rounded,
              size: 16,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.space8),
            Text(
              '$count relation${count == 1 ? '' : 's'}',
              style: theme.textTheme.labelMedium,
            ),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.list_rounded, size: 16),
              label: const Text('Show list'),
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                foregroundColor: theme.colorScheme.primary,
              ),
              onPressed: () => _showRelationsList(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showRelationsList(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (_) => _RelationsListSheet(
        relations: relations,
        featureId: featureId,
        ref: ref,
        contexts: contexts,
      ),
    );
  }
}

// ── Relations list sheet ───────────────────────────���───────────────────────────

class _RelationsListSheet extends StatelessWidget {
  const _RelationsListSheet({
    required this.relations,
    required this.featureId,
    required this.ref,
    required this.contexts,
  });

  final List<HarrisRelationModel> relations;
  final String featureId;
  final WidgetRef ref;
  final List<ContextModel> contexts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Build a lookup from context ID → context number for proper display
    final idToNumber = <String, String>{
      for (final ctx in contexts) ctx.id: ctx.contextNumber.toString(),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space24,
            AppSpacing.space16,
            AppSpacing.space8,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Stratigraphic Relations',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        const Divider(),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space8,
              AppSpacing.space16,
              AppSpacing.space24,
            ),
            children: relations
                .map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                    child: SurfaceCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space16,
                        vertical: AppSpacing.space8,
                      ),
                      child: Row(
                        children: [
                          // From badge
                          _ContextPill(
                            label: 'C${idToNumber[r.fromContextId] ?? '?'}',
                            theme: theme,
                            isPrimary: true,
                          ),
                          const SizedBox(width: AppSpacing.space8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: AppSpacing.space8),
                          // To badge
                          _ContextPill(
                            label: 'C${idToNumber[r.toContextId] ?? '?'}',
                            theme: theme,
                            isPrimary: false,
                          ),
                          const SizedBox(width: AppSpacing.space8),
                          Expanded(
                            child: Text(
                              r.relationType.displayName.toLowerCase(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_rounded,
                              size: 18,
                              color: theme.colorScheme.error,
                            ),
                            padding: const EdgeInsets.all(AppSpacing.space8),
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            onPressed: () async {
                              final confirmed =
                                  await showConfirmDeleteDialog(
                                context,
                                title: 'Remove relation?',
                                message:
                                    'This will remove the stratigraphic relation.',
                              );
                              if (confirmed && context.mounted) {
                                await ref
                                    .read(harrisRelationRepositoryProvider)
                                    .delete(r.id);
                                ref.invalidate(
                                    harrisByFeatureProvider(featureId));
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ContextPill extends StatelessWidget {
  const _ContextPill({
    required this.label,
    required this.theme,
    required this.isPrimary,
  });

  final String label;
  final ThemeData theme;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: isPrimary
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.tertiaryContainer,
        borderRadius: AppRadius.fullBorderRadius,
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: isPrimary
              ? theme.colorScheme.onPrimaryContainer
              : theme.colorScheme.onTertiaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Harris Matrix canvas ─────────────────────────────���─────────────────────────

class _HarrisMatrixView extends ConsumerWidget {
  const _HarrisMatrixView({
    required this.featureId,
    required this.relations,
  });

  final String featureId;
  final List<HarrisRelationModel> relations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return contextsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (contexts) {
        if (contexts.isEmpty) return const SizedBox.shrink();

        return InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(200),
          minScale: 0.3,
          maxScale: 4,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: HarrisMatrixPainter(
                contexts: contexts,
                relations: relations,
                theme: Theme.of(context),
              ),
              size: _computeCanvasSize(contexts),
            ),
          ),
        );
      },
    );
  }

  Size _computeCanvasSize(List<ContextModel> contexts) {
    const nodesPerRow = 4;
    final rows = (contexts.length / nodesPerRow).ceil();
    return Size(
      nodesPerRow * 160.0 + 128,
      rows * 120.0 + 128,
    );
  }
}
