import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/constants/enums.dart';
import '../../domain/models/photo_model.dart';

class PhotoRepository {
  PhotoRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<List<PhotoModel>> getByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.photosTable)
          ..where((t) => t.featureId.equals(featureId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt),
          ]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<PhotoModel?> getById(String id) async {
    final row = await (_db.select(_db.photosTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  Future<PhotoModel> create({
    required String featureId,
    required PhotoStage stage,
    String? manualCameraPhotoNumber,
    required CardinalOrientation cardinalOrientation,
    String? notes,
    String? localImagePath,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.photosTable).insert(
          PhotosTableCompanion.insert(
            id: id,
            featureId: featureId,
            stage: stage,
            manualCameraPhotoNumber: Value(manualCameraPhotoNumber),
            cardinalOrientation: Value(cardinalOrientation),
            notes: Value(notes),
            localImagePath: Value(localImagePath),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await getById(id))!;
  }

  Future<PhotoModel> update({
    required String id,
    required PhotoStage stage,
    String? manualCameraPhotoNumber,
    required CardinalOrientation cardinalOrientation,
    String? notes,
    String? localImagePath,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.photosTable)..where((t) => t.id.equals(id))).write(
      PhotosTableCompanion(
        stage: Value(stage),
        manualCameraPhotoNumber: Value(manualCameraPhotoNumber),
        cardinalOrientation: Value(cardinalOrientation),
        notes: Value(notes),
        localImagePath: Value(localImagePath),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.photosTable)..where((t) => t.id.equals(id))).go();
  }

  PhotoModel _rowToModel(PhotosTableData row) => PhotoModel(
        id: row.id,
        featureId: row.featureId,
        stage: row.stage,
        manualCameraPhotoNumber: row.manualCameraPhotoNumber,
        cardinalOrientation: row.cardinalOrientation,
        notes: row.notes,
        localImagePath: row.localImagePath,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
