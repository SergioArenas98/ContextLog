# AI Context — ContextLog

> **Start here.** This file is the fastest way to gain project context. Read it before touching anything else.

---

## What ContextLog is

ContextLog is an offline-first Flutter Android app for recording archaeological excavation data. It targets field archaeologists who need to capture structured records — features, contexts, finds, samples, photos, drawings, and stratigraphic relationships — on a phone during fieldwork, without internet access.

The central object is an **archaeological feature** (a pit, ditch, posthole, etc.). A feature acts as a container for all other record types. Every photo, drawing, cut, fill, find, and sample belongs to exactly one feature.

---

## The core problem it solves

Traditional site recording uses handwritten notebooks that are later transcribed into formal sheets. This creates: messy notes, lost relationships, duplicate number accidents, and extra post-fieldwork time. ContextLog captures structured data directly in the field, enforces key uniqueness rules, and links records together correctly (fills belong to cuts, finds to fills, samples to fills).

---

## Key domain entities and how they relate

```
Feature (site, trench, area, featureNumber, excavator, date)
  ├── Photo (stage, manualCameraPhotoNumber, orientation, localImagePath?)
  ├── Drawing (drawingNumber, boardNumber?)
  ├── ContextModel [sealed]
  │     ├── CutModel (contextNumber, cutType, h/w/d)
  │     └── FillModel (contextNumber, parentCutId → CutModel, composition, color, compaction, inclusions)
  ├── FindModel (findNumber, fillId → FillModel, materialType, quantity)
  ├── SampleModel (sampleNumber, fillId → FillModel, cutId → CutModel, sampleType, storageType, liters?)
  └── HarrisRelationModel (fromContextId, toContextId, relationType)
```

**Critical relationships:**
- Every `FillModel` must reference a `CutModel` via `parentCutId` (same feature)
- Every `FindModel` must reference a `FillModel` via `fillId`
- Every `SampleModel` references both a fill and its parent cut (`cutId` is denormalized for convenience)
- `HarrisRelationModel` edges are scoped to a feature; `fromContextId`/`toContextId` must be different

---

## Tech stack

| Concern | Implementation |
|---|---|
| Language | Dart 3.10+ |
| UI | Flutter + Material 3 (heavily customized, dark-first) |
| Platform | Android (v1 only) |
| State | Riverpod 2 — `Provider`, `FutureProvider.family`, `AsyncNotifierProvider`, `StateProvider` |
| Database | Drift 2.28 (type-safe SQLite ORM) — single file `context_log.db` |
| Navigation | GoRouter 14 — 4 routes total |
| Models | Freezed — all domain models are immutable |
| Fonts | Google Fonts — Barlow Condensed (headings), Inter (body) |
| Images | `image_picker` + `ImageStorage` utility (copies to `reference_photos/` dir) |

---

## Architecture summary

- **Feature-first module structure**: each domain entity has its own folder under `lib/features/<entity>/`
- Each module has three layers: `data/` (tables + repository), `domain/` (models + validator), `presentation/` (providers + widgets)
- **Repository pattern**: all DB access goes through repositories; UI never talks to Drift directly
- **Validation pattern**: validators return a sealed `ValidationResult` (Valid/Warning/Invalid); Warning requires user confirmation via dialog before proceeding
- **Single DB instance**: `databaseProvider` (Riverpod) creates one `AppDatabase` per app lifetime
- **All sub-entity forms are bottom sheets** (not separate routes); mutations call `ref.invalidate()` to refresh providers
- **GoRouter** has 4 routes: list, create, detail, edit

---

## Most important files to inspect first

| File | Why |
|---|---|
| `lib/core/constants/enums.dart` | All domain enums — defines the vocabulary of the app |
| `lib/core/database/app_database.dart` | DB declaration — all 7 tables registered |
| `lib/core/utils/validation_result.dart` | Sealed validation type used everywhere |
| `lib/features/context/domain/models/context_model.dart` | Sealed `ContextModel` (CutModel/FillModel) — the trickiest model |
| `lib/features/feature/domain/models/feature_model.dart` | Top-level entity |
| `lib/app/router.dart` | All routes |
| `lib/features/feature/presentation/screens/feature_detail_screen.dart` | 7-tab hub for all feature data |
| `lib/features/harris_matrix/presentation/widgets/harris_matrix_painter.dart` | Harris Matrix layout algorithm |

---

## Most important business rules

