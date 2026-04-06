import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_model.freezed.dart';

/// Immutable domain model for an archaeological feature.
@freezed
abstract class FeatureModel with _$FeatureModel {
  const factory FeatureModel({
    required String id,
    required String featureNumber,
    String? rubiconCode,
    String? license,
    String? area,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FeatureModel;
}
