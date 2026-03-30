import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/photo_repository.dart';
import '../../domain/models/photo_model.dart';

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  return PhotoRepository(ref.watch(databaseProvider));
});

final photosByFeatureProvider =
    FutureProvider.family<List<PhotoModel>, String>((ref, featureId) async {
  return ref.watch(photoRepositoryProvider).getByFeatureId(featureId);
});
