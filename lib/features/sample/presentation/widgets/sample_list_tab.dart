import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../domain/models/sample_model.dart';
import '../providers/sample_providers.dart';
import 'sample_form_sheet.dart';

class SampleListTab extends ConsumerWidget {
  const SampleListTab({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final samplesAsync = ref.watch(samplesByFeatureProvider(featureId));

    return Scaffold(
      body: samplesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (samples) {
          if (samples.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.science_outlined,
              title: 'No samples yet',
              message: 'Record sediment samples taken from fills.',
              actionLabel: 'Add Sample',
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
            itemCount: samples.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.space8),
            itemBuilder: (context, index) => _SampleTile(
              sample: samples[index],
              featureId: featureId,
              ref: ref,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAdd(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Sample'),
      ),
    );
  }

  void _showAdd(BuildContext context, WidgetRef ref) {
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
}

class _SampleTile extends StatelessWidget {
  const _SampleTile({
    required this.sample,
    required this.featureId,
    required this.ref,
  });

  final SampleModel sample;
  final String featureId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typeLabel =
        sample.sampleType == SampleType.other &&
                sample.customSampleTypeText != null
            ? sample.customSampleTypeText!
            : sample.sampleType.displayName;

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
            label: 'S${sample.sampleNumber}',
            backgroundColor: theme.colorScheme.tertiaryContainer,
            foregroundColor: theme.colorScheme.onTertiaryContainer,
          ),
          const SizedBox(width: AppSpacing.space12),
          // Metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  typeLabel,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.space2),
                Text(
                  sample.liters != null
                      ? '${sample.storageType.displayName}  ·  ${sample.liters}L'
                      : sample.storageType.displayName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
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
                  builder: (_) => SampleFormSheet(
                    featureId: featureId,
                    sample: sample,
                    onSaved: () =>
                        ref.invalidate(samplesByFeatureProvider(featureId)),
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
                    title: 'Delete sample ${sample.sampleNumber}?',
                    message:
                        'This will permanently remove the sample record.',
                  );
                  if (confirmed && context.mounted) {
                    await ref
                        .read(sampleRepositoryProvider)
                        .delete(sample.id);
                    ref.invalidate(samplesByFeatureProvider(featureId));
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
