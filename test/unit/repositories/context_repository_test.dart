import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/constants/enums.dart';
import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/features/feature/data/repositories/feature_repository.dart';
import 'package:context_log/features/context/data/repositories/context_repository.dart';
import 'package:context_log/features/context/domain/models/context_model.dart';
import 'package:context_log/features/project/data/repositories/project_repository.dart';

void main() {
  late AppDatabase db;
  late FeatureRepository featureRepo;
  late ContextRepository contextRepo;
  late ProjectRepository projectRepo;
  late String featureId;
  late String projectId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    featureRepo = FeatureRepository(db);
    contextRepo = ContextRepository(db);
    projectRepo = ProjectRepository(db);

    final project = await projectRepo.create(name: 'Test Site');
    projectId = project.id;
    final feature = await featureRepo.create(projectId: projectId, area: 'A1');
    featureId = feature.id;
  });

  tearDown(() async {
    await db.close();
  });

  group('ContextRepository — cuts', () {
    test('creates a cut and retrieves it', () async {
      final cut = await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
        depth: 0.45,
      );

      expect(cut, isA<CutModel>());
      final c = cut as CutModel;
      expect(c.contextNumber, 100);
      expect(c.cutType, CutType.pit);
      expect(c.depth, 0.45);
    });

    test('getCutsByFeatureId returns only cuts', () async {
      await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );
      final cut = await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 101,
        cutType: CutType.ditch,
      );
      await contextRepo.createFill(
        featureId: featureId,
        contextNumber: 102,
        parentCutId: cut.id,
      );

      final cuts = await contextRepo.getCutsByFeatureId(featureId);
      expect(cuts.length, 2);
      expect(cuts.every((c) => c is CutModel), isTrue);
    });

    test('contextNumberExistsInFeature returns true for duplicate', () async {
      await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );

      final exists = await contextRepo.contextNumberExistsInFeature(
        featureId: featureId,
        contextNumber: 100,
      );
      expect(exists, isTrue);
    });

    test('contextNumberExistsInFeature returns false for different feature',
        () async {
      final otherFeature = await featureRepo.create(projectId: projectId, area: 'A2');
      await contextRepo.createCut(
        featureId: otherFeature.id,
        contextNumber: 100,
        cutType: CutType.pit,
      );

      final exists = await contextRepo.contextNumberExistsInFeature(
        featureId: featureId,
        contextNumber: 100,
      );
      expect(exists, isFalse);
    });
  });

  group('ContextRepository — fills', () {
    late String cutId;

    setUp(() async {
      final cut = await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );
      cutId = cut.id;
    });

    test('creates a fill referencing a cut', () async {
      final fill = await contextRepo.createFill(
        featureId: featureId,
        contextNumber: 101,
        parentCutId: cutId,
        color: 'Mid brown',
        composition: 'Silty loam',
      );

      expect(fill, isA<FillModel>());
      final f = fill as FillModel;
      expect(f.contextNumber, 101);
      expect(f.parentCutId, cutId);
      expect(f.color, 'Mid brown');
    });

    test('getFillsByCutId returns fills for that cut', () async {
      await contextRepo.createFill(
        featureId: featureId,
        contextNumber: 101,
        parentCutId: cutId,
      );
      await contextRepo.createFill(
        featureId: featureId,
        contextNumber: 102,
        parentCutId: cutId,
      );

      final fills = await contextRepo.getFillsByCutId(cutId);
      expect(fills.length, 2);
      expect(fills.every((f) => (f as FillModel).parentCutId == cutId), isTrue);
    });
  });

  group('ContextRepository — delete', () {
    test('deletes a context', () async {
      final cut = await contextRepo.createCut(
        featureId: featureId,
        contextNumber: 100,
        cutType: CutType.pit,
      );
      await contextRepo.delete(cut.id);
      final result = await contextRepo.getById(cut.id);
      expect(result, isNull);
    });
  });
}
