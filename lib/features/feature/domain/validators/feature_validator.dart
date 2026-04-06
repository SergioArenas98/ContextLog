import '../../../../core/utils/validation_result.dart';

/// Validator for feature creation and update.
/// Feature numbers are auto-generated, so no uniqueness check is needed.
/// All user-facing fields are optional, so there is nothing to validate.
class FeatureValidator {
  const FeatureValidator();

  Future<ValidationResult> validateForCreate() async {
    return const ValidationValid();
  }

  Future<ValidationResult> validateForUpdate() async {
    return const ValidationValid();
  }
}
