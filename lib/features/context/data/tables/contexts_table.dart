import 'package:drift/drift.dart';

import '../../../../core/database/converters/enum_converters.dart';
import '../../../../core/constants/enums.dart';
import '../../../feature/data/tables/features_table.dart';

/// Drift table for archaeological contexts (cuts and fills).
/// Uses a single table with a discriminator column (contextType).
/// Cut-specific and fill-specific columns are nullable; application code
/// enforces that the correct fields are populated for each type.
class ContextsTable extends Table {
  @override
  String get tableName => 'contexts';

  TextColumn get id => text()();
  TextColumn get featureId =>
      text().references(FeaturesTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get contextNumber => integer()();
  TextColumn get contextType =>
      text().map(const ContextTypeConverter())();

  // --- Cut-specific fields ---
  TextColumn get cutType =>
      text().map(const CutTypeConverter()).nullable()();
  TextColumn get customCutTypeText => text().nullable()();
  RealColumn get height => real().nullable()();
  RealColumn get width => real().nullable()();
  RealColumn get depth => real().nullable()();

  // --- Fill-specific fields ---
  // Self-referential FK: parent cut for this fill.
  // No drift .references() used here to avoid circular FK issues;
  // enforced at application layer.
  TextColumn get parentCutId => text().nullable()();
  TextColumn get composition =>
      text().map(const NullableFillCompositionConverter()).nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get compaction =>
      text().map(const NullableFillCompactionConverter()).nullable()();
  TextColumn get inclusions => text().nullable()();

  // --- Common ---
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
