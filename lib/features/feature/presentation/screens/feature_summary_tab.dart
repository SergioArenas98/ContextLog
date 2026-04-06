import 'package:flutter/material.dart';

import '../../../../core/design/app_tokens.dart';
import '../../../../core/widgets/metadata_row.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../domain/models/feature_model.dart';

/// Compact feature metadata tab (kept for reference; not currently shown in tabs).
class FeatureSummaryTab extends StatelessWidget {
  const FeatureSummaryTab({super.key, required this.feature});

  final FeatureModel feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.space16),
      children: [
        SurfaceCard(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(label: 'Identity'),
              MetadataRow(
                label: 'Feature No.',
                value: feature.featureNumber,
                valueStyle: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
              MetadataRow(
                label: 'Date',
                value: _formatDate(feature.date),
              ),
              if (feature.area != null)
                MetadataRow(label: 'Area', value: feature.area!),
              if (feature.rubiconCode != null)
                MetadataRow(label: 'Rubicon Code', value: feature.rubiconCode!),
              if (feature.license != null)
                MetadataRow(label: 'License', value: feature.license!),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        SurfaceCard(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(label: 'Record'),
              MetadataRow(
                label: 'Created',
                value: _formatDateTime(feature.createdAt),
                valueStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
              ),
              MetadataRow(
                label: 'Last updated',
                value: _formatDateTime(feature.updatedAt),
                valueStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.space32),
      ],
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _formatDateTime(DateTime d) =>
      '${_formatDate(d)} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}
