import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/surface_card.dart';
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
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space8,
              AppSpacing.space16,
              AppSpacing.space64 + 32,
            ),
            children: [
              for (final entry in grouped.entries) ...[
                SectionHeader(label: entry.key.displayName),
                ...entry.value.map(
                  (photo) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppSpacing.space8),
                    child: _PhotoTile(
                      photo: photo,
                      featureId: featureId,
                      onDelete: () => _deletePhoto(context, ref, photo),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPhoto(context, ref),
        icon: const Icon(Icons.add_a_photo_rounded),
        label: const Text('Add Photo'),
      ),
    );
  }

  void _showAddPhoto(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => PhotoFormSheet(
        featureId: featureId,
        onSaved: () {
          ref.invalidate(photosByFeatureProvider(featureId));
        },
      ),
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
    final theme = Theme.of(context);
    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.space12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image thumbnail
          _Thumbnail(path: photo.localImagePath),
          const SizedBox(width: AppSpacing.space12),
          // Metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        photo.manualCameraPhotoNumber != null
                            ? 'Photo #${photo.manualCameraPhotoNumber}'
                            : 'No photo number',
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    StatusBadge(
                      label: photo.cardinalOrientation.displayName,
                      backgroundColor:
                          theme.colorScheme.secondaryContainer,
                      foregroundColor:
                          theme.colorScheme.onSecondaryContainer,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space2),
                StatusBadge(
                  label: photo.stage.displayName,
                  backgroundColor: theme.colorScheme.tertiaryContainer,
                  foregroundColor: theme.colorScheme.onTertiaryContainer,
                ),
                if (photo.notes != null && photo.notes!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    photo.notes!,
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
          Column(
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
                  builder: (_) => PhotoFormSheet(
                    featureId: featureId,
                    photo: photo,
                    onSaved: () =>
                        ref.invalidate(photosByFeatureProvider(featureId)),
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
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (path != null) {
      return ClipRRect(
        borderRadius: AppRadius.smBorderRadius,
        child: Image.file(
          File(path!),
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(theme),
        ),
      );
    }
    return _placeholder(theme);
  }

  Widget _placeholder(ThemeData theme) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: AppRadius.smBorderRadius,
      ),
      child: Icon(
        Icons.photo_outlined,
        color: theme.colorScheme.outline,
        size: 28,
      ),
    );
  }
}
