/// Sealed type returned by all domain validators.
///
/// - [ValidationValid]: passes, proceed with save.
/// - [ValidationWarning]: proceed is allowed but user must confirm.
/// - [ValidationInvalid]: blocked, user must fix before saving.
sealed class ValidationResult {
  const ValidationResult();
}

final class ValidationValid extends ValidationResult {
  const ValidationValid();
}

final class ValidationWarning extends ValidationResult {
  const ValidationWarning(this.message);
  final String message;
}

final class ValidationInvalid extends ValidationResult {
  const ValidationInvalid(this.message);
  final String message;
}
