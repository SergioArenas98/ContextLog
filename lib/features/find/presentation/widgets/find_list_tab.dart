import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../domain/models/find_model.dart';
import '../providers/find_providers.dart';
import 'find_form_sheet.dart';

class FindListTab extends ConsumerWidget {
  const FindListTab({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final findsAsync = ref.watch(findsByFeatureProvider(featureId));

    return Scaffold(
      body: findsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (finds) {
          if (finds.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.search,
              title: 'No finds yet',
              message: 'Record finds (flint, ceramic, metal, etc.) from fills.',
              actionLabel: 'Add Find',
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
            itemCount: finds.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.space8),
            itemBuilder: (context, index) => _FindTile(
              find: finds[index],
              featureId: featureId,
              ref: ref,
            ),
          );
        },
      ),
      floatingActionButton: findsAsync.valueOrNull?.isNotEmpty == true
          ? FloatingActionButton.extended(
              onPressed: () => _showAdd(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Find'),
            )
          : null,
    );
  }

  void _showAdd(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => FindFormSheet(
        featureId: featureId,
        onSaved: () {
          ref.invalidate(findsByFeatureProvider(featureId));
          ref.invalidate(nextFindNumberProvider(featureId));
        },
      ),
    );
  }
}

class _FindTile extends StatelessWidget {
  const _FindTile({
    required this.find,
    required this.featureId,
    required this.ref,
  });

  final FindModel find;
  final String featureId;
  final WidgetRef ref;

  void _showImagePreview(BuildContext context, String imagePath) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => _ImagePreviewDialog(imagePath: imagePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final materialLabel =
        find.materialType == FindMaterialType.other &&
                find.customMaterialText != null
            ? find.customMaterialText!
            : find.materialType.displayName;

    final hasPhoto = find.localImagePath != null;

    return SurfaceCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasPhoto) ...[
            GestureDetector(
              onTap: () => _showImagePreview(context, find.localImagePath!),
              child: ClipRRect(
                borderRadius: AppRadius.smBorderRadius,
                child: Image.file(
                  File(find.localImagePath!),
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: theme.colorScheme.surfaceContainerHigh,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Badge
              StatusBadge(
                label: 'F${find.findNumber}',
                backgroundColor: theme.colorScheme.secondaryContainer,
                foregroundColor: theme.colorScheme.onSecondaryContainer,
              ),
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
                            materialLabel,
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                        Text(
                          '× ${find.quantity}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    if (find.description != null &&
                        find.description!.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.space2),
                      Text(
                        find.description!,
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
                  builder: (_) => FindFormSheet(
                    featureId: featureId,
                    find: find,
                    onSaved: () {
                      ref.invalidate(findsByFeatureProvider(featureId));
                      ref.invalidate(nextFindNumberProvider(featureId));
                    },
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
                    title: 'Delete find ${find.findNumber}?',
                    message:
                        'This will permanently remove the find record.',
                  );
                  if (confirmed && context.mounted) {
                    await ref
                        .read(findRepositoryProvider)
                        .delete(find.id);
                    ref.invalidate(findsByFeatureProvider(featureId));
                    ref.invalidate(nextFindNumberProvider(featureId));
                  }
                },
              ),
            ],
          ),
        ],
      ),
        ],
      ),
    );
  }
}

// ── Full-screen image preview dialog ─────────────────────────────────────────

class _ImagePreviewDialog extends StatelessWidget {
  const _ImagePreviewDialog({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  color: Colors.white54,
                  size: 64,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
