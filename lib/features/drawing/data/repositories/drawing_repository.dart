import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/drawing_model.dart';

class DrawingRepository {
  DrawingRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<List<DrawingModel>> getByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.drawingsTable)
          ..where((t) => t.featureId.equals(featureId))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<DrawingModel?> getById(String id) async {
    final row = await (_db.select(_db.drawingsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  Future<DrawingModel> create({
    required String featureId,
    required String drawingNumber,
    String? boardNumber,
    DrawingType? drawingType,
    CardinalOrientation facing = CardinalOrientation.unknown,
    String? notes,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.drawingsTable).insert(
          DrawingsTableCompanion.insert(
            id: id,
            featureId: featureId,
            drawingNumber: drawingNumber,
            boardNumber: Value(boardNumber),
            drawingType: Value(drawingType),
            facing: Value(facing),
            notes: Value(notes),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await getById(id))!;
  }

  Future<DrawingModel> update({
    required String id,
    required String drawingNumber,
    String? boardNumber,
    DrawingType? drawingType,
    CardinalOrientation facing = CardinalOrientation.unknown,
    String? notes,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.drawingsTable)..where((t) => t.id.equals(id))).write(
      DrawingsTableCompanion(
        drawingNumber: Value(drawingNumber),
        boardNumber: Value(boardNumber),
        drawingType: Value(drawingType),
        facing: Value(facing),
        notes: Value(notes),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.drawingsTable)..where((t) => t.id.equals(id))).go();
  }

  DrawingModel _rowToModel(DrawingsTableData row) => DrawingModel(
        id: row.id,
        featureId: row.featureId,
        drawingNumber: row.drawingNumber,
        boardNumber: row.boardNumber,
        drawingType: row.drawingType,
        facing: row.facing,
        notes: row.notes,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
