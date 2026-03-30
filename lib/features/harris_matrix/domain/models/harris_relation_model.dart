import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums.dart';

part 'harris_relation_model.freezed.dart';

/// Immutable domain model for a stratigraphic relation in the Harris Matrix.
@freezed
abstract class HarrisRelationModel with _$HarrisRelationModel {
  const factory HarrisRelationModel({
    required String id,
    required String featureId,
    required String fromContextId,
    required String toContextId,
    required HarrisRelationType relationType,
    required DateTime createdAt,
  }) = _HarrisRelationModel;
}
