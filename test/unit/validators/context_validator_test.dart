import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/constants/enums.dart';
import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/core/utils/validation_result.dart';
import 'package:context_log/features/feature/data/repositories/feature_repository.dart';
import 'package:context_log/features/context/data/repositories/context_repository.dart';
import 'package:context_log/features/context/domain/validators/context_validator.dart';
import 'package:context_log/features/project/data/repositories/project_repository.dart';

void main() {
  late AppDatabase db;
  late FeatureRepository featureRepo;
  late ContextRepository contextRepo;
  late ContextValidator validator;
  late ProjectRepository projectRepo;
  late String featureId;
  late String projectId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    featureRepo = FeatureRepository(db);
    contextRepo = ContextRepository(db);
    validator = ContextValidator(contextRepo);
    projectRepo = ProjectRepository(db);

    final project = await projectRepo.create(name: 'Test Site');
    projectId = project.id;
    final feature = await featureRepo.create(projectId: projectId, area: 'A1');
    featureId = feature.id;
  });

  tearDown(() async {
    await db.close();
  });

  group('ContextValidator.validateContextNumber', () {
    test('returns Valid for unique context number', () async {
      final result = await validator.validateContextNumber(
        featureId: featureId,
        contextNumber: 100,
      );
      expect(result, isA<ValidationValid>());
    });

    test('returns Invalid for non-positive context number', () async {
      final result = await validator.validateContextNumber(
        featureId: featureId,
        contextNumber: 0,
      );
      expect(result, isA<ValidationInvalid>());
    });

    test('returns Warning for duplicate context number', () async {
      await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );

      final result = await validator.validateContextNumber(
        featureId: featureId,
        contextNumber: 100,
      );
      expect(result, isA<ValidationWarning>());
    });

    test('returns Valid when excludeId matches the existing record', () async {
      final cut = await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );

      final result = await validator.validateContextNumber(
        featureId: featureId,
        contextNumber: 100,
        excludeId: cut.id,
      );
      expect(result, isA<ValidationValid>());
    });

    test('same number in different feature does not trigger warning', () async {
      final other = await featureRepo.create(projectId: projectId, area: 'A2');
      await contextRepo.createCut(
        featureId: other.id,
        contextNumber: 100,
        cutType: CutType.pit,
      );

      final result = await validator.validateContextNumber(
        featureId: featureId,
        contextNumber: 100,
      );
      expect(result, isA<ValidationValid>());
    });
  });

  group('ContextValidator.validateFill', () {
    test('returns Valid when parent cut is in the same feature', () async {
      final cut = await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );

      final result = await validator.validateFill(
        featureId: featureId,
        contextNumber: 101,
        parentCutId: cut.id,
      );
      expect(result, isA<ValidationValid>());
    });

    test('returns Warning when fill number already exists (but cut is valid)',
        () async {
      final cut = await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );
      await contextRepo.createFill(
        featureId: featureId,
        contextNumber: 101,
        parentCutId: cut.id,
      );

      final result = await validator.validateFill(
        featureId: featureId,
        contextNumber: 101,
        parentCutId: cut.id,
      );
      expect(result, isA<ValidationWarning>());
    });

    test('returns Invalid when parent cut does not exist', () async {
      final result = await validator.validateFill(
        featureId: featureId,
        contextNumber: 101,
        parentCutId: 'nonexistent-id',
      );
      expect(result, isA<ValidationInvalid>());
    });

    test('returns Invalid when parent cut belongs to a different feature',
        () async {
      final other = await featureRepo.create(projectId: projectId, area: 'A2');
      final otherCut = await contextRepo.createCut(
        featureId: other.id,
        contextNumber: 100,
        cutType: CutType.pit,
      );

      final result = await validator.validateFill(
        featureId: featureId,
        contextNumber: 101,
        parentCutId: otherCut.id,
      );
      expect(result, isA<ValidationInvalid>());
    });
  });
}
