import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../context/presentation/widgets/context_list_tab.dart';
import '../../../drawing/presentation/widgets/drawing_list_tab.dart';
import '../../../find/presentation/widgets/find_list_tab.dart';
import '../../../harris_matrix/presentation/widgets/matrix_tab.dart';
import '../../../photo/presentation/widgets/photo_list_tab.dart';
import '../../../sample/presentation/widgets/sample_list_tab.dart';
import '../providers/feature_providers.dart';
import 'feature_summary_tab.dart';

class FeatureDetailScreen extends ConsumerWidget {
  const FeatureDetailScreen({super.key, required this.featureId});

  final String featureId;

  static const _tabs = [
    Tab(icon: Icon(Icons.info_outline), text: 'Summary'),
    Tab(icon: Icon(Icons.photo_library_outlined), text: 'Photos'),
    Tab(icon: Icon(Icons.architecture), text: 'Drawings'),
    Tab(icon: Icon(Icons.layers_outlined), text: 'Contexts'),
    Tab(icon: Icon(Icons.search), text: 'Finds'),
    Tab(icon: Icon(Icons.science_outlined), text: 'Samples'),
    Tab(icon: Icon(Icons.account_tree_outlined), text: 'Matrix'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featureAsync = ref.watch(featureDetailProvider(featureId));

    return featureAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Feature')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (feature) {
        if (feature == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Feature')),
            body: const Center(child: Text('Feature not found')),
          );
        }
        return DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Feature ${feature.featureNumber}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${feature.site} › ${feature.trench} › ${feature.area}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit feature',
                  onPressed: () => context.push('/features/$featureId/edit'),
                ),
              ],
              bottom: TabBar(
                tabs: _tabs,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
              ),
            ),
            body: TabBarView(
              children: [
                FeatureSummaryTab(feature: feature),
                PhotoListTab(featureId: featureId),
                DrawingListTab(featureId: featureId),
                ContextListTab(featureId: featureId),
                FindListTab(featureId: featureId),
                SampleListTab(featureId: featureId),
                MatrixTab(featureId: featureId),
              ],
            ),
          ),
        );
      },
    );
  }
}
