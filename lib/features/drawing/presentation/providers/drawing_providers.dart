import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/drawing_repository.dart';
import '../../domain/models/drawing_model.dart';

final drawingRepositoryProvider = Provider<DrawingRepository>((ref) {
  return DrawingRepository(ref.watch(databaseProvider));
});

final drawingsByFeatureProvider =
    FutureProvider.family<List<DrawingModel>, String>((ref, featureId) async {
  return ref.watch(drawingRepositoryProvider).getByFeatureId(featureId);
});
