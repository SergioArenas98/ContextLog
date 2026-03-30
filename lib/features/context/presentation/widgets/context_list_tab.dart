import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../domain/models/context_model.dart';
import '../providers/context_providers.dart';
import 'context_form_sheet.dart';

class ContextListTab extends ConsumerWidget {
  const ContextListTab({super.key, required this.featureId});

  final String featureId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contextsAsync = ref.watch(contextsByFeatureProvider(featureId));

    return Scaffold(
      body: contextsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (contexts) {
          if (contexts.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.layers_outlined,
              title: 'No contexts yet',
              message: 'Add cuts and fills. Fills must reference a parent cut.',
            );
          }

          final cuts =
              contexts.whereType<CutModel>().toList();
          final fills =
              contexts.whereType<FillModel>().toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              if (cuts.isNotEmpty) ...[
                _SectionHeader(label: 'Cuts (${cuts.length})'),
                ...cuts.map(
                  (cut) => _ContextTile(
                    context_: cut,
                    featureId: featureId,
                    ref: ref,
                    fills: fills
                        .where((f) => f.parentCutId == cut.id)
                        .toList(),
                  ),
                ),
              ],
              if (fills.isNotEmpty &&
                  cuts.isEmpty) ...[
                // orphaned fills (shouldn't normally happen)
                _SectionHeader(label: 'Fills (${fills.length})'),
                ...fills.map(
                  (fill) => _ContextTile(
                    context_: fill,
                    featureId: featureId,
                    ref: ref,
                  ),
                ),
              ],
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'addFill',
            onPressed: () => _showAdd(context, ref, ContextType.fill),
            tooltip: 'Add Fill',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'addCut',
            onPressed: () => _showAdd(context, ref, ContextType.cut),
            icon: const Icon(Icons.add),
            label: const Text('Add Cut'),
          ),
        ],
      ),
    );
  }

  void _showAdd(BuildContext context, WidgetRef ref, ContextType type) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ContextFormSheet(
        featureId: featureId,
        initialType: type,
        onSaved: () {
          ref.invalidate(contextsByFeatureProvider(featureId));
          ref.invalidate(cutsByFeatureProvider(featureId));
          ref.invalidate(fillsByFeatureProvider(featureId));
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _ContextTile extends StatelessWidget {
  const _ContextTile({
    required this.context_,
    required this.featureId,
    required this.ref,
    this.fills = const [],
  });

  final ContextModel context_;
  final String featureId;
  final WidgetRef ref;
  final List<FillModel> fills;

  @override
  Widget build(BuildContext context) {
    final isCut = context_ is CutModel;
    final theme = Theme.of(context);
    final bgColor = isCut
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.tertiaryContainer;
    final fgColor = isCut
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onTertiaryContainer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: bgColor,
              child: Text(
                'C${context_.contextNumber}',
                style: TextStyle(
                  color: fgColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(
              'Context ${context_.contextNumber} — ${isCut ? 'Cut' : 'Fill'}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: _buildSubtitle(context_),
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
                    builder: (_) => ContextFormSheet(
                      featureId: featureId,
                      existingContext: context_,
                      onSaved: () {
                        ref.invalidate(contextsByFeatureProvider(featureId));
                        ref.invalidate(cutsByFeatureProvider(featureId));
                        ref.invalidate(fillsByFeatureProvider(featureId));
                      },
                    ),
                  );
                } else if (v == 'delete') {
                  final confirmed = await showConfirmDeleteDialog(
                    context,
                    title: 'Delete context ${context_.contextNumber}?',
                    message: isCut
                        ? 'This will also delete all associated fills, finds, and samples.'
                        : 'This will also delete all associated finds and samples.',
                  );
                  if (confirmed) {
                    await ref
                        .read(contextRepositoryProvider)
                        .delete(context_.id);
                    ref.invalidate(contextsByFeatureProvider(featureId));
                    ref.invalidate(cutsByFeatureProvider(featureId));
                    ref.invalidate(fillsByFeatureProvider(featureId));
                  }
                }
              },
            ),
          ),
        ),
        // Fills indented under their cut
        if (fills.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 4),
            child: Column(
              children: fills
                  .map(
                    (fill) => _ContextTile(
                      context_: fill,
                      featureId: featureId,
                      ref: ref,
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget? _buildSubtitle(ContextModel ctx) {
    return switch (ctx) {
      CutModel(:final cutType, :final customCutTypeText, :final notes) =>
        _subtitleText([
          if (cutType != null)
            cutType == CutType.other && customCutTypeText != null
                ? customCutTypeText
                : cutType.displayName,
          if (notes != null && notes.isNotEmpty) notes,
        ]),
      FillModel(:final color, :final composition, :final notes) =>
        _subtitleText([
          if (color != null && color.isNotEmpty) 'Color: $color',
          if (composition != null && composition.isNotEmpty)
            'Composition: $composition',
          if (notes != null && notes.isNotEmpty) notes,
        ]),
    };
  }

  Widget? _subtitleText(List<String> parts) {
    if (parts.isEmpty) return null;
    return Text(
      parts.join(' · '),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
