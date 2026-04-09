import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_model.freezed.dart';

/// Immutable domain model for a reusable excavation project.
/// A project stores site-level metadata (name, rubicon code, licence number)
/// that can be shared across multiple features.
@freezed
abstract class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String name,
    String? rubiconCode,
    String? licenceNumber,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProjectModel;
}
