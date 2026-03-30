import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/models/photo_model.dart';
import '../providers/photo_providers.dart';
import 'photo_form_sheet.dart';

class PhotoListTab extends ConsumerWidget {
  const PhotoListTab({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photosByFeatureProvider(featureId));

    return Scaffold(
      body: photosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (photos) {
          if (photos.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.photo_library_outlined,
              title: 'No photos yet',
              message: 'Add pre-ex, mid-ex, working shot, or post-ex photos.',
              actionLabel: 'Add Photo',
              onAction: () => _showAddPhoto(context, ref),
            );
          }

          // Group by stage
          final grouped = <PhotoStage, List<PhotoModel>>{};
          for (final stage in PhotoStage.values) {
            final stagePhotos =
                photos.where((p) => p.stage == stage).toList();
            if (stagePhotos.isNotEmpty) grouped[stage] = stagePhotos;
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              for (final entry in grouped.entries) ...[
                _StageSectionHeader(stage: entry.key),
                ...entry.value.map(
                  (photo) => _PhotoTile(
                    photo: photo,
                    featureId: featureId,
                    onDelete: () => _deletePhoto(context, ref, photo),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPhoto(context, ref),
        tooltip: 'Add Photo',
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }

  void _showAddPhoto(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => PhotoFormSheet(featureId: featureId, onSaved: () {
        ref.invalidate(photosByFeatureProvider(featureId));
      }),
    );
  }

  Future<void> _deletePhoto(
    BuildContext context,
    WidgetRef ref,
    PhotoModel photo,
  ) async {
    final confirmed = await showConfirmDeleteDialog(
      context,
      title: 'Delete photo?',
      message: 'This will permanently remove the photo record.',
    );
    if (confirmed) {
      await ref.read(photoRepositoryProvider).delete(photo.id);
      ref.invalidate(photosByFeatureProvider(featureId));
    }
  }
}

class _StageSectionHeader extends StatelessWidget {
  const _StageSectionHeader({required this.stage});

  final PhotoStage stage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        stage.displayName,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _PhotoTile extends ConsumerWidget {
  const _PhotoTile({
    required this.photo,
    required this.featureId,
    required this.onDelete,
  });

  final PhotoModel photo;
  final String featureId;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: photo.localImagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(photo.localImagePath!),
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              )
            : Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.photo_outlined,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
        title: Text(
          photo.manualCameraPhotoNumber != null
              ? 'Photo #${photo.manualCameraPhotoNumber}'
              : 'No photo number',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Facing: ${photo.cardinalOrientation.displayName}'),
            if (photo.notes != null && photo.notes!.isNotEmpty)
              Text(
                photo.notes!,
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
          onSelected: (v) {
            if (v == 'edit') {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (_) => PhotoFormSheet(
                  featureId: featureId,
                  photo: photo,
                  onSaved: () =>
                      ref.invalidate(photosByFeatureProvider(featureId)),
                ),
              );
            } else if (v == 'delete') {
              onDelete();
            }
          },
        ),
      ),
    );
  }
}
