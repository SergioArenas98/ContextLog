import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums.dart';

part 'sample_model.freezed.dart';

/// Immutable domain model for a sediment sample.
/// Belongs to a fill; cutId is derived from the fill's parent cut.
@freezed
abstract class SampleModel with _$SampleModel {
  const factory SampleModel({
    required String id,
    required String featureId,
    required String fillId,
    required String cutId,
    required int sampleNumber,
    required SampleType sampleType,
    String? customSampleTypeText,
    required StorageType storageType,
    @Default(1) int storageCount,
    double? liters,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SampleModel;
}
