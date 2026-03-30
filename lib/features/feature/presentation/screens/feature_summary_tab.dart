import 'package:flutter/material.dart';

import '../../domain/models/feature_model.dart';

class FeatureSummaryTab extends StatelessWidget {
  const FeatureSummaryTab({super.key, required this.feature});

  final FeatureModel feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _InfoCard(
          title: 'Location',
          children: [
            _InfoRow(label: 'Site', value: feature.site),
            _InfoRow(label: 'Trench', value: feature.trench),
            _InfoRow(label: 'Area', value: feature.area),
          ],
        ),
        const SizedBox(height: 12),
        _InfoCard(
          title: 'Identity',
          children: [
            _InfoRow(
              label: 'Feature No.',
              value: feature.featureNumber,
              valueStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            _InfoRow(label: 'Excavator', value: feature.excavator),
            _InfoRow(
              label: 'Date',
              value: _formatDate(feature.date),
            ),
          ],
        ),
        if (feature.notes != null && feature.notes!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Notes',
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(feature.notes!),
              ),
            ],
          ),
        ],
        const SizedBox(height: 12),
        _InfoCard(
          title: 'Record',
          children: [
            _InfoRow(
              label: 'Created',
              value: _formatDateTime(feature.createdAt),
            ),
            _InfoRow(
              label: 'Last updated',
              value: _formatDateTime(feature.updatedAt),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  String _formatDateTime(DateTime d) =>
      '${_formatDate(d)} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: valueStyle ?? theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
