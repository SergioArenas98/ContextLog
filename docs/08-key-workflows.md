# 08 — Key Workflows

End-to-end description of the most important user flows.

---

## 1. Creating a feature

**Entry**: FeatureListScreen → FAB "+"

**Precondition**: at least one project must exist. If no projects exist, a `ValidationInvalid` ("Create a project first") is shown and the user is directed to create a project.

**Steps**:
1. User taps FAB → navigates to `/features/new`
2. `FeatureFormScreen` renders form: project dropdown (required), area field (optional — shown with "Area " visual prefix; only the raw value is stored), date picker (defaults to today)
3. Feature number is **not shown** — it is auto-assigned by the repository as a zero-padded sequence ("001", "002", …)
4. User selects a project, optionally fills area and date, taps "Save" in AppBar
5. `FeatureValidator.validateForCreate()` is called — currently always returns `ValidationValid` (no uniqueness check needed since feature numbers are auto-assigned)
6. `FeatureRepository.create(projectId: ..., area: ..., date: ...)` is called; returns new `FeatureModel` with auto-assigned `featureNumber`
7. `ref.invalidate(featureListProvider)` + `filteredFeatureListProvider`
8. `Navigator.pop()` → back to FeatureListScreen; new feature appears at top

**Relevant code**:
- `lib/features/feature/presentation/screens/feature_form_screen.dart`
- `lib/features/feature/domain/validators/feature_validator.dart`
- `lib/features/feature/data/repositories/feature_repository.dart`

---

## 2. Adding a cut context

**Entry**: FeatureDetailScreen → Contexts tab → FAB "Add Cut"

**Steps**:
1. User taps FAB → `ContextFormSheet` opens (mode: create cut)
2. Form shows: context number, cut type dropdown, custom type field (if "other"), dimensions (h/w/d), notes
3. User fills context number and type, taps "Save"
4. `ContextValidator.validateContextNumber()` checks: number > 0; checks for duplicates within the feature
5. If duplicate found: `ValidationWarning` → `showDuplicateWarningDialog()`; user can confirm override or cancel
6. If confirmed: `ContextRepository.createCut()` called
7. `ref.invalidate(contextsByFeatureProvider(featureId))`
8. Sheet closes; context list refreshes with new cut

**Relevant code**:
- `lib/features/context/presentation/widgets/context_form_sheet.dart`
- `lib/features/context/domain/validators/context_validator.dart`
- `lib/features/context/data/repositories/context_repository.dart`

---

## 3. Adding a fill and linking it to a cut

**Entry**: FeatureDetailScreen → Contexts tab → FAB "Add Fill"

**Precondition**: at least one cut must exist. If no cuts exist, the FAB is disabled or shows a warning.

**Steps**:
1. User taps "Add Fill" → `ContextFormSheet` opens (mode: create fill)
2. Form shows: context number, parent cut dropdown (lists all cuts in the feature), composition, color, compaction, inclusions, notes
3. User selects a cut and enters the fill number
4. `ContextValidator.validateFill()` checks:
   - context number > 0
   - context number not duplicated in this feature (warning if so)
   - parent cut exists and belongs to this feature (hard error if not)
5. On success: `ContextRepository.createFill()` with `parentCutId` set
6. Context list refreshes; fill appears indented under its parent cut

**Relevant code**:
- `lib/features/context/presentation/widgets/context_form_sheet.dart`
- `lib/features/context/domain/validators/context_validator.dart`

---

## 4. Adding a find

**Entry**: FeatureDetailScreen → Finds tab → FAB "Add Find"

**Precondition**: at least one fill must exist in the feature.

**Steps**:
1. `FindFormSheet` opens
2. Auto-suggestion: `nextFindNumberProvider(featureId)` loads `max(findNumber) + 1`; pre-fills the field with a "magic wand" icon
3. Form shows: find number, from fill (dropdown of fills), material type, custom material (if "other"), quantity (+/- buttons), description
4. On save: validates fill exists and belongs to the feature (via `FindValidator.validateFill()`)
5. `FindRepository.create()` called; list refreshes

**Relevant code**:
- `lib/features/find/presentation/widgets/find_form_sheet.dart`
- `lib/features/find/domain/validators/find_validator.dart`
- `lib/features/find/data/repositories/find_repository.dart` (`nextFindNumber()`)

---

