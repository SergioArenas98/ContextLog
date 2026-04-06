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
    test('creates a feature with auto-generated number and date', () async {
      final feature = await repo.create();

      expect(feature.featureNumber, '001');
      expect(feature.date, isNotNull);
      expect(feature.rubiconCode, isNull);
      expect(feature.license, isNull);
      expect(feature.area, isNull);

      final fetched = await repo.getById(feature.id);
      expect(fetched, isNotNull);
      expect(fetched!.id, feature.id);
    });

    test('auto-increments feature numbers sequentially', () async {
      final first = await repo.create();
      final second = await repo.create();
      final third = await repo.create();

      expect(first.featureNumber, '001');
      expect(second.featureNumber, '002');
      expect(third.featureNumber, '003');
    });

    test('creates a feature with optional metadata', () async {
      final feature = await repo.create(
        rubiconCode: 'RC-2024-001',
        license: 'LIC-12345',
        area: 'North trench',
      );

      expect(feature.rubiconCode, 'RC-2024-001');
      expect(feature.license, 'LIC-12345');
      expect(feature.area, 'North trench');
    });

    test('getAll returns features sorted by featureNumber asc', () async {
      await repo.create(area: 'A');
      await repo.create(area: 'B');

      final all = await repo.getAll();
      expect(all.length, 2);
      expect(all.first.featureNumber, '001');
      expect(all.last.featureNumber, '002');
    });

    test('search matches by area', () async {
      await repo.create(area: 'North trench');
      await repo.create(area: 'South trench');

      final results = await repo.search('north');
      expect(results.length, 1);
      expect(results.first.area, 'North trench');
    });

    test('search matches by rubiconCode', () async {
      await repo.create(rubiconCode: 'RC-001');
      await repo.create(rubiconCode: 'RC-002');

      final results = await repo.search('RC-001');
      expect(results.length, 1);
      expect(results.first.rubiconCode, 'RC-001');
    });

    test('update modifies optional fields', () async {
      final original = await repo.create(area: 'Old area');

      final updated = await repo.update(
        id: original.id,
        area: 'New area',
        rubiconCode: 'RC-2024',
      );

      expect(updated.area, 'New area');
      expect(updated.rubiconCode, 'RC-2024');
      expect(updated.featureNumber, original.featureNumber);
    });

    test('delete removes feature and it is no longer retrievable', () async {
      final feature = await repo.create();

      await repo.delete(feature.id);
      final fetched = await repo.getById(feature.id);
      expect(fetched, isNull);
    });

    test('nextFeatureNumber returns 001 when no features exist', () async {
      expect(await repo.nextFeatureNumber(), '001');
    });

    test('nextFeatureNumber pads to 3 digits', () async {
      await repo.create(); // 001
      await repo.create(); // 002
      expect(await repo.nextFeatureNumber(), '003');
    });
  });
}
