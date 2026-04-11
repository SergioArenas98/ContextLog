import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/surface_card.dart';
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
              actionLabel: 'Add Context',
              onAction: () => _showAdd(context, ref),
            );
          }

          final cuts = contexts.whereType<CutModel>().toList();
          final fills = contexts.whereType<FillModel>().toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.space16,
              AppSpacing.space8,
              AppSpacing.space16,
              AppSpacing.space64 + 32,
            ),
            children: [
              if (cuts.isNotEmpty) ...[
                SectionHeader(label: 'Cuts (${cuts.length})'),
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
              if (fills.isNotEmpty && cuts.isEmpty) ...[
                SectionHeader(label: 'Fills (${fills.length})'),
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
      floatingActionButton: contextsAsync.valueOrNull?.isNotEmpty == true
          ? FloatingActionButton.extended(
              heroTag: 'addContext',
              onPressed: () => _showAdd(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Context'),
            )
          : null,
    );
  }

  void _showAdd(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ContextFormSheet(
        featureId: featureId,
        onSaved: () {
          ref.invalidate(contextsByFeatureProvider(featureId));
          ref.invalidate(cutsByFeatureProvider(featureId));
          ref.invalidate(fillsByFeatureProvider(featureId));
        },
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
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.space4),
          child: SurfaceCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: AppSpacing.space12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Badge
                StatusBadge(
                  label: 'C${context_.contextNumber}',
                  backgroundColor: bgColor,
                  foregroundColor: fgColor,
                ),
                const SizedBox(width: AppSpacing.space12),
                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Context ${context_.contextNumber} — ${isCut ? 'Cut' : 'Fill'}',
                        style: theme.textTheme.titleSmall,
                      ),
                      if (_subtitle != null) ...[
                        const SizedBox(height: AppSpacing.space2),
                        Text(
                          _subtitle!,
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
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: () => showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (_) => ContextFormSheet(
                          featureId: featureId,
                          existingContext: context_,
                          onSaved: () {
                            ref.invalidate(
                                contextsByFeatureProvider(featureId));
                            ref.invalidate(cutsByFeatureProvider(featureId));
                            ref.invalidate(fillsByFeatureProvider(featureId));
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
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: () async {
                        final confirmed = await showConfirmDeleteDialog(
                          context,
                          title: 'Delete context ${context_.contextNumber}?',
                          message: isCut
                              ? 'This will also delete all associated fills, finds, and samples.'
                              : 'This will also delete all associated finds and samples.',
                        );
                        if (confirmed && context.mounted) {
                          await ref
                              .read(contextRepositoryProvider)
                              .delete(context_.id);
                          ref.invalidate(
                              contextsByFeatureProvider(featureId));
                          ref.invalidate(cutsByFeatureProvider(featureId));
                          ref.invalidate(fillsByFeatureProvider(featureId));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Fills indented under their cut with a connector line
        if (fills.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 28,
                  bottom: AppSpacing.space4,
                ),
                child: Container(
                  width: 2,
                  height: fills.length * 72.0,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: AppRadius.fullBorderRadius,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.space8),
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
              ),
            ],
          ),
      ],
    );
  }

  String? get _subtitle {
    return switch (context_) {
      CutModel(:final cutType, :final customCutTypeText, :final notes) => [
          if (cutType != null)
            cutType == CutType.other && customCutTypeText != null
                ? customCutTypeText
                : cutType.displayName,
          if (notes != null && notes.isNotEmpty) notes,
        ].join(' · ').nullIfEmpty,
      FillModel(:final color, :final composition, :final notes) => [
          if (color != null && color.isNotEmpty) 'Color: $color',
          if (composition != null && composition.isNotEmpty)
            'Comp: $composition',
          if (notes != null && notes.isNotEmpty) notes,
        ].join(' · ').nullIfEmpty,
    };
  }
}

extension on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}
