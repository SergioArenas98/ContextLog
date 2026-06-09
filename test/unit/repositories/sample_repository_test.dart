import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/constants/enums.dart';
import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/features/context/data/repositories/context_repository.dart';
import 'package:context_log/features/feature/data/repositories/feature_repository.dart';
import 'package:context_log/features/project/data/repositories/project_repository.dart';
import 'package:context_log/features/sample/data/repositories/sample_repository.dart';

void main() {
  late AppDatabase db;
  late ProjectRepository projectRepo;
  late FeatureRepository featureRepo;
  late ContextRepository contextRepo;
  late SampleRepository sampleRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    projectRepo = ProjectRepository(db);
    featureRepo = FeatureRepository(db);
    contextRepo = ContextRepository(db);
    sampleRepo = SampleRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  /// Creates project -> feature -> cut -> fill and returns ids for sampling.
  Future<({String featureId, String fillId, String cutId})> scaffold() async {
    final project = await projectRepo.create(name: 'Site');
    final feature = await featureRepo.create(projectId: project.id);
    final cut = await contextRepo.createCut(
      featureId: feature.id,
      contextNumber: 1,
    );
    final fill = await contextRepo.createFill(
      featureId: feature.id,
      contextNumber: 2,
      parentCutId: cut.id,
    );
    return (featureId: feature.id, fillId: fill.id, cutId: cut.id);
  }

  group('SampleRepository sample types', () {
    test('persists and reads back the new bone sample types', () async {
      final ctx = await scaffold();

      final animal = await sampleRepo.create(
        featureId: ctx.featureId,
        fillId: ctx.fillId,
        cutId: ctx.cutId,
        sampleNumber: 1,
        sampleType: SampleType.animalBone,
        storageType: StorageType.bag,
      );
      final human = await sampleRepo.create(
        featureId: ctx.featureId,
        fillId: ctx.fillId,
        cutId: ctx.cutId,
        sampleNumber: 2,
        sampleType: SampleType.humanBone,
        storageType: StorageType.bag,
      );

      expect(
        (await sampleRepo.getById(animal.id))!.sampleType,
        SampleType.animalBone,
      );
      expect(
        (await sampleRepo.getById(human.id))!.sampleType,
        SampleType.humanBone,
      );
    });

    test(
      'legacy bulk/pollen rows read back as other without crashing',
      () async {
        final ctx = await scaffold();

        final bulk = await sampleRepo.create(
          featureId: ctx.featureId,
          fillId: ctx.fillId,
          cutId: ctx.cutId,
          sampleNumber: 10,
          sampleType: SampleType.soil,
          storageType: StorageType.bag,
        );
        final pollen = await sampleRepo.create(
          featureId: ctx.featureId,
          fillId: ctx.fillId,
          cutId: ctx.cutId,
          sampleNumber: 11,
          sampleType: SampleType.soil,
          storageType: StorageType.bag,
        );

        // Simulate rows written by an older app version, before the enum
        // values were removed.
        await db.customStatement(
          'UPDATE samples SET sample_type = ? WHERE id = ?',
          ['bulk', bulk.id],
        );
        await db.customStatement(
          'UPDATE samples SET sample_type = ? WHERE id = ?',
          ['pollen', pollen.id],
        );

        final samples = await sampleRepo.getByFeatureId(ctx.featureId);
        expect(samples.length, 2);
        expect(samples.every((s) => s.sampleType == SampleType.other), isTrue);
      },
    );
  });
}

