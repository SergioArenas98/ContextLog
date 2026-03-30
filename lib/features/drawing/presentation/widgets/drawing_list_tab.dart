import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/models/drawing_model.dart';
import '../providers/drawing_providers.dart';
import 'drawing_form_sheet.dart';

class DrawingListTab extends ConsumerWidget {
  const DrawingListTab({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawingsAsync = ref.watch(drawingsByFeatureProvider(featureId));

    return Scaffold(
      body: drawingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (drawings) {
          if (drawings.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.architecture,
              title: 'No drawings yet',
              message: 'Add drawing records with drawing and board numbers.',
              actionLabel: 'Add Drawing',
              onAction: () => _showAdd(context, ref),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            itemCount: drawings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) => _DrawingTile(
              drawing: drawings[index],
              featureId: featureId,
              ref: ref,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAdd(context, ref),
        tooltip: 'Add Drawing',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAdd(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => DrawingFormSheet(
        featureId: featureId,
        onSaved: () => ref.invalidate(drawingsByFeatureProvider(featureId)),
      ),
    );
  }
}

class _DrawingTile extends StatelessWidget {
  const _DrawingTile({
    required this.drawing,
    required this.featureId,
    required this.ref,
  });

  final DrawingModel drawing;
  final String featureId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              drawing.drawingNumber,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        title: Text('Drawing ${drawing.drawingNumber}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (drawing.boardNumber != null)
              Text('Board: ${drawing.boardNumber}'),
            if (drawing.notes != null && drawing.notes!.isNotEmpty)
              Text(
                drawing.notes!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
          onSelected: (v) async {
            if (v == 'edit') {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (_) => DrawingFormSheet(
                  featureId: featureId,
                  drawing: drawing,
                  onSaved: () =>
                      ref.invalidate(drawingsByFeatureProvider(featureId)),
                ),
              );
            } else if (v == 'delete') {
              final confirmed = await showConfirmDeleteDialog(
                context,
                title: 'Delete drawing?',
                message: 'This will permanently remove the drawing record.',
              );
              if (confirmed) {
                await ref.read(drawingRepositoryProvider).delete(drawing.id);
                ref.invalidate(drawingsByFeatureProvider(featureId));
              }
            }
          },
        ),
      ),
    );
  }
}
