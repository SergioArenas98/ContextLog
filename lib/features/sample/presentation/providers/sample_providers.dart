import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../../context/presentation/providers/context_providers.dart';
import '../../data/repositories/sample_repository.dart';
import '../../domain/models/sample_model.dart';
import '../../domain/validators/sample_validator.dart';

final sampleRepositoryProvider = Provider<SampleRepository>((ref) {
  return SampleRepository(ref.watch(databaseProvider));
});

final sampleValidatorProvider = Provider<SampleValidator>((ref) {
  return SampleValidator(
    ref.watch(sampleRepositoryProvider),
    ref.watch(contextRepositoryProvider),
  );
});

final samplesByFeatureProvider =
    FutureProvider.family<List<SampleModel>, String>((ref, featureId) async {
  return ref.watch(sampleRepositoryProvider).getByFeatureId(featureId);
});
