import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/context_repository.dart';
import '../../domain/models/context_model.dart';
import '../../domain/validators/context_validator.dart';

final contextRepositoryProvider = Provider<ContextRepository>((ref) {
  return ContextRepository(ref.watch(databaseProvider));
});

final contextValidatorProvider = Provider<ContextValidator>((ref) {
  return ContextValidator(ref.watch(contextRepositoryProvider));
});

final contextsByFeatureProvider =
    FutureProvider.family<List<ContextModel>, String>((ref, featureId) async {
  return ref.watch(contextRepositoryProvider).getByFeatureId(featureId);
});

final cutsByFeatureProvider =
    FutureProvider.family<List<ContextModel>, String>((ref, featureId) async {
  return ref.watch(contextRepositoryProvider).getCutsByFeatureId(featureId);
});

final fillsByFeatureProvider =
    FutureProvider.family<List<ContextModel>, String>((ref, featureId) async {
  return ref.watch(contextRepositoryProvider).getFillsByFeatureId(featureId);
});
