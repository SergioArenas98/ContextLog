import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/harris_relation_repository.dart';
import '../../domain/models/harris_relation_model.dart';
import '../../domain/validators/harris_relation_validator.dart';

final harrisRelationRepositoryProvider =
    Provider<HarrisRelationRepository>((ref) {
  return HarrisRelationRepository(ref.watch(databaseProvider));
});

final harrisRelationValidatorProvider =
    Provider<HarrisRelationValidator>((ref) {
  return HarrisRelationValidator(ref.watch(harrisRelationRepositoryProvider));
});

final harrisByFeatureProvider =
    FutureProvider.family<List<HarrisRelationModel>, String>(
        (ref, featureId) async {
  return ref
      .watch(harrisRelationRepositoryProvider)
      .getByFeatureId(featureId);
});
