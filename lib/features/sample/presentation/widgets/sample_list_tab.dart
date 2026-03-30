import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            itemCount: samples.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
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
        icon: const Icon(Icons.add),
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
    final typeLabel =
        sample.sampleType == SampleType.other && sample.customSampleTypeText != null
            ? sample.customSampleTypeText!
            : sample.sampleType.displayName;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          child: Text(
            'S${sample.sampleNumber}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        title: Text('Sample ${sample.sampleNumber} — $typeLabel'),
        subtitle: Text(
          '${sample.storageType.displayName}'
          '${sample.liters != null ? ' · ${sample.liters}L' : ''}',
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
                builder: (_) => SampleFormSheet(
                  featureId: featureId,
                  sample: sample,
                  onSaved: () =>
                      ref.invalidate(samplesByFeatureProvider(featureId)),
                ),
              );
            } else if (v == 'delete') {
              final confirmed = await showConfirmDeleteDialog(
                context,
                title: 'Delete sample ${sample.sampleNumber}?',
                message: 'This will permanently remove the sample record.',
              );
              if (confirmed) {
                await ref.read(sampleRepositoryProvider).delete(sample.id);
                ref.invalidate(samplesByFeatureProvider(featureId));
              }
            }
          },
        ),
      ),
    );
  }
}
