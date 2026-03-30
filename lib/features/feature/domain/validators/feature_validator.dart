import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/validation_result.dart';
import '../../data/repositories/feature_repository.dart';

class FeatureValidator {
  const FeatureValidator(this._repository);

  final FeatureRepository _repository;

  Future<ValidationResult> validateForCreate({
    required String site,
    required String trench,
    required String area,
    required String featureNumber,
    required String excavator,
  }) async {
    final required = _validateRequiredFields(
      site: site,
      trench: trench,
      area: area,
      featureNumber: featureNumber,
      excavator: excavator,
    );
    if (required != null) return ValidationInvalid(required);

    final exists = await _repository.existsBySitetrenchAreaNumber(
      site: site,
      trench: trench,
      area: area,
      featureNumber: featureNumber,
    );
    if (exists) {
      return const ValidationInvalid(ValidationMessages.featureExists);
    }

    return const ValidationValid();
  }

  Future<ValidationResult> validateForUpdate({
    required String id,
    required String site,
    required String trench,
    required String area,
    required String featureNumber,
    required String excavator,
  }) async {
    final required = _validateRequiredFields(
      site: site,
      trench: trench,
      area: area,
      featureNumber: featureNumber,
      excavator: excavator,
    );
    if (required != null) return ValidationInvalid(required);

    final exists = await _repository.existsBySitetrenchAreaNumber(
      site: site,
      trench: trench,
      area: area,
      featureNumber: featureNumber,
      excludeId: id,
    );
    if (exists) {
      return const ValidationInvalid(ValidationMessages.featureExists);
    }

    return const ValidationValid();
  }

  String? _validateRequiredFields({
    required String site,
    required String trench,
    required String area,
    required String featureNumber,
    required String excavator,
  }) {
    if (site.trim().isEmpty) return 'Site is required';
    if (trench.trim().isEmpty) return 'Trench is required';
    if (area.trim().isEmpty) return 'Area is required';
    if (featureNumber.trim().isEmpty) return 'Feature number is required';
    if (excavator.trim().isEmpty) return 'Excavator is required';
    return null;
  }
}
