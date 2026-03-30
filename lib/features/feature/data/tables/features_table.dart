import 'package:drift/drift.dart';

/// Drift table definition for archaeological features.
/// A feature is the primary unit of recording (e.g., a pit, ditch, posthole).
/// Uniqueness is enforced on (site, trench, area, featureNumber).
class FeaturesTable extends Table {
  @override
  String get tableName => 'features';

  TextColumn get id => text()();
  TextColumn get site => text()();
  TextColumn get trench => text()();
  TextColumn get area => text()();
  TextColumn get featureNumber => text()();
  TextColumn get excavator => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'UNIQUE (site, trench, area, feature_number)',
      ];
}
