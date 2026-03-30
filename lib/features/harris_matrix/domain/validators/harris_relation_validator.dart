import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/validation_result.dart';
import '../../data/repositories/harris_relation_repository.dart';

class HarrisRelationValidator {
  const HarrisRelationValidator(this._repository);

  final HarrisRelationRepository _repository;

  Future<ValidationResult> validate({
    required String fromContextId,
    required String toContextId,
    String? excludeId,
  }) async {
    if (fromContextId == toContextId) {
      return const ValidationInvalid(ValidationMessages.selfLoopRelation);
    }

    final exists = await _repository.relationExists(
      fromContextId: fromContextId,
      toContextId: toContextId,
      excludeId: excludeId,
    );

    if (exists) {
      return ValidationWarning(ValidationMessages.duplicateRelation);
    }

    return const ValidationValid();
  }
}
