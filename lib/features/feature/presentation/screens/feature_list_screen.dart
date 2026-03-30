import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state_widget.dart';
import '../providers/feature_providers.dart';
import '../widgets/feature_card.dart';

class FeatureListScreen extends ConsumerWidget {
  const FeatureListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(featureSearchQueryProvider);
    final featuresAsync = ref.watch(filteredFeatureListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ContextLog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(query: searchQuery, ref: ref),
          Expanded(
            child: featuresAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (features) {
                if (features.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.terrain_outlined,
                    title: searchQuery.isEmpty
                        ? 'No features recorded'
                        : 'No results for "$searchQuery"',
                    message: searchQuery.isEmpty
                        ? 'Tap + to start recording a new archaeological feature.'
                        : 'Try a different search term.',
                    actionLabel: searchQuery.isEmpty ? 'Add Feature' : null,
                    onAction: searchQuery.isEmpty
                        ? () => context.push('/features/new')
                        : null,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async =>
                      ref.read(featureListProvider.notifier).refresh(),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                    itemCount: features.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) =>
                        FeatureCard(feature: features[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/features/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Feature'),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'ContextLog',
      applicationVersion: '1.0.0',
      applicationLegalese: 'Archaeological field recording for Android',
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.query, required this.ref});

  final String query;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: SearchBar(
        hintText: 'Search features…',
        leading: const Icon(Icons.search),
        trailing: query.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => ref
                      .read(featureSearchQueryProvider.notifier)
                      .state = '',
                ),
              ]
            : null,
        onChanged: (value) =>
            ref.read(featureSearchQueryProvider.notifier).state = value,
        elevation: const WidgetStatePropertyAll(1),
      ),
    );
  }
}
