import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/utils/validation_result.dart';
import 'package:context_log/features/feature/domain/validators/feature_validator.dart';

void main() {
  late FeatureValidator validator;

  setUp(() {
    validator = const FeatureValidator();
  });

  group('FeatureValidator', () {
    test('validateForCreate always returns Valid', () async {
      final result = await validator.validateForCreate();
      expect(result, isA<ValidationValid>());
    });

    test('validateForUpdate always returns Valid', () async {
      final result = await validator.validateForUpdate();
      expect(result, isA<ValidationValid>());
    });
  });
}
