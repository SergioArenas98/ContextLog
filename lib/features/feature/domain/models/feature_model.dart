import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_model.freezed.dart';

/// Immutable domain model for an archaeological feature.
@freezed
abstract class FeatureModel with _$FeatureModel {
  const factory FeatureModel({
    required String id,
    required String site,
    required String trench,
    required String area,
    required String featureNumber,
    required String excavator,
    required DateTime date,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FeatureModel;
}
