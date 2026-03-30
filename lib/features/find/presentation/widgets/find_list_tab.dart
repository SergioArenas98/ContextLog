import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
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
              message:
                  'Record finds (flint, ceramic, metal, etc.) from fills.',
              actionLabel: 'Add Find',
              onAction: () => _showAdd(context, ref),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            itemCount: finds.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) => _FindTile(
              find: finds[index],
              featureId: featureId,
              ref: ref,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAdd(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Find'),
      ),
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

  @override
  Widget build(BuildContext context) {
    final materialLabel =
        find.materialType == FindMaterialType.other && find.customMaterialText != null
            ? find.customMaterialText!
            : find.materialType.displayName;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Text(
            'F${find.findNumber}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        title: Text('Find ${find.findNumber} — $materialLabel'),
        subtitle: Text(
          'Qty: ${find.quantity}'
          '${find.description != null ? ' · ${find.description}' : ''}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
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
                builder: (_) => FindFormSheet(
                  featureId: featureId,
                  find: find,
                  onSaved: () {
                    ref.invalidate(findsByFeatureProvider(featureId));
                    ref.invalidate(nextFindNumberProvider(featureId));
                  },
                ),
              );
            } else if (v == 'delete') {
              final confirmed = await showConfirmDeleteDialog(
                context,
                title: 'Delete find ${find.findNumber}?',
                message: 'This will permanently remove the find record.',
              );
              if (confirmed) {
                await ref.read(findRepositoryProvider).delete(find.id);
                ref.invalidate(findsByFeatureProvider(featureId));
                ref.invalidate(nextFindNumberProvider(featureId));
              }
            }
          },
        ),
      ),
    );
  }
}
