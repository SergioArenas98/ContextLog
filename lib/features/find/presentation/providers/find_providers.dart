import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../data/repositories/find_repository.dart';
import '../../domain/models/find_model.dart';
import '../../domain/validators/find_validator.dart';

final findRepositoryProvider = Provider<FindRepository>((ref) {
  return FindRepository(ref.watch(databaseProvider));
});

final findValidatorProvider = Provider<FindValidator>((ref) {
  return FindValidator(ref.watch(contextRepositoryProvider));
});

final findsByFeatureProvider =
    FutureProvider.family<List<FindModel>, String>((ref, featureId) async {
  return ref.watch(findRepositoryProvider).getByFeatureId(featureId);
});

final nextFindNumberProvider =
    FutureProvider.family<int, String>((ref, featureId) async {
  return ref.watch(findRepositoryProvider).nextFindNumber(featureId);
});
