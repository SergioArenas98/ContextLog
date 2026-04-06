# 05 — Data Models

All domain models are defined using `@freezed` (immutable, value-equal, with `.copyWith()`). This document describes each model, its fields, constraints, and relationships.

---

## FeatureModel

**File**: `lib/features/feature/domain/models/feature_model.dart`
**DB table**: `features`

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `site` | `String` | No | Free text (e.g. "Southwick") |
| `trench` | `String` | No | Free text (e.g. "T1") |
| `area` | `String` | No | Free text (e.g. "A") |
| `featureNumber` | `String` | No | Free text (site assigns; e.g. "F12") |
| `excavator` | `String` | No | Name of recorder |
| `date` | `DateTime` | No | Date of excavation |
| `notes` | `String?` | Yes | General notes |
| `createdAt` | `DateTime` | No | App-generated |
| `updatedAt` | `DateTime` | No | Updated on every write |

**DB constraint**: `UNIQUE (site, trench, area, feature_number)` — enforced at DB level.

---

## ContextModel (sealed)

**File**: `lib/features/context/domain/models/context_model.dart`
**DB table**: `contexts` (single table for both subtypes)

`ContextModel` is a Dart `sealed class` with two union variants. Pattern match using `switch (ctx) { CutModel() => ..., FillModel() => ... }`.

### CutModel

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `featureId` | `String` | No | FK → `features.id` CASCADE |
| `contextNumber` | `int` | No | From site context sequence |
| `cutType` | `CutType?` | Yes | Enum: stakehole/posthole/pit/kiln/ditch/linearFeature/hearth/other |
| `customCutTypeText` | `String?` | Yes | Required when `cutType == other` |
| `height` | `double?` | Yes | Meters or cm — site convention |
| `width` | `double?` | Yes | |
| `depth` | `double?` | Yes | |
| `notes` | `String?` | Yes | |
| `createdAt` | `DateTime` | No | |
| `updatedAt` | `DateTime` | No | |

### FillModel

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `featureId` | `String` | No | FK → `features.id` CASCADE |
| `contextNumber` | `int` | No | From site context sequence |
| `parentCutId` | `String` | No | ID of parent CutModel (app-layer FK; not a DB FK) |
| `composition` | `String?` | Yes | Soil composition description |
| `color` | `String?` | Yes | Munsell or descriptive |
| `compaction` | `String?` | Yes | E.g. "loose", "firm" |
| `inclusions` | `String?` | Yes | E.g. "charcoal flecks, pebbles" |
| `notes` | `String?` | Yes | |
| `createdAt` | `DateTime` | No | |
| `updatedAt` | `DateTime` | No | |

**Note**: `parentCutId` is stored in `contexts.parent_cut_id` as a nullable text column. The DB does not enforce an FK here (commented as intentional in the table definition). The repository maps a null value to `''` — callers should never receive a `FillModel` with an empty `parentCutId` under normal operation.

### ContextModelX extension

Provides `.contextType` and `.displayLabel` helpers on any `ContextModel`.

---

## PhotoModel

**File**: `lib/features/photo/domain/models/photo_model.dart`
**DB table**: `photos`

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `featureId` | `String` | No | FK → `features.id` CASCADE |
| `stage` | `PhotoStage` | No | Enum: preEx/midEx/workingShot/postEx |
| `manualCameraPhotoNumber` | `String?` | Yes | Number from site camera register |
| `cardinalOrientation` | `CardinalOrientation` | No | Default: `unknown`; enum: n/ne/e/se/s/sw/w/nw/unknown |
| `notes` | `String?` | Yes | |
| `localImagePath` | `String?` | Yes | Absolute path to phone image file |
| `createdAt` | `DateTime` | No | |
| `updatedAt` | `DateTime` | No | |

---

## DrawingModel

**File**: `lib/features/drawing/domain/models/drawing_model.dart`
**DB table**: `drawings`

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `featureId` | `String` | No | FK → `features.id` CASCADE |
| `drawingNumber` | `String` | No | From site drawing register |
| `boardNumber` | `String?` | Yes | Drawing board identifier |
| `notes` | `String?` | Yes | |
| `createdAt` | `DateTime` | No | |
| `updatedAt` | `DateTime` | No | |

---

## FindModel

**File**: `lib/features/find/domain/models/find_model.dart`
**DB table**: `finds`

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `featureId` | `String` | No | FK → `features.id` CASCADE |
| `fillId` | `String` | No | FK → `contexts.id` CASCADE |
| `findNumber` | `int` | No | App-suggested (max + 1 per feature) |
| `materialType` | `FindMaterialType` | No | Enum: flint/stone/ceramic/metal/bone/shell/glass/other |
| `customMaterialText` | `String?` | Yes | Required when `materialType == other` |
| `quantity` | `int` | No | Default: 1 |
| `description` | `String?` | Yes | |
| `createdAt` | `DateTime` | No | |
| `updatedAt` | `DateTime` | No | |

---

## SampleModel

**File**: `lib/features/sample/domain/models/sample_model.dart`
**DB table**: `samples`

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `featureId` | `String` | No | FK → `features.id` CASCADE |
| `fillId` | `String` | No | FK → `contexts.id` CASCADE |
| `cutId` | `String` | No | Denormalized from `fill.parentCutId`; no DB FK |
| `sampleNumber` | `int` | No | **Globally unique** across all features |
| `sampleType` | `SampleType` | No | Enum: soil/soilCharcoal/bulk/pollen/other |
| `customSampleTypeText` | `String?` | Yes | Required when `sampleType == other` |
| `storageType` | `StorageType` | No | Enum: bucket/bag/jar/other |
| `liters` | `double?` | Yes | Volume of sample |
| `createdAt` | `DateTime` | No | |
| `updatedAt` | `DateTime` | No | |

---

## HarrisRelationModel

**File**: `lib/features/harris_matrix/domain/models/harris_relation_model.dart`
**DB table**: `harris_relations`

| Field | Type | Nullable | Notes |
|---|---|---|---|
| `id` | `String` | No | UUID v4 |
| `featureId` | `String` | No | FK → `features.id` CASCADE |
| `fromContextId` | `String` | No | FK → `contexts.id` CASCADE |
| `toContextId` | `String` | No | FK → `contexts.id` CASCADE |
| `relationType` | `HarrisRelationType` | No | Enum: above/below/cuts/cutBy/equalTo/contemporaryWith |
| `createdAt` | `DateTime` | No | No `updatedAt` — relations are not editable; only create/delete |

---

## ID generation

All `id` fields are UUID v4 strings, generated by the repository at creation time using the `uuid` package. IDs are never re-used.

---

## Enum storage

All enums are stored as their `.name` string in SQLite (e.g., `ContextType.cut` → `"cut"`). The enum converters in `core/database/converters/enum_converters.dart` handle bidirectional conversion. **Renaming an enum value is a breaking change** for existing databases.
