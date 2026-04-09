import '../../../../core/utils/validation_result.dart';

/// Validator for project creation and update.
class ProjectValidator {
  const ProjectValidator();

  ValidationResult validateName(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return const ValidationInvalid('Site name is required');
    }
    return const ValidationValid();
  }

  ValidationResult validateForCreate({required String name}) {
    return validateName(name);
  }

  ValidationResult validateForUpdate({required String name}) {
    return validateName(name);
  }
}
