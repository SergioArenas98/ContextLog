import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/surface_card.dart';
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
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space8,
              AppSpacing.space16,
              AppSpacing.space64 + 32,
            ),
            itemCount: drawings.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.space8),
            itemBuilder: (context, index) => _DrawingTile(
              drawing: drawings[index],
              featureId: featureId,
              ref: ref,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAdd(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Drawing'),
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
    final theme = Theme.of(context);
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Badge
          StatusBadge(
            label: drawing.drawingNumber,
            backgroundColor: theme.colorScheme.secondaryContainer,
            foregroundColor: theme.colorScheme.onSecondaryContainer,
            pill: false,
          ),
          const SizedBox(width: AppSpacing.space12),
          // Metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Drawing ${drawing.drawingNumber}',
                  style: theme.textTheme.titleSmall,
                ),
                if (drawing.drawingType != null ||
                    drawing.facing != CardinalOrientation.unknown) ...[
                  const SizedBox(height: AppSpacing.space2),
                  Text(
                    [
                      if (drawing.drawingType != null)
                        drawing.drawingType!.displayName,
                      if (drawing.facing != CardinalOrientation.unknown)
                        'Facing ${drawing.facing.displayName}',
                    ].join('  ·  '),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (drawing.boardNumber != null) ...[
                  const SizedBox(height: AppSpacing.space2),
                  Text(
                    'Board: ${drawing.boardNumber}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (drawing.notes != null &&
                    drawing.notes!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.space2),
                  Text(
                    drawing.notes!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                padding: const EdgeInsets.all(AppSpacing.space8),
                constraints:
                    const BoxConstraints(minWidth: 40, minHeight: 40),
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (_) => DrawingFormSheet(
                    featureId: featureId,
                    drawing: drawing,
                    onSaved: () =>
                        ref.invalidate(drawingsByFeatureProvider(featureId)),
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
                constraints:
                    const BoxConstraints(minWidth: 40, minHeight: 40),
                onPressed: () async {
                  final confirmed = await showConfirmDeleteDialog(
                    context,
                    title: 'Delete drawing?',
                    message: 'This will permanently remove the drawing record.',
                  );
                  if (confirmed && context.mounted) {
                    await ref
                        .read(drawingRepositoryProvider)
                        .delete(drawing.id);
                    ref.invalidate(drawingsByFeatureProvider(featureId));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
