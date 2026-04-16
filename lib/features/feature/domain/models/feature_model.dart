import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_model.freezed.dart';

/// Immutable domain model for an archaeological feature.
///
/// Schema v3 change: rubiconCode and license removed (now on ProjectModel).
/// projectId references the associated Project (nullable for legacy features).
@freezed
abstract class FeatureModel with _$FeatureModel {
  const factory FeatureModel({
    required String id,
    required String featureNumber,
    String? projectId,
    String? area,
    @Default(false) bool isNonArchaeological,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FeatureModel;
}
