import 'package:drift/drift.dart';

import '../../../../core/database/converters/enum_converters.dart';
import '../../../../core/constants/enums.dart';
import '../../../feature/data/tables/features_table.dart';
import '../../../context/data/tables/contexts_table.dart';

/// Drift table for Harris Matrix stratigraphic relations.
/// Each relation is a directed edge: fromContext [relationType] toContext.
class HarrisRelationsTable extends Table {
  @override
  String get tableName => 'harris_relations';

  TextColumn get id => text()();
  TextColumn get featureId =>
      text().references(FeaturesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get fromContextId =>
      text().references(ContextsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get toContextId =>
      text().references(ContextsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get relationType =>
      text().map(const HarrisRelationTypeConverter())();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
