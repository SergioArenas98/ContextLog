import 'package:freezed_annotation/freezed_annotation.dart';

part 'drawing_model.freezed.dart';

/// Immutable domain model for a drawing record.
@freezed
abstract class DrawingModel with _$DrawingModel {
  const factory DrawingModel({
    required String id,
    required String featureId,
    required String drawingNumber,
    String? boardNumber,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DrawingModel;
}