## 5. Adding a sample

**Entry**: FeatureDetailScreen → Samples tab → FAB "Add Sample"

**Precondition**: at least one fill must exist.

**Steps**:
1. `SampleFormSheet` opens
2. Form shows: sample number, from fill (dropdown), sample type, custom type (if "other"), storage type, volume (liters)
3. On save:
   - `SampleValidator.validateSampleNumber()` checks **global** uniqueness: if number exists anywhere in the DB → `ValidationWarning`
   - If warning: `showDuplicateWarningDialog()`, user confirms or cancels
   - Then: form fetches fill via `contextRepositoryProvider.getById(fillId)`, extracts `fill.parentCutId` as `cutId`
   - `SampleRepository.create()` called with both `fillId` and derived `cutId`
4. List refreshes

**Note**: `cutId` is not selected by the user — it is derived from the selected fill.

**Relevant code**:
- `lib/features/sample/presentation/widgets/sample_form_sheet.dart`
- `lib/features/sample/domain/validators/sample_validator.dart`

---

## 6. Recording a photo

**Entry**: FeatureDetailScreen → Photos tab → FAB "Add Photo"

**Steps**:
1. `PhotoFormSheet` opens
2. Form shows: stage (pre-ex/mid-ex/working/post-ex), manual camera photo number, orientation (cardinal), notes
3. Optional reference image: tap a placeholder button → `image_picker` opens device camera/gallery → image copied to `reference_photos/` via `ImageStorage.copyToAppStorage()`; path stored in form state
4. On save: `PhotoRepository.create()` called
5. If editing a photo that had a previous image and the image is replaced: old file is deleted via `ImageStorage.deleteIfExists()`

**Relevant code**:
- `lib/features/photo/presentation/widgets/photo_form_sheet.dart`
- `lib/core/utils/image_storage.dart`

---

## 7. Viewing and editing the Harris Matrix

**Entry**: FeatureDetailScreen → Matrix tab

**Steps**:
1. `MatrixTab` loads `harrisByFeatureProvider(featureId)` (relations) and `contextsByFeatureProvider(featureId)` (nodes)
2. If no contexts: `EmptyStateWidget` with "Add contexts first" message
3. If contexts exist but no relations: `EmptyStateWidget` with "Add Relation" action
4. If relations exist: `_HarrisMatrixView` renders `HarrisMatrixPainter` inside `InteractiveViewer`
5. User can pinch-zoom (0.3×–4×) and pan
6. **Add relation**: FAB → `RelationFormSheet`
   - User selects from-context, relation type, to-context from dropdowns
   - `HarrisRelationValidator.validate()`: checks no self-loop, warns on duplicate
   - `HarrisRelationRepository.create()` called; `harrisByFeatureProvider` invalidated; painter re-renders
7. **Delete relation**: "Show list" button → `_RelationsListSheet` → trash icon → confirm → delete → refresh

**Relevant code**:
- `lib/features/harris_matrix/presentation/widgets/matrix_tab.dart`
- `lib/features/harris_matrix/presentation/widgets/harris_matrix_painter.dart`
- `lib/features/harris_matrix/presentation/widgets/relation_form_sheet.dart`

---

## 8. Searching and finding a feature

**Entry**: FeatureListScreen

**Steps**:
1. User types in the `SearchBar`
2. Widget updates `featureSearchQueryProvider.notifier.state`
3. `filteredFeatureListProvider` re-runs; calls `FeatureRepository.search(query)`
4. Search matches on: featureNumber, area (case-insensitive LIKE)
5. Results refresh in place; empty state shows if no matches

---

## 9. Deleting a feature

**Entry**: FeatureListScreen → FeatureCard → more menu → Delete

**Steps**:
1. `showConfirmDeleteDialog()` with warning that all child records will be deleted
2. User confirms → `FeatureRepository.delete(feature.id)`
3. SQLite cascades: all contexts, finds, samples, photos, drawings, and Harris relations are deleted
4. Note: local reference photo **image files** are **not** deleted during cascade — only the DB records. This is a known limitation.
5. `ref.invalidate(featureListProvider)` + `filteredFeatureListProvider`
6. If currently on the detail screen, the user is navigated back to the list

**Relevant code**:
- `lib/features/feature/presentation/widgets/feature_card.dart`
- `lib/features/feature/data/repositories/feature_repository.dart`
