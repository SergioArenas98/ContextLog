# 09 — Validation Rules

## Validation system

All business-rule validation returns a `ValidationResult` sealed type:

```dart
// lib/core/utils/validation_result.dart
sealed class ValidationResult { ... }
final class ValidationValid extends ValidationResult { ... }
final class ValidationWarning extends ValidationResult {
  final String message;
}
final class ValidationInvalid extends ValidationResult {
  final String message;
}
```

- **`ValidationInvalid`**: user is blocked. Show error SnackBar, do not save.
- **`ValidationWarning`**: user may proceed but must confirm via `showDuplicateWarningDialog()`.
- **`ValidationValid`**: proceed without interruption.

Validators are injected with repositories (for async lookups) and accessed via Riverpod providers.

---

## Feature validation (`FeatureValidator`)

**File**: `lib/features/feature/domain/validators/feature_validator.dart`

| Rule | Result | Condition |
|---|---|---|
| Site is required | `ValidationInvalid` | `site.trim().isEmpty` |
| Trench is required | `ValidationInvalid` | `trench.trim().isEmpty` |
| Area is required | `ValidationInvalid` | `area.trim().isEmpty` |
| Feature number is required | `ValidationInvalid` | `featureNumber.trim().isEmpty` |
| Excavator is required | `ValidationInvalid` | `excavator.trim().isEmpty` |
| Feature already exists | `ValidationInvalid` | Combination (site + trench + area + featureNumber) exists in DB |

The uniqueness check uses case-insensitive comparison (`lower()`). When editing, the current feature's ID is excluded from the check.

---

## Context validation (`ContextValidator`)

**File**: `lib/features/context/domain/validators/context_validator.dart`

| Rule | Result | Condition |
|---|---|---|
| Context number must be positive | `ValidationInvalid` | `contextNumber <= 0` |
| Context number already exists in this feature | `ValidationWarning` | Same number found in `contexts` table for this `featureId` |
| Parent cut must exist in this feature (fill only) | `ValidationInvalid` | `parentCutId` not found in DB, or found but in a different feature |

**Note**: duplicate context numbers produce a **warning**, not a hard block. This is intentional — sites sometimes reuse context numbers for related deposits and need to override.

---

## Harris relation validation (`HarrisRelationValidator`)

**File**: `lib/features/harris_matrix/domain/validators/harris_relation_validator.dart`

| Rule | Result | Condition |
|---|---|---|
| Self-loop not allowed | `ValidationInvalid` | `fromContextId == toContextId` |
| Duplicate relation | `ValidationWarning` | Same (from, to) pair already exists in DB |

The duplicate check uses exact pair matching. Note: (A → B) and (B → A) are **not** considered duplicates — they are different directed relations.

---

## Sample validation (`SampleValidator`)

**File**: `lib/features/sample/domain/validators/sample_validator.dart`

| Rule | Result | Condition |
|---|---|---|
| Sample number must be positive | `ValidationInvalid` | `sampleNumber <= 0` |
| Sample number already in use (globally) | `ValidationWarning` | `sampleNumber` found anywhere in the `samples` table |
| Fill does not exist | `ValidationInvalid` | Fill not found by ID |
| Fill belongs to wrong feature | `ValidationInvalid` | `fill.featureId != featureId` |
| Context is not a fill | `ValidationInvalid` | ID refers to a cut, not a fill |

Sample numbers are **globally unique** (unlike context numbers, which are per-feature).

---

## Find validation (`FindValidator`)

**File**: `lib/features/find/domain/validators/find_validator.dart`

| Rule | Result | Condition |
|---|---|---|
| Fill does not exist | `ValidationInvalid` | Fill not found by ID |
| Fill belongs to wrong feature | `ValidationInvalid` | `fill.featureId != featureId` |
| Context is not a fill | `ValidationInvalid` | ID refers to a cut |
| No fills exist in the feature | `ValidationInvalid` | `getFillsByFeatureId()` returns empty list |

**Note**: there is no duplicate find number check. Find numbers are suggested (max + 1) but not validated for uniqueness.

---

## Form-level validation (in widgets)

Some validation runs in Flutter `Form` validator callbacks (not in domain validators):

| Field | Rule | Location |
|---|---|---|
| Context number | Required, must be integer | `ContextFormSheet` |
| Find number | Required, must be integer | `FindFormSheet` |
| Quantity | Required, must be positive integer | `FindFormSheet` |
| Sample number | Required, must be integer | `SampleFormSheet` |
| Volume (liters) | Optional; if present, must parse as double | `SampleFormSheet` |
| Custom cut type | Required if `cutType == other` | `ContextFormSheet` |
| Custom material | Required if `materialType == other` | `FindFormSheet` |
| Custom sample type | Required if `sampleType == other` | `SampleFormSheet` |
| From fill | Required (dropdown) | `FindFormSheet`, `SampleFormSheet` |

Form validation runs via `_formKey.currentState!.validate()` before domain validators.

---

## Validation messages

Centralised in `AppConstants` / `ValidationMessages`:

```dart
// lib/core/constants/app_constants.dart
static const featureExists = 'A feature with this site, trench, area, and number already exists';
static const contextNumberExists = 'This context number already exists in this feature';
static const sampleNumberExists = 'This sample number is already in use';
static const fillNoCuts = 'No cuts exist in this feature. Create a cut first';
static const findNoFills = 'No fills exist in this feature. Create a fill first';
static const sampleNoFills = 'No fills exist in this feature. Create a fill first';
static const selfLoopRelation = 'A context cannot have a stratigraphic relation with itself';
static const duplicateRelation = 'This stratigraphic relation already exists';
```

---

## Summary: Hard blocks vs. warnings

| Scenario | Type |
|---|---|
| Missing required field | Hard block (form validator) |
| Duplicate feature identity | Hard block |
| Invalid context number (≤0) | Hard block |
| Parent cut not found | Hard block |
| No fills for find/sample | Hard block |
| Invalid fill reference | Hard block |
| Self-loop Harris relation | Hard block |
| Duplicate context number (same feature) | Warning |
| Duplicate sample number (global) | Warning |
| Duplicate Harris relation | Warning |
