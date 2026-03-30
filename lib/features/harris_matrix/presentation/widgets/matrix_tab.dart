import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
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
                if (relations.isNotEmpty)
                  _RelationChips(
                    relations: relations,
                    featureId: featureId,
                    ref: ref,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAdd(context, ref),
        tooltip: 'Add stratigraphic relation',
        child: const Icon(Icons.add),
      ),
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

class _RelationChips extends StatelessWidget {
  const _RelationChips({
    required this.relations,
    required this.featureId,
    required this.ref,
  });

  final List<HarrisRelationModel> relations;
  final String featureId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 16),
          const SizedBox(width: 8),
          Text(
            '${relations.length} relation${relations.length == 1 ? '' : 's'}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(Icons.list, size: 16),
            label: const Text('List'),
            onPressed: () => _showRelationsList(context),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
        ],
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
      ),
    );
  }
}

class _RelationsListSheet extends StatelessWidget {
  const _RelationsListSheet({
    required this.relations,
    required this.featureId,
    required this.ref,
  });

  final List<HarrisRelationModel> relations;
  final String featureId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Text(
              'Stratigraphic Relations',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        ...relations.map(
          (r) => ListTile(
            dense: true,
            title: Text(
              'C${_contextNumber(r.fromContextId)} ${r.relationType.displayName.toLowerCase()} C${_contextNumber(r.toContextId)}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () async {
                final confirmed = await showConfirmDeleteDialog(
                  context,
                  title: 'Remove relation?',
                  message: 'This will remove the stratigraphic relation.',
                );
                if (confirmed && context.mounted) {
                  await ref
                      .read(harrisRelationRepositoryProvider)
                      .delete(r.id);
                  ref.invalidate(harrisByFeatureProvider(featureId));
                  if (context.mounted) Navigator.of(context).pop();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  // We don't have context numbers here easily — use IDs truncated
  String _contextNumber(String contextId) =>
      contextId.substring(0, 8);
}

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

  Size _computeCanvasSize(List contexts) {
    // Rough estimate: 120px per node width, 100px per layer height
    const nodesPerRow = 4;
    final rows = (contexts.length / nodesPerRow).ceil();
    return Size(
      nodesPerRow * 140.0 + 100,
      rows * 120.0 + 100,
    );
  }
}
