import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums.dart';

part 'photo_model.freezed.dart';

/// Immutable domain model for a photo record.
@freezed
abstract class PhotoModel with _$PhotoModel {
  const factory PhotoModel({
    required String id,
    required String featureId,
    required PhotoStage stage,
    String? manualCameraPhotoNumber,
    required CardinalOrientation cardinalOrientation,
    String? notes,
    String? localImagePath,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PhotoModel;
}
