import 'package:drift/drift.dart';

import '../../../../core/database/converters/enum_converters.dart';
import '../../../feature/data/tables/features_table.dart';

/// Drift table for drawing records.
class DrawingsTable extends Table {
  @override
  String get tableName => 'drawings';

  TextColumn get id => text()();
  TextColumn get featureId =>
      text().references(FeaturesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get drawingNumber => text()();
  TextColumn get boardNumber => text().nullable()();
  TextColumn get drawingType =>
      text().nullable().map(const NullableDrawingTypeConverter())();
  TextColumn get facing => text()
      .withDefault(const Constant('unknown'))
      .map(const CardinalOrientationConverter())();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
