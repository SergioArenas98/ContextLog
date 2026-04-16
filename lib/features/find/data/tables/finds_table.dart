import 'package:drift/drift.dart';

import '../../../../core/database/converters/enum_converters.dart';
import '../../../../core/constants/enums.dart';
import '../../../feature/data/tables/features_table.dart';
import '../../../context/data/tables/contexts_table.dart';

/// Drift table for archaeological finds.
/// Every find must belong to a fill (recorded via fillId).
class FindsTable extends Table {
  @override
  String get tableName => 'finds';

  TextColumn get id => text()();
  TextColumn get featureId =>
      text().references(FeaturesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get fillId =>
      text().references(ContextsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get findNumber => integer()();
  TextColumn get materialType =>
      text().map(const FindMaterialTypeConverter())();
  TextColumn get customMaterialText => text().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get description => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
