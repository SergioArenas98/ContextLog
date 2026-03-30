import '../../../../core/utils/validation_result.dart';
import '../../../context/data/repositories/context_repository.dart';
import '../../../context/domain/models/context_model.dart';

class FindValidator {
  const FindValidator(this._contextRepository);

  final ContextRepository _contextRepository;

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

  Future<ValidationResult> validateNoFillsExist(String featureId) async {
    final fills = await _contextRepository.getFillsByFeatureId(featureId);
    if (fills.isEmpty) {
      return const ValidationInvalid(
        'No fills exist in this feature. Create a fill first.',
      );
    }
    return const ValidationValid();
  }
}
