import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/utils/validation_result.dart';
import 'package:context_log/features/project/domain/validators/project_validator.dart';

void main() {
  const validator = ProjectValidator();

  group('ProjectValidator.validateName', () {
    test('returns ValidationInvalid for empty string', () {
      final result = validator.validateName('');
      expect(result, isA<ValidationInvalid>());
    });

    test('returns ValidationInvalid for whitespace-only string', () {
      final result = validator.validateName('   ');
      expect(result, isA<ValidationInvalid>());
    });

    test('returns ValidationInvalid for null', () {
      final result = validator.validateName(null);
      expect(result, isA<ValidationInvalid>());
    });

    test('returns ValidationValid for non-empty name', () {
      final result = validator.validateName('Northgate Site');
      expect(result, isA<ValidationValid>());
    });
  });

  group('ProjectValidator.validateForCreate', () {
    test('valid with name provided', () {
      final result = validator.validateForCreate(name: 'Site A');
      expect(result, isA<ValidationValid>());
    });

    test('invalid with empty name', () {
      final result = validator.validateForCreate(name: '');
      expect(result, isA<ValidationInvalid>());
    });
  });

  group('ProjectValidator.validateForUpdate', () {
    test('valid with name provided', () {
      final result = validator.validateForUpdate(name: 'Site A');
      expect(result, isA<ValidationValid>());
    });

    test('invalid with empty name', () {
      final result = validator.validateForUpdate(name: '');
      expect(result, isA<ValidationInvalid>());
    });
  });
}
