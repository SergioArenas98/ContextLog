import 'package:drift/drift.dart';

/// Drift table definition for archaeological features.
/// A feature is the primary unit of recording (e.g., a pit, ditch, posthole).
/// Feature numbers are auto-assigned sequentially at creation time.
///
/// Schema v3 change: rubiconCode and license removed (moved to ProjectsTable).
/// projectId added as a nullable FK reference to projects.
class FeaturesTable extends Table {
  @override
  String get tableName => 'features';

  TextColumn get id => text()();
  TextColumn get featureNumber => text()();
  TextColumn get projectId => text().nullable()();
  TextColumn get area => text().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
