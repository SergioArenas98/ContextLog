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

  /// Returns all features sorted by most-recently-updated first.
  Future<List<FeatureModel>> getAll() async {
    final rows = await (_db.select(_db.featuresTable)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.updatedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  /// Returns features whose site, trench, area, or feature number matches [query].
  Future<List<FeatureModel>> search(String query) async {
    final lower = query.toLowerCase();
    final rows = await (_db.select(_db.featuresTable)
          ..where(
            (t) =>
                t.site.lower().contains(lower) |
                t.trench.lower().contains(lower) |
                t.area.lower().contains(lower) |
                t.featureNumber.lower().contains(lower) |
                t.excavator.lower().contains(lower),
          )
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.updatedAt,
                  mode: OrderingMode.desc,
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

  /// Returns true if a feature with the given combination already exists.
  /// Optionally excludes [excludeId] (used during edit to exclude self).
  Future<bool> existsBySitetrenchAreaNumber({
    required String site,
    required String trench,
    required String area,
    required String featureNumber,
    String? excludeId,
  }) async {
    var query = _db.select(_db.featuresTable)
      ..where(
        (t) =>
            t.site.lower().equals(site.toLowerCase()) &
            t.trench.lower().equals(trench.toLowerCase()) &
            t.area.lower().equals(area.toLowerCase()) &
            t.featureNumber.lower().equals(featureNumber.toLowerCase()),
      );
    if (excludeId != null) {
      query = query..where((t) => t.id.equals(excludeId).not());
    }
    final row = await query.getSingleOrNull();
    return row != null;
  }

  /// Creates a new feature and returns the created model.
  Future<FeatureModel> create({
    required String site,
    required String trench,
    required String area,
    required String featureNumber,
    required String excavator,
    required DateTime date,
    String? notes,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    final companion = FeaturesTableCompanion.insert(
      id: id,
      site: site,
      trench: trench,
      area: area,
      featureNumber: featureNumber,
      excavator: excavator,
      date: date,
      notes: Value(notes),
      createdAt: now,
      updatedAt: now,
    );
    await _db.into(_db.featuresTable).insert(companion);
    return (await getById(id))!;
  }

  /// Updates an existing feature and returns the updated model.
  Future<FeatureModel> update({
    required String id,
    required String site,
    required String trench,
    required String area,
    required String featureNumber,
    required String excavator,
    required DateTime date,
    String? notes,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.featuresTable)..where((t) => t.id.equals(id)))
        .write(
      FeaturesTableCompanion(
        site: Value(site),
        trench: Value(trench),
        area: Value(area),
        featureNumber: Value(featureNumber),
        excavator: Value(excavator),
        date: Value(date),
        notes: Value(notes),
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
        site: row.site,
        trench: row.trench,
        area: row.area,
        featureNumber: row.featureNumber,
        excavator: row.excavator,
        date: row.date,
        notes: row.notes,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
