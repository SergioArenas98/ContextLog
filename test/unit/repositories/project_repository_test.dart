import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/features/project/data/repositories/project_repository.dart';

void main() {
  late AppDatabase db;
  late ProjectRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ProjectRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ProjectRepository', () {
    test('creates a project with required name', () async {
      final project = await repo.create(name: 'Northgate Site');

      expect(project.name, 'Northgate Site');
      expect(project.rubiconCode, isNull);
      expect(project.licenceNumber, isNull);
      expect(project.id, isNotEmpty);
    });

    test('creates a project with all fields', () async {
      final project = await repo.create(
        name: 'Roman Villa',
        rubiconCode: 'RC-2024-001',
        licenceNumber: 'LIC-99999',
      );

      expect(project.name, 'Roman Villa');
      expect(project.rubiconCode, 'RC-2024-001');
      expect(project.licenceNumber, 'LIC-99999');
    });

    test('getAll returns projects sorted by name asc', () async {
      await repo.create(name: 'Zebra Site');
      await repo.create(name: 'Alpha Site');

      final all = await repo.getAll();
      expect(all.length, 2);
      expect(all.first.name, 'Alpha Site');
      expect(all.last.name, 'Zebra Site');
    });

    test('getById returns null for unknown id', () async {
      final result = await repo.getById('nonexistent');
      expect(result, isNull);
    });

    test('update modifies name and optional fields', () async {
      final created = await repo.create(name: 'Old Name');

      final updated = await repo.update(
        id: created.id,
        name: 'New Name',
        rubiconCode: 'RC-UPDATED',
      );

      expect(updated.name, 'New Name');
      expect(updated.rubiconCode, 'RC-UPDATED');
      expect(updated.id, created.id);
    });

    test('update clears optional fields when passed empty strings', () async {
      final created = await repo.create(
        name: 'Site A',
        rubiconCode: 'RC-001',
        licenceNumber: 'LIC-001',
      );

      final updated = await repo.update(
        id: created.id,
        name: 'Site A',
        rubiconCode: '',
        licenceNumber: '',
      );

      expect(updated.rubiconCode, isNull);
      expect(updated.licenceNumber, isNull);
    });

    test('delete removes the project', () async {
      final project = await repo.create(name: 'To Delete');

      await repo.delete(project.id);
      final fetched = await repo.getById(project.id);
      expect(fetched, isNull);
    });

    test('trimming is applied to name on create', () async {
      final project = await repo.create(name: '  Trimmed  ');
      expect(project.name, 'Trimmed');
    });
  });
}
