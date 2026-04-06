import 'package:drift/drift.dart';

import '../../constants/enums.dart';

/// Type converters for storing enums as strings in SQLite.
/// Using strings ensures forward compatibility across schema migrations.

class PhotoStageConverter extends TypeConverter<PhotoStage, String> {
  const PhotoStageConverter();

  @override
  PhotoStage fromSql(String fromDb) =>
      PhotoStage.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(PhotoStage value) => value.name;
}

class CardinalOrientationConverter
    extends TypeConverter<CardinalOrientation, String> {
  const CardinalOrientationConverter();

  @override
  CardinalOrientation fromSql(String fromDb) =>
      CardinalOrientation.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(CardinalOrientation value) => value.name;
}

class ContextTypeConverter extends TypeConverter<ContextType, String> {
  const ContextTypeConverter();

  @override
  ContextType fromSql(String fromDb) =>
      ContextType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(ContextType value) => value.name;
}

class CutTypeConverter extends TypeConverter<CutType, String> {
  const CutTypeConverter();

  @override
  CutType fromSql(String fromDb) =>
      CutType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(CutType value) => value.name;
}

class FindMaterialTypeConverter extends TypeConverter<FindMaterialType, String> {
  const FindMaterialTypeConverter();

  @override
  FindMaterialType fromSql(String fromDb) =>
      FindMaterialType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(FindMaterialType value) => value.name;
}

class SampleTypeConverter extends TypeConverter<SampleType, String> {
  const SampleTypeConverter();

  @override
  SampleType fromSql(String fromDb) =>
      SampleType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(SampleType value) => value.name;
}

class StorageTypeConverter extends TypeConverter<StorageType, String> {
  const StorageTypeConverter();

  @override
  StorageType fromSql(String fromDb) =>
      StorageType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(StorageType value) => value.name;
}

class DrawingTypeConverter extends TypeConverter<DrawingType, String> {
  const DrawingTypeConverter();

  @override
  DrawingType fromSql(String fromDb) =>
      DrawingType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(DrawingType value) => value.name;
}

class NullableDrawingTypeConverter
    extends TypeConverter<DrawingType?, String?> {
  const NullableDrawingTypeConverter();

  @override
  DrawingType? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    return DrawingType.values.firstWhere((e) => e.name == fromDb);
  }

  @override
  String? toSql(DrawingType? value) => value?.name;
}

class HarrisRelationTypeConverter
    extends TypeConverter<HarrisRelationType, String> {
  const HarrisRelationTypeConverter();

  @override
  HarrisRelationType fromSql(String fromDb) =>
      HarrisRelationType.values.firstWhere((e) => e.name == fromDb);

  @override
  String toSql(HarrisRelationType value) => value.name;
}
