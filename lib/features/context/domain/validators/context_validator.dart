import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/validation_result.dart';
import '../../data/repositories/context_repository.dart';

class ContextValidator {
  const ContextValidator(this._repository);

  final ContextRepository _repository;

  Future<ValidationResult> validateContextNumber({
    required String featureId,
    required int contextNumber,
    String? excludeId,
  }) async {
    if (contextNumber <= 0) {
      return const ValidationInvalid('Context number must be a positive integer');
    }

    final exists = await _repository.contextNumberExistsInFeature(
      featureId: featureId,
      contextNumber: contextNumber,
      excludeId: excludeId,
    );

    if (exists) {
      return ValidationWarning(
        '${ValidationMessages.contextNumberExists} (C$contextNumber). Save anyway?',
      );
    }

    return const ValidationValid();
  }

  /// Validates a fill for a standard feature (cut required).
  /// When [parentCutId] is null the parent-cut check is skipped (spread fills).
  Future<ValidationResult> validateFill({
    required String featureId,
    required int contextNumber,
    String? parentCutId,
    String? excludeId,
  }) async {
    // Check context number
    final numberResult = await validateContextNumber(
      featureId: featureId,
      contextNumber: contextNumber,
      excludeId: excludeId,
    );
    if (numberResult is ValidationInvalid) return numberResult;

    // Validate parent cut only when one is provided (standard features).
    // Spread features pass null and skip this check.
    if (parentCutId != null) {
      final cut = await _repository.getById(parentCutId);
      if (cut == null || cut.featureId != featureId) {
        return const ValidationInvalid(
          'Parent cut must exist within the same feature',
        );
      }
    }

    return numberResult; // May be ValidationWarning or ValidationValid
  }
}
