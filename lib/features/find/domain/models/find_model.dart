import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums.dart';

part 'find_model.freezed.dart';

/// Immutable domain model for an archaeological find.
/// Every find belongs to a fill within a feature.
@freezed
abstract class FindModel with _$FindModel {
  const factory FindModel({
    required String id,
    required String featureId,
    required String fillId,
    required int findNumber,
    required FindMaterialType materialType,
    String? customMaterialText,
    required int quantity,
    String? description,
    String? localImagePath,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FindModel;
}
