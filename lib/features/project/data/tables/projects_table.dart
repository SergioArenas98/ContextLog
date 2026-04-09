import 'package:drift/drift.dart';

/// Drift table definition for reusable excavation projects.
/// A project encapsulates site-level metadata shared by multiple features.
class ProjectsTable extends Table {
  @override
  String get tableName => 'projects';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get rubiconCode => text().nullable()();
  TextColumn get licenceNumber => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
