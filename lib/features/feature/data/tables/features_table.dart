import 'package:drift/drift.dart';

import '../../../../core/database/converters/enum_converters.dart';

/// Drift table definition for archaeological features.
/// A feature is the primary unit of recording (e.g., a pit, ditch, posthole).
/// Feature numbers are auto-assigned sequentially at creation time.
///
/// Schema v3 change: rubiconCode and license removed (moved to ProjectsTable).
/// projectId added as a nullable FK reference to projects.
/// Schema v6: isNonArchaeological added (boolean, default false).
/// Schema v7: featureType added (text, default 'standard').
class FeaturesTable extends Table {
  @override
  String get tableName => 'features';

  TextColumn get id => text()();
  TextColumn get featureNumber => text()();
  TextColumn get projectId => text().nullable()();
  TextColumn get area => text().nullable()();
  BoolColumn get isNonArchaeological =>
      boolean().withDefault(const Constant(false))();
  TextColumn get featureType =>
      text().map(const FeatureTypeConverter()).withDefault(const Constant('standard'))();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
