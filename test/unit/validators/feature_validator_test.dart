import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/core/utils/validation_result.dart';
import 'package:context_log/features/feature/data/repositories/feature_repository.dart';
import 'package:context_log/features/feature/domain/validators/feature_validator.dart';

void main() {
  late AppDatabase db;
  late FeatureRepository repo;
  late FeatureValidator validator;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = FeatureRepository(db);
    validator = FeatureValidator(repo);
  });

  tearDown(() async {
    await db.close();
  });

  group('FeatureValidator', () {
    test('validateForCreate returns Valid for unique feature', () async {
      final result = await validator.validateForCreate(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Murphy',
      );
      expect(result, isA<ValidationValid>());
    });

    test('validateForCreate returns Invalid for duplicate feature', () async {
      await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Murphy',
        date: DateTime.now(),
      );

      final result = await validator.validateForCreate(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Smith',
      );
      expect(result, isA<ValidationInvalid>());
    });

    test('validateForCreate returns Invalid for empty required fields',
        () async {
      final result = await validator.validateForCreate(
        site: '',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Murphy',
      );
      expect(result, isA<ValidationInvalid>());
    });

    test('validateForUpdate allows editing own record', () async {
      final feature = await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Murphy',
        date: DateTime.now(),
      );

      final result = await validator.validateForUpdate(
        id: feature.id,
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Updated Excavator',
      );
      expect(result, isA<ValidationValid>());
    });

    test('validateForUpdate returns Invalid when duplicate feature exists',
        () async {
      await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Murphy',
        date: DateTime.now(),
      );
      final other = await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '002',
        excavator: 'Smith',
        date: DateTime.now(),
      );

      // Try to rename other to same number as first feature
      final result = await validator.validateForUpdate(
        id: other.id,
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Smith',
      );
      expect(result, isA<ValidationInvalid>());
    });
  });
}
