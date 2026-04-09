import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/models/feature_model.dart';

/// Repository for CRUD operations on archaeological features.
/// Maps between Drift row data and immutable [FeatureModel] domain objects.
class FeatureRepository {
  FeatureRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  /// Returns all features sorted by featureNumber ascending.
  Future<List<FeatureModel>> getAll() async {
    final rows = await (_db.select(_db.featuresTable)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.featureNumber,
                  mode: OrderingMode.asc,
                ),
          ]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  /// Returns features whose number or area matches [query].
  Future<List<FeatureModel>> search(String query) async {
    final lower = query.toLowerCase();
    final rows = await (_db.select(_db.featuresTable)
          ..where(
            (t) =>
                t.featureNumber.lower().contains(lower) |
                t.area.lower().contains(lower),
          )
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.featureNumber,
                  mode: OrderingMode.asc,
                ),
          ]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  /// Returns a single feature by [id], or null if not found.
  Future<FeatureModel?> getById(String id) async {
    final row = await (_db.select(_db.featuresTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Returns the next sequential feature number as a zero-padded 3-digit string.
  Future<String> nextFeatureNumber() async {
    final rows = await _db.select(_db.featuresTable).get();
    int maxNum = 0;
    for (final row in rows) {
      final parsed = int.tryParse(row.featureNumber);
      if (parsed != null && parsed > maxNum) maxNum = parsed;
    }
    return (maxNum + 1).toString().padLeft(3, '0');
  }

  /// Creates a new feature with auto-assigned number and date.
  /// [projectId] must reference a valid project.
  Future<FeatureModel> create({
    required String projectId,
    String? area,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    final featureNumber = await nextFeatureNumber();
    final companion = FeaturesTableCompanion.insert(
      id: id,
      featureNumber: featureNumber,
      projectId: Value(projectId),
      area: Value(area?.trim().isNotEmpty == true ? area!.trim() : null),
      date: now,
      createdAt: now,
      updatedAt: now,
    );
    await _db.into(_db.featuresTable).insert(companion);
    return (await getById(id))!;
  }

  /// Updates optional metadata on an existing feature.
  Future<FeatureModel> update({
    required String id,
    required String projectId,
    String? area,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.featuresTable)..where((t) => t.id.equals(id))).write(
      FeaturesTableCompanion(
        projectId: Value(projectId),
        area: Value(area?.trim().isNotEmpty == true ? area!.trim() : null),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  /// Deletes a feature by [id]. Cascades to all child records via FK constraints.
  Future<void> delete(String id) async {
    await (_db.delete(_db.featuresTable)..where((t) => t.id.equals(id))).go();
  }

  FeatureModel _rowToModel(FeaturesTableData row) => FeatureModel(
        id: row.id,
        featureNumber: row.featureNumber,
        projectId: row.projectId,
        area: row.area,
        date: row.date,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
