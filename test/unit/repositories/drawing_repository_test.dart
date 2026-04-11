import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_log/core/database/app_database.dart';
import 'package:context_log/core/constants/enums.dart';
import 'package:context_log/features/drawing/data/repositories/drawing_repository.dart';
import 'package:context_log/features/feature/data/repositories/feature_repository.dart';
import 'package:context_log/features/project/data/repositories/project_repository.dart';

void main() {
  late AppDatabase db;
  late DrawingRepository repo;
  late FeatureRepository featureRepo;
  late ProjectRepository projectRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DrawingRepository(db);
    featureRepo = FeatureRepository(db);
    projectRepo = ProjectRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  /// Helper: creates a project + feature and returns the feature id.
  Future<String> _createFeature() async {
    final project = await projectRepo.create(name: 'Test Site');
    final feature = await featureRepo.create(projectId: project.id);
    return feature.id;
  }

  group('DrawingRepository', () {
    test('creates a drawing with required fields', () async {
      final fid = await _createFeature();
      final drawing = await repo.create(
        featureId: fid,
        drawingNumber: 'D01',
      );

      expect(drawing.drawingNumber, 'D01');
      expect(drawing.featureId, fid);
      expect(drawing.referenceImagePath, isNull);
      expect(drawing.boardNumber, isNull);
      expect(drawing.notes, isNull);
    });

    test('creates a drawing with referenceImagePath', () async {
      final fid = await _createFeature();
      final drawing = await repo.create(
        featureId: fid,
        drawingNumber: 'D02',
        referenceImagePath: '/storage/emulated/0/ref.jpg',
      );

      expect(drawing.referenceImagePath, '/storage/emulated/0/ref.jpg');

      final fetched = await repo.getById(drawing.id);
      expect(fetched, isNotNull);
      expect(fetched!.referenceImagePath, '/storage/emulated/0/ref.jpg');
    });

    test('update persists referenceImagePath', () async {
      final fid = await _createFeature();
      final drawing = await repo.create(
        featureId: fid,
        drawingNumber: 'D03',
      );
      expect(drawing.referenceImagePath, isNull);

      final updated = await repo.update(
        id: drawing.id,
        drawingNumber: 'D03',
        referenceImagePath: '/storage/emulated/0/updated.jpg',
      );

      expect(updated.referenceImagePath, '/storage/emulated/0/updated.jpg');
    });

    test('update clears referenceImagePath when null passed', () async {
      final fid = await _createFeature();
      final drawing = await repo.create(
        featureId: fid,
        drawingNumber: 'D04',
        referenceImagePath: '/storage/emulated/0/old.jpg',
      );

      final updated = await repo.update(
        id: drawing.id,
        drawingNumber: 'D04',
        referenceImagePath: null,
      );

      expect(updated.referenceImagePath, isNull);
    });

    test('delete removes the record', () async {
      final fid = await _createFeature();
      final drawing = await repo.create(
        featureId: fid,
        drawingNumber: 'D05',
      );

      await repo.delete(drawing.id);

      final fetched = await repo.getById(drawing.id);
      expect(fetched, isNull);
    });

    test('getByFeatureId returns all drawings for a feature', () async {
      final fid = await _createFeature();
      await repo.create(featureId: fid, drawingNumber: 'D01');
      await repo.create(featureId: fid, drawingNumber: 'D02');

      final drawings = await repo.getByFeatureId(fid);
      expect(drawings.length, 2);
      expect(drawings.map((d) => d.drawingNumber),
          containsAll(['D01', 'D02']));
    });

    test('drawing supports all optional fields', () async {
      final fid = await _createFeature();
      final drawing = await repo.create(
        featureId: fid,
        drawingNumber: 'D06',
        boardNumber: 'B2',
        drawingType: DrawingType.section,
        facing: CardinalOrientation.n,
        notes: 'North wall section',
        referenceImagePath: '/path/to/image.png',
      );

      expect(drawing.boardNumber, 'B2');
      expect(drawing.drawingType, DrawingType.section);
      expect(drawing.facing, CardinalOrientation.n);
      expect(drawing.notes, 'North wall section');
      expect(drawing.referenceImagePath, '/path/to/image.png');
    });
  });
}
