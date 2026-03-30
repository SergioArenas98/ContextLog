import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/constants/enums.dart';
import '../../domain/models/context_model.dart';

class ContextRepository {
  ContextRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<List<ContextModel>> getByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.contextsTable)
          ..where((t) => t.featureId.equals(featureId))
          ..orderBy([(t) => OrderingTerm(expression: t.contextNumber)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<List<ContextModel>> getCutsByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.contextsTable)
          ..where(
            (t) =>
                t.featureId.equals(featureId) &
                t.contextType.equals(ContextType.cut.name),
          )
          ..orderBy([(t) => OrderingTerm(expression: t.contextNumber)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<List<ContextModel>> getFillsByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.contextsTable)
          ..where(
            (t) =>
                t.featureId.equals(featureId) &
                t.contextType.equals(ContextType.fill.name),
          )
          ..orderBy([(t) => OrderingTerm(expression: t.contextNumber)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<List<ContextModel>> getFillsByCutId(String cutId) async {
    final rows = await (_db.select(_db.contextsTable)
          ..where((t) => t.parentCutId.equals(cutId))
          ..orderBy([(t) => OrderingTerm(expression: t.contextNumber)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<ContextModel?> getById(String id) async {
    final row = await (_db.select(_db.contextsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Returns true if context number already exists in the feature.
  Future<bool> contextNumberExistsInFeature({
    required String featureId,
    required int contextNumber,
    String? excludeId,
  }) async {
    var query = _db.select(_db.contextsTable)
      ..where(
        (t) =>
            t.featureId.equals(featureId) &
            t.contextNumber.equals(contextNumber),
      );
    if (excludeId != null) {
      query = query..where((t) => t.id.equals(excludeId).not());
    }
    final row = await query.getSingleOrNull();
    return row != null;
  }

  Future<ContextModel> createCut({
    required String featureId,
    required int contextNumber,
    CutType? cutType,
    String? customCutTypeText,
    double? height,
    double? width,
    double? depth,
    String? notes,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.contextsTable).insert(
          ContextsTableCompanion.insert(
            id: id,
            featureId: featureId,
            contextNumber: contextNumber,
            contextType: ContextType.cut,
            cutType: Value(cutType),
            customCutTypeText: Value(customCutTypeText),
            height: Value(height),
            width: Value(width),
            depth: Value(depth),
            notes: Value(notes),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await getById(id))!;
  }

  Future<ContextModel> createFill({
    required String featureId,
    required int contextNumber,
    required String parentCutId,
    String? composition,
    String? color,
    String? compaction,
    String? inclusions,
    String? notes,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.contextsTable).insert(
          ContextsTableCompanion.insert(
            id: id,
            featureId: featureId,
            contextNumber: contextNumber,
            contextType: ContextType.fill,
            parentCutId: Value(parentCutId),
            composition: Value(composition),
            color: Value(color),
            compaction: Value(compaction),
            inclusions: Value(inclusions),
            notes: Value(notes),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await getById(id))!;
  }

  Future<ContextModel> updateCut({
    required String id,
    required int contextNumber,
    CutType? cutType,
    String? customCutTypeText,
    double? height,
    double? width,
    double? depth,
    String? notes,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.contextsTable)..where((t) => t.id.equals(id))).write(
      ContextsTableCompanion(
        contextNumber: Value(contextNumber),
        cutType: Value(cutType),
        customCutTypeText: Value(customCutTypeText),
        height: Value(height),
        width: Value(width),
        depth: Value(depth),
        notes: Value(notes),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  Future<ContextModel> updateFill({
    required String id,
    required int contextNumber,
    required String parentCutId,
    String? composition,
    String? color,
    String? compaction,
    String? inclusions,
    String? notes,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.contextsTable)..where((t) => t.id.equals(id))).write(
      ContextsTableCompanion(
        contextNumber: Value(contextNumber),
        parentCutId: Value(parentCutId),
        composition: Value(composition),
        color: Value(color),
        compaction: Value(compaction),
        inclusions: Value(inclusions),
        notes: Value(notes),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.contextsTable)..where((t) => t.id.equals(id))).go();
  }

  ContextModel _rowToModel(ContextsTableData row) {
    return switch (row.contextType) {
      ContextType.cut => ContextModel.cut(
          id: row.id,
          featureId: row.featureId,
          contextNumber: row.contextNumber,
          cutType: row.cutType,
          customCutTypeText: row.customCutTypeText,
          height: row.height,
          width: row.width,
          depth: row.depth,
          notes: row.notes,
          createdAt: row.createdAt,
          updatedAt: row.updatedAt,
        ),
      ContextType.fill => ContextModel.fill(
          id: row.id,
          featureId: row.featureId,
          contextNumber: row.contextNumber,
          parentCutId: row.parentCutId ?? '',
          composition: row.composition,
          color: row.color,
          compaction: row.compaction,
          inclusions: row.inclusions,
          notes: row.notes,
          createdAt: row.createdAt,
          updatedAt: row.updatedAt,
        ),
    };
  }
}
