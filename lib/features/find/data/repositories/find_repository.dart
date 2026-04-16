import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/constants/enums.dart';
import '../../domain/models/find_model.dart';

class FindRepository {
  FindRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<List<FindModel>> getByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.findsTable)
          ..where((t) => t.featureId.equals(featureId))
          ..orderBy([(t) => OrderingTerm(expression: t.findNumber)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<List<FindModel>> getByFillId(String fillId) async {
    final rows = await (_db.select(_db.findsTable)
          ..where((t) => t.fillId.equals(fillId))
          ..orderBy([(t) => OrderingTerm(expression: t.findNumber)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<FindModel?> getById(String id) async {
    final row = await (_db.select(_db.findsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Suggests the next find number within a feature (max + 1, or 1 if none).
  Future<int> nextFindNumber(String featureId) async {
    final rows = await (_db.select(_db.findsTable)
          ..where((t) => t.featureId.equals(featureId))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.findNumber, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .get();
    if (rows.isEmpty) return 1;
    return rows.first.findNumber + 1;
  }

  Future<FindModel> create({
    required String featureId,
    required String fillId,
    required int findNumber,
    required FindMaterialType materialType,
    String? customMaterialText,
    required int quantity,
    String? description,
    String? localImagePath,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.findsTable).insert(
          FindsTableCompanion.insert(
            id: id,
            featureId: featureId,
            fillId: fillId,
            findNumber: findNumber,
            materialType: materialType,
            customMaterialText: Value(customMaterialText),
            quantity: Value(quantity),
            description: Value(description),
            localImagePath: Value(localImagePath),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await getById(id))!;
  }

  Future<FindModel> update({
    required String id,
    required String fillId,
    required int findNumber,
    required FindMaterialType materialType,
    String? customMaterialText,
    required int quantity,
    String? description,
    String? localImagePath,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.findsTable)..where((t) => t.id.equals(id))).write(
      FindsTableCompanion(
        fillId: Value(fillId),
        findNumber: Value(findNumber),
        materialType: Value(materialType),
        customMaterialText: Value(customMaterialText),
        quantity: Value(quantity),
        description: Value(description),
        localImagePath: Value(localImagePath),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.findsTable)..where((t) => t.id.equals(id))).go();
  }

  FindModel _rowToModel(FindsTableData row) => FindModel(
        id: row.id,
        featureId: row.featureId,
        fillId: row.fillId,
        findNumber: row.findNumber,
        materialType: row.materialType,
        customMaterialText: row.customMaterialText,
        quantity: row.quantity,
        description: row.description,
        localImagePath: row.localImagePath,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
