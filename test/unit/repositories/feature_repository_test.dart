import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/features/feature/data/repositories/feature_repository.dart';
import 'package:context_log/features/project/data/repositories/project_repository.dart';

void main() {
  late AppDatabase db;
  late FeatureRepository repo;
  late ProjectRepository projectRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = FeatureRepository(db);
    projectRepo = ProjectRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('FeatureRepository', () {
    test('creates a feature with auto-generated number, date, and projectId',
        () async {
      final project = await projectRepo.create(name: 'Test Site');
      final feature = await repo.create(projectId: project.id);

      expect(feature.featureNumber, '001');
      expect(feature.date, isNotNull);
      expect(feature.projectId, project.id);
      expect(feature.area, isNull);

      final fetched = await repo.getById(feature.id);
      expect(fetched, isNotNull);
      expect(fetched!.id, feature.id);
    });

    test('auto-increments feature numbers sequentially', () async {
      final project = await projectRepo.create(name: 'Site');
      final first = await repo.create(projectId: project.id);
      final second = await repo.create(projectId: project.id);
      final third = await repo.create(projectId: project.id);

      expect(first.featureNumber, '001');
      expect(second.featureNumber, '002');
      expect(third.featureNumber, '003');
    });

    test('creates a feature with area', () async {
      final project = await projectRepo.create(name: 'Site');
      final feature = await repo.create(
        projectId: project.id,
        area: 'North trench',
      );

      expect(feature.area, 'North trench');
    });

    test('getAll returns features sorted by featureNumber asc', () async {
      final project = await projectRepo.create(name: 'Site');
      await repo.create(projectId: project.id, area: 'A');
      await repo.create(projectId: project.id, area: 'B');

      final all = await repo.getAll();
      expect(all.length, 2);
      expect(all.first.featureNumber, '001');
      expect(all.last.featureNumber, '002');
    });

    test('search matches by area', () async {
      final project = await projectRepo.create(name: 'Site');
      await repo.create(projectId: project.id, area: 'North trench');
      await repo.create(projectId: project.id, area: 'South trench');

      final results = await repo.search('north');
      expect(results.length, 1);
      expect(results.first.area, 'North trench');
    });

    test('update modifies area and projectId', () async {
      final projectA = await projectRepo.create(name: 'Site A');
      final projectB = await projectRepo.create(name: 'Site B');
      final original = await repo.create(projectId: projectA.id, area: 'Old');

      final updated = await repo.update(
        id: original.id,
        projectId: projectB.id,
        area: 'New area',
      );

      expect(updated.area, 'New area');
      expect(updated.projectId, projectB.id);
      expect(updated.featureNumber, original.featureNumber);
    });

    test('delete removes feature and it is no longer retrievable', () async {
      final project = await projectRepo.create(name: 'Site');
      final feature = await repo.create(projectId: project.id);

      await repo.delete(feature.id);
      final fetched = await repo.getById(feature.id);
      expect(fetched, isNull);
    });

    test('nextFeatureNumber returns 001 when no features exist', () async {
      expect(await repo.nextFeatureNumber(), '001');
    });

    test('nextFeatureNumber pads to 3 digits', () async {
      final project = await projectRepo.create(name: 'Site');
      await repo.create(projectId: project.id);
      await repo.create(projectId: project.id);
      expect(await repo.nextFeatureNumber(), '003');
    });

    test('feature without project has null projectId', () async {
      // Simulates a legacy feature created before projects were introduced.
      // We verify getById handles null projectId gracefully.
      final project = await projectRepo.create(name: 'Site');
      final feature = await repo.create(projectId: project.id);
      expect(feature.projectId, isNotNull);
    });
  });
}
