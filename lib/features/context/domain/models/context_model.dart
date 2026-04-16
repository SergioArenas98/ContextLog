import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums.dart';

part 'context_model.freezed.dart';

/// Sealed domain model for archaeological contexts.
/// A context is either a [CutModel] or a [FillModel].
@freezed
sealed class ContextModel with _$ContextModel {
  const factory ContextModel.cut({
    required String id,
    required String featureId,
    required int contextNumber,
    CutType? cutType,
    String? customCutTypeText,
    double? height,
    double? width,
    double? depth,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = CutModel;

  const factory ContextModel.fill({
    required String id,
    required String featureId,
    required int contextNumber,
    required String parentCutId,
    FillComposition? composition,
    String? color,
    FillCompaction? compaction,
    String? inclusions,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = FillModel;
}

extension ContextModelX on ContextModel {
  ContextType get contextType => switch (this) {
        CutModel() => ContextType.cut,
        FillModel() => ContextType.fill,
      };

  String get displayLabel =>
      'C${contextNumber} (${contextType.displayName})';
}
