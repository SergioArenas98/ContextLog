import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../domain/models/feature_model.dart';
import '../providers/feature_providers.dart';

class FeatureCard extends ConsumerWidget {
  const FeatureCard({super.key, required this.feature});

  final FeatureModel feature;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: () => context.push('/features/${feature.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Feature ${feature.featureNumber}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _contextChip(context, feature.featureNumber),
                  const SizedBox(width: 8),
                  _MoreMenu(feature: feature),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${feature.site} › ${feature.trench} › ${feature.area}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 14,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    feature.excavator,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(feature.date),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contextChip(BuildContext context, String number) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'F${number}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

class _MoreMenu extends ConsumerWidget {
  const _MoreMenu({required this.feature});

  final FeatureModel feature;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'edit', child: Text('Edit')),
        const PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
      onSelected: (value) async {
        if (value == 'edit') {
          context.push('/features/${feature.id}/edit');
        } else if (value == 'delete') {
          final confirmed = await showConfirmDeleteDialog(
            context,
            title: 'Delete Feature ${feature.featureNumber}?',
            message:
                'This will permanently delete the feature and all associated '
                'photos, drawings, contexts, finds, samples, and Harris Matrix '
                'data. This cannot be undone.',
          );
          if (confirmed && context.mounted) {
            await ref
                .read(featureRepositoryProvider)
                .delete(feature.id);
            ref.invalidate(filteredFeatureListProvider);
            ref.invalidate(featureListProvider);
          }
        }
      },
    );
  }
}
