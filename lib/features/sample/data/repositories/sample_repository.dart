import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/constants/enums.dart';
import '../../domain/models/sample_model.dart';

class SampleRepository {
  SampleRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<List<SampleModel>> getByFeatureId(String featureId) async {
    final rows = await (_db.select(_db.samplesTable)
          ..where((t) => t.featureId.equals(featureId))
          ..orderBy([(t) => OrderingTerm(expression: t.sampleNumber)]))
        .get();
    return rows.map(_rowToModel).toList();
  }

  Future<SampleModel?> getById(String id) async {
    final row = await (_db.select(_db.samplesTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToModel(row);
  }

  /// Returns true if this sample number is used globally (across all features).
  Future<bool> sampleNumberExistsGlobally({
    required int sampleNumber,
    String? excludeId,
  }) async {
    var query = _db.select(_db.samplesTable)
      ..where((t) => t.sampleNumber.equals(sampleNumber));
    if (excludeId != null) {
      query = query..where((t) => t.id.equals(excludeId).not());
    }
    final row = await query.getSingleOrNull();
    return row != null;
  }

  Future<SampleModel> create({
    required String featureId,
    required String fillId,
    required String cutId,
    required int sampleNumber,
    required SampleType sampleType,
    String? customSampleTypeText,
    required StorageType storageType,
    int storageCount = 1,
    double? liters,
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    await _db.into(_db.samplesTable).insert(
          SamplesTableCompanion.insert(
            id: id,
            featureId: featureId,
            fillId: fillId,
            cutId: cutId,
            sampleNumber: sampleNumber,
            sampleType: sampleType,
            customSampleTypeText: Value(customSampleTypeText),
            storageType: storageType,
            storageCount: Value(storageCount),
            liters: Value(liters),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await getById(id))!;
  }

  Future<SampleModel> update({
    required String id,
    required String fillId,
    required String cutId,
    required int sampleNumber,
    required SampleType sampleType,
    String? customSampleTypeText,
    required StorageType storageType,
    int storageCount = 1,
    double? liters,
  }) async {
    final now = DateTime.now();
    await (_db.update(_db.samplesTable)..where((t) => t.id.equals(id))).write(
      SamplesTableCompanion(
        fillId: Value(fillId),
        cutId: Value(cutId),
        sampleNumber: Value(sampleNumber),
        sampleType: Value(sampleType),
        customSampleTypeText: Value(customSampleTypeText),
        storageType: Value(storageType),
        storageCount: Value(storageCount),
        liters: Value(liters),
        updatedAt: Value(now),
      ),
    );
    return (await getById(id))!;
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.samplesTable)..where((t) => t.id.equals(id))).go();
  }

  SampleModel _rowToModel(SamplesTableData row) => SampleModel(
        id: row.id,
        featureId: row.featureId,
        fillId: row.fillId,
        cutId: row.cutId,
        sampleNumber: row.sampleNumber,
        sampleType: row.sampleType,
        customSampleTypeText: row.customSampleTypeText,
        storageType: row.storageType,
        storageCount: row.storageCount,
        liters: row.liters,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
