/// Application-wide constants for ContextLog.
library;

abstract final class AppConstants {
  /// Name of the local SQLite database file.
  static const String databaseFileName = 'context_log.db';

  /// Current database schema version.
  static const int databaseVersion = 3;

  /// Debounce delay for autosave in milliseconds.
  static const int autosaveDebounceMs = 2000;

  /// Minimum tap target size in logical pixels (Material 3 spec).
  static const double minTapTarget = 48.0;

  /// Maximum label length for context numbers (displayed in Harris Matrix).
  static const int matrixNodeLabelMaxLength = 12;

  /// Directory name for locally stored reference photos.
  static const String photosDirectoryName = 'reference_photos';
}

/// Validation messages.
abstract final class ValidationMessages {
  static const String required = 'This field is required';
  static const String featureExists =
      'A feature with this number already exists';
  static const String contextNumberExists =
      'This context number already exists in this feature';
  static const String sampleNumberExists =
      'This sample number is already in use';
  static const String fillNoCuts =
      'No cuts exist in this feature. Create a cut first';
  static const String findNoFills =
      'No fills exist in this feature. Create a fill first';
  static const String sampleNoFills =
      'No fills exist in this feature. Create a fill first';
  static const String selfLoopRelation =
      'A context cannot have a stratigraphic relation with itself';
  static const String duplicateRelation =
      'This stratigraphic relation already exists';
  static const String noProjectSelected = 'Please select a project';
  static const String noProjectsExist =
      'Create a project first before adding a feature';
}
