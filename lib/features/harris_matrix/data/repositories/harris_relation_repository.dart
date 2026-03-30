import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/constants/enums.dart';
import '../../domain/models/harris_relation_model.dart';

class HarrisRelationRepository {
  HarrisRelationRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<List<HarrisRelationModel>> getByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.harrisRelationsTable)
          ..where((t) => t.featureId.equals(featureId))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<HarrisRelationModel?> getById(String id) async {
    final row = await (_db.select(_db.harrisRelationsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  Future<bool> relationExists({
    required String fromContextId,
    required String toContextId,
    String? excludeId,
  }) async {
    var query = _db.select(_db.harrisRelationsTable)
      ..where(
        (t) =>
            t.fromContextId.equals(fromContextId) &
            t.toContextId.equals(toContextId),
      );
    if (excludeId != null) {
      query = query..where((t) => t.id.equals(excludeId).not());
    }
    final row = await query.getSingleOrNull();
    return row != null;
  }

  Future<HarrisRelationModel> create({
    required String featureId,
    required String fromContextId,
    required String toContextId,
    required HarrisRelationType relationType,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.harrisRelationsTable).insert(
          HarrisRelationsTableCompanion.insert(
            id: id,
            featureId: featureId,
            fromContextId: fromContextId,
            toContextId: toContextId,
            relationType: relationType,
            createdAt: now,
          ),
        );
    return (await getById(id))!;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.harrisRelationsTable)..where((t) => t.id.equals(id)))
        .go();
  }

  HarrisRelationModel _rowToModel(HarrisRelationsTableData row) =>
      HarrisRelationModel(
        id: row.id,
        featureId: row.featureId,
        fromContextId: row.fromContextId,
        toContextId: row.toContextId,
        relationType: row.relationType,
        createdAt: row.createdAt,
      );
}
