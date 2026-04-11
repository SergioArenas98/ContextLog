import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums.dart';

part 'drawing_model.freezed.dart';

/// Immutable domain model for a drawing record.
@freezed
abstract class DrawingModel with _$DrawingModel {
  const factory DrawingModel({
    required String id,
    required String featureId,
    required String drawingNumber,
    String? boardNumber,
    DrawingType? drawingType,
    required CardinalOrientation facing,
    String? notes,
    /// Local filesystem path to an optional reference image for this drawing.
    /// Not an official excavation photo — just a visual aid stored locally.
    String? referenceImagePath,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DrawingModel;
}
