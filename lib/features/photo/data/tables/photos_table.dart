import 'package:drift/drift.dart';

import '../../../../core/database/converters/enum_converters.dart';
import '../../../../core/constants/enums.dart';
import '../../../feature/data/tables/features_table.dart';

/// Drift table for photo records.
/// Supports pre-ex, mid-ex, working shot, and post-ex stages.
class PhotosTable extends Table {
  @override
  String get tableName => 'photos';

  TextColumn get id => text()();
  TextColumn get featureId =>
      text().references(FeaturesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get stage =>
      text().map(const PhotoStageConverter())();
  TextColumn get manualCameraPhotoNumber => text().nullable()();
  TextColumn get cardinalOrientation =>
      text().map(const CardinalOrientationConverter()).withDefault(
            const Constant('unknown'),
          )();
  TextColumn get notes => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