1. **Feature uniqueness**: combination of (site + trench + area + featureNumber) must be unique — hard block
2. **Context numbers are per-feature**: duplicate context number within a feature is a **warning** (user can override), not a hard block
3. **Sample numbers are globally unique**: across all features — duplicate is a **warning** (user can override)
4. **Fill requires a cut**: a fill cannot be created until at least one cut exists in the feature
5. **Find requires a fill**: a find cannot be created until at least one fill exists
6. **Sample requires a fill**: same as find
7. **Harris Matrix self-loop**: a context cannot relate to itself — hard block
8. **Duplicate relation**: same (from, to) pair is a **warning**, not hard block
9. **Cascade delete**: deleting a feature cascades to all its contexts, finds, samples, photos, drawings, and relations via SQLite FK `ON DELETE CASCADE`
10. **parentCutId FK is application-layer only**: the `parentCutId` column in `contexts` has no Drift FK (to avoid circular reference issues); validated by `ContextValidator.validateFill()`

---

## Trickiest parts

### 1. `ContextModel` is a sealed class
`ContextModel` is a Dart sealed class with two concrete subtypes: `CutModel` and `FillModel`. They share one DB table (`contexts`) with a `contextType` discriminator column. Many columns are `nullable` in the DB but should only be null for the "wrong" subtype. When reading `parentCutId` from DB for a fill, the repository falls back to `''` if null (defensive, but potentially masks data bugs).

### 2. Harris Matrix layout
`HarrisMatrixPainter` implements its own topological sort (Kahn's BFS algorithm) to assign layer positions. `above`/`cuts` relations create directed edges forward; `below`/`cutBy` reverse the direction. `equalTo`/`contemporaryWith` are drawn as dashed lines and don't affect layout. The painter is a `CustomPainter` inside an `InteractiveViewer`.

### 3. Validation warning flow
The 3-state `ValidationResult` (Valid/Warning/Invalid) requires careful handling in form widgets. On `Warning`, the UI must show a confirmation dialog (`showDuplicateWarningDialog`) and only proceed if confirmed. Forgetting to handle this breaks duplicate protection. See any `*_form_sheet.dart` for the pattern.

### 4. `SampleModel.cutId` is denormalized
When creating a sample, the form fetches the fill's `parentCutId` from the repository and stores it as `cutId` in the sample. This is a convenience denormalization — the cut can be derived from the fill, but is stored directly to avoid a join.

### 5. Image storage is not tracked in DB paths portably
`PhotoModel.localImagePath` stores an absolute device path. If the app reinstalls or the device changes, that path will be invalid. There is no migration or repair logic for orphaned images.

---

## Known limitations

- Android only; no iOS, web, or desktop
- Single-device, single-user; no cloud sync or data export
- Schema version is 1 with no upgrade migration implemented yet
- `graphview: ^1.2.0` is listed as a dependency but is not used — Harris Matrix uses a custom painter
- `localImagePath` stores absolute device paths (brittle across reinstalls)
- No automatic find number deduplication warning (unlike context/sample numbers)
- No global context number uniqueness — only per-feature
- `parentCutId` FK constraint is enforced at app layer, not DB layer

---

## How to safely make changes

- **Adding a new field to a model**: update the Freezed model, the Drift table, re-run `build_runner`, add migration in `AppDatabase.migration.onUpgrade`, update the repository mapper
- **Adding a new enum value**: add to `enums.dart`, add `displayName` case, add a converter in `enum_converters.dart` — stored values are strings so old DB rows with the old value will break if you rename
- **Adding a new feature module**: follow the `lib/features/<entity>/data|domain|presentation` structure; add the table to `app_database.dart`
- **Changing validation rules**: all validators are in `domain/validators/`; they return `ValidationResult` — do not add validation logic in repositories or widgets
- **Never mutate models in place** — all models are Freezed immutable; use `.copyWith()`

---

## Recommended reading order

1. `docs/AI_CONTEXT.md` ← you are here
2. `docs/02-domain-model.md` — understand the archaeological concepts
3. `docs/05-data-models.md` — understand the data structures
4. `docs/03-architecture.md` — understand how layers fit together
5. `docs/06-state-and-data-flow.md` — understand how data moves
6. `docs/09-validation-rules.md` — understand all business rules
7. `docs/11-harris-matrix.md` — understand the most complex feature

**If you only read one file after this, read `docs/02-domain-model.md`** — understanding the domain (feature/cut/fill/find/sample/Harris Matrix) is the prerequisite for all other understanding.
