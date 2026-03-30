import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/features/feature/data/repositories/feature_repository.dart';

void main() {
  late AppDatabase db;
  late FeatureRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = FeatureRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('FeatureRepository', () {
    test('creates a feature and retrieves it by id', () async {
      final feature = await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'J. Murphy',
        date: DateTime(2024, 6, 15),
      );

      expect(feature.site, 'Carrowmore');
      expect(feature.featureNumber, '001');

      final fetched = await repo.getById(feature.id);
      expect(fetched, isNotNull);
      expect(fetched!.id, feature.id);
    });

    test('getAll returns features sorted by updatedAt desc', () async {
      await repo.create(
        site: 'Site A',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Excavator',
        date: DateTime(2024, 1, 1),
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await repo.create(
        site: 'Site B',
        trench: 'T2',
        area: 'A1',
        featureNumber: '002',
        excavator: 'Excavator',
        date: DateTime(2024, 1, 2),
      );

      final all = await repo.getAll();
      expect(all.length, 2);
      // Most recently created first
      expect(all.first.site, 'Site B');
    });

    test('search returns matching features', () async {
      await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Murphy',
        date: DateTime.now(),
      );
      await repo.create(
        site: 'Knocknarea',
        trench: 'T2',
        area: 'B2',
        featureNumber: '002',
        excavator: 'Smith',
        date: DateTime.now(),
      );

      final results = await repo.search('carrow');
      expect(results.length, 1);
      expect(results.first.site, 'Carrowmore');
    });

    test('update modifies existing feature', () async {
      final original = await repo.create(
        site: 'Site',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Excavator',
        date: DateTime.now(),
      );

      final updated = await repo.update(
        id: original.id,
        site: 'Updated Site',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'New Excavator',
        date: original.date,
      );

      expect(updated.site, 'Updated Site');
      expect(updated.excavator, 'New Excavator');
      expect(updated.updatedAt.isAfter(original.updatedAt) ||
          updated.updatedAt == original.updatedAt, isTrue);
    });

    test('delete removes feature and it is no longer retrievable', () async {
      final feature = await repo.create(
        site: 'Site',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Excavator',
        date: DateTime.now(),
      );

      await repo.delete(feature.id);
      final fetched = await repo.getById(feature.id);
      expect(fetched, isNull);
    });

    test('existsBySitetrenchAreaNumber returns true for duplicate', () async {
      await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Excavator',
        date: DateTime.now(),
      );

      final exists = await repo.existsBySitetrenchAreaNumber(
        site: 'carrowmore', // case-insensitive
        trench: 't1',
        area: 'a1',
        featureNumber: '001',
      );
      expect(exists, isTrue);
    });

    test('existsBySitetrenchAreaNumber returns false when excludeId matches',
        () async {
      final feature = await repo.create(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excavator: 'Excavator',
        date: DateTime.now(),
      );

      final exists = await repo.existsBySitetrenchAreaNumber(
        site: 'Carrowmore',
        trench: 'T1',
        area: 'A1',
        featureNumber: '001',
        excludeId: feature.id,
      );
      expect(exists, isFalse);
    });
  });
}
