import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/validation_result.dart';
import '../../../context/data/repositories/context_repository.dart';
import '../../../context/domain/models/context_model.dart';
import '../../data/repositories/sample_repository.dart';

class SampleValidator {
  const SampleValidator(this._sampleRepository, this._contextRepository);

  final SampleRepository _sampleRepository;
  final ContextRepository _contextRepository;

  Future<ValidationResult> validateSampleNumber({
    required int sampleNumber,
    String? excludeId,
  }) async {
    if (sampleNumber <= 0) {
      return const ValidationInvalid('Sample number must be a positive integer');
    }

    final exists = await _sampleRepository.sampleNumberExistsGlobally(
      sampleNumber: sampleNumber,
      excludeId: excludeId,
    );

    if (exists) {
      return ValidationWarning(
        '${ValidationMessages.sampleNumberExists} (S$sampleNumber). Save anyway?',
      );
    }

    return const ValidationValid();
  }

  Future<ValidationResult> validateFill({
    required String featureId,
    required String fillId,
  }) async {
    final fill = await _contextRepository.getById(fillId);
    if (fill == null) {
      return const ValidationInvalid('Selected fill does not exist');
    }
    if (fill.featureId != featureId) {
      return const ValidationInvalid(
        'Selected fill does not belong to this feature',
      );
    }
    if (fill is! FillModel) {
      return const ValidationInvalid('Selected context is not a fill');
    }
    return const ValidationValid();
  }
}
