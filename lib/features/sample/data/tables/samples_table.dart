import 'package:drift/drift.dart';

import '../../../../core/database/converters/enum_converters.dart';
import '../../../../core/constants/enums.dart';
import '../../../feature/data/tables/features_table.dart';
import '../../../context/data/tables/contexts_table.dart';

/// Drift table for sediment samples.
/// Samples belong to a fill (fillId); cutId is derived from the fill's
/// parentCutId and stored here for query convenience.
class SamplesTable extends Table {
  @override
  String get tableName => 'samples';

  TextColumn get id => text()();
  TextColumn get featureId =>
      text().references(FeaturesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get fillId =>
      text().references(ContextsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get cutId => text()();
  IntColumn get sampleNumber => integer()();
  TextColumn get sampleType =>
      text().map(const SampleTypeConverter())();
  TextColumn get customSampleTypeText => text().nullable()();
  TextColumn get storageType =>
      text().map(const StorageTypeConverter())();
  RealColumn get liters => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
