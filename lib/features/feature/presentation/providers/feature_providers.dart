import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/feature_repository.dart';
import '../../domain/models/feature_model.dart';
import '../../domain/validators/feature_validator.dart';

final featureRepositoryProvider = Provider<FeatureRepository>((ref) {
  return FeatureRepository(ref.watch(databaseProvider));
});

final featureValidatorProvider = Provider<FeatureValidator>((ref) {
  return FeatureValidator(ref.watch(featureRepositoryProvider));
});

/// Provides the full feature list, sorted by most-recent first.
final featureListProvider =
    AsyncNotifierProvider<FeatureListNotifier, List<FeatureModel>>(
  FeatureListNotifier.new,
);

class FeatureListNotifier extends AsyncNotifier<List<FeatureModel>> {
  @override
  Future<List<FeatureModel>> build() async {
    return ref.watch(featureRepositoryProvider).getAll();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(featureRepositoryProvider).getAll(),
    );
  }
}

/// Provides a single feature by id.
final featureDetailProvider =
    FutureProvider.family<FeatureModel?, String>((ref, id) async {
  return ref.watch(featureRepositoryProvider).getById(id);
});

/// Search query state.
final featureSearchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered feature list based on search query.
final filteredFeatureListProvider =
    FutureProvider<List<FeatureModel>>((ref) async {
  final query = ref.watch(featureSearchQueryProvider);
  final repo = ref.watch(featureRepositoryProvider);
  if (query.trim().isEmpty) {
    return repo.getAll();
  }
  return repo.search(query.trim());
});
