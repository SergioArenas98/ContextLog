# ContextLog

**ContextLog** is an offline-first Android app for archaeological field recording, built with Flutter.

It replaces handwritten excavation notebooks with a structured mobile workflow for recording archaeological features, contexts, finds, samples, photos, drawings, and stratigraphic relationships directly on site.

The app is designed for real fieldwork conditions: no internet connection, fast data entry, outdoor use, and the need to preserve relationships between records as excavation happens.

## Overview

Archaeological excavation produces structured data under imperfect conditions: limited time, poor weather, muddy hands, incomplete mobile signal, and records that often need to be captured out of sequence.

ContextLog helps field archaeologists record that data from a phone, while keeping the core archaeological relationships intact.

A **feature** is the main recording unit. Each feature can contain:

- Cut and fill contexts
- Finds
- Samples
- Photo records
- Drawing records
- Stratigraphic relationships
- An interactive Harris Matrix

All data is stored locally on the device, so the app can be used fully offline.

## Why it exists

Traditional field recording often relies on handwritten notebooks that are later transcribed into formal sheets or databases. That process creates several risks:

- Notes can become incomplete or illegible under time pressure
- Relationships between cuts, fills, finds, and samples can be missed
- Context numbers, sample numbers, drawing numbers, or photo numbers can be reused by accident
- Data has to be entered twice: once in the field and again during post-excavation
- Notebooks cannot enforce structure or validation rules

ContextLog reduces that friction by capturing structured excavation data at the point of recording.

## Who it is for

- Field archaeologists
- Archaeological site assistants
- Site supervisors
- Excavation teams working with UK-style context recording
- Anyone who needs fast, structured, offline data capture during fieldwork

## Core features

- Create and manage archaeological projects
- Create archaeological features with auto-assigned feature numbers
- Record cut contexts with type, dimensions, and notes
- Record fill contexts linked to their parent cut
- Log finds by material type, quantity, description, and provenance fill
- Record sediment samples by type, storage method, volume, and provenance fill
- Store photo metadata, including manual camera photo number, stage, orientation, and optional reference image
- Store drawing metadata, including drawing number, board number, drawing type, facing direction, and optional reference image
- Create stratigraphic relationships between contexts
- Visualize relations through an interactive Harris Matrix
- Search features by feature number or area
- Validate key recording rules before saving
- Warn users before confirmable duplicate-number cases
- Work entirely offline with no network dependency

## Harris Matrix

ContextLog includes an interactive Harris Matrix for each feature.

The matrix represents stratigraphic relationships between contexts, including:

- `above`
- `below`
- `cuts`
- `cutBy`
- `equalTo`
- `contemporaryWith`

The matrix is rendered with a custom Flutter `CustomPainter` and supports pan and zoom through an `InteractiveViewer`.

## Offline-first design

ContextLog does not require an internet connection for any operation.

There is:

- No remote API
- No authentication
- No cloud dependency
- No required sync process

All records are stored locally in a SQLite database on the Android device. Reference images are copied into local app storage and linked from the database.

## Tech stack

| Concern | Solution |
|---|---|
| Language | Dart |
| Framework | Flutter |
| Platform | Android |
| UI | Material 3, custom dark-first design system |
| State management | Riverpod 2 |
| Local database | Drift + SQLite |
| Navigation | GoRouter |
| Immutable models | Freezed |
| Image handling | image_picker + local file storage |
| Typography | Google Fonts - JetBrains Mono + Space Grotesk |
| Code generation | build_runner, Drift, Freezed |

## Architecture

ContextLog uses a feature-first layered architecture.

```text
lib/
├── app/
├── core/
└── features/
    ├── project/
    ├── feature/
    ├── context/
    ├── photo/
    ├── drawing/
    ├── find/
    ├── sample/
    ├── harris_matrix/
    ├── settings/
    └── splash/
```

Each feature module follows a similar structure:

```text
data/
├── tables/
└── repositories/

domain/
├── models/
└── validators/

presentation/
├── providers/
├── screens/
└── widgets/
```

The app separates responsibilities clearly:

- Repositories handle database access
- Domain models are immutable Freezed classes
- Validators enforce business rules
- Riverpod providers connect the UI to data
- Flutter screens and widgets handle presentation and user interaction

## Data model

The main data structure is centered around a project and its features:

```text
Project
└── Feature
    ├── Photo
    ├── Drawing
    ├── Context
    │   ├── Cut
    │   └── Fill
    ├── Find
    ├── Sample
    └── HarrisRelation
```

Important relationships:

- A fill must belong to a cut
- A find must belong to a fill
- A sample must belong to a fill
- A sample also stores the related cut for easier querying
- Harris Matrix relations connect two contexts within the same feature

## Validation

ContextLog includes validation rules designed around real archaeological recording workflows.

Examples:

- A context number must be a positive integer
- A fill must reference a valid cut in the same feature
- A find must reference a valid fill
- A sample must reference a valid fill
- Sample number duplication triggers a warning
- Context number duplication within a feature triggers a warning
- A Harris Matrix relation cannot connect a context to itself
- Duplicate Harris Matrix relations trigger a warning

Warnings are user-confirmable, because field recording sometimes requires exceptions.

## Current status

Version 1.0 is functionally complete for single-device Android use.

Core recording workflows are implemented, including project creation, feature recording, context management, finds, samples, photos, drawings, and Harris Matrix relationships.

The app is currently in Google Play closed testing, pending production approval.

## How to run

```bash
# Install dependencies
flutter pub get

# Regenerate generated files after schema or model changes
dart run build_runner build --delete-conflicting-outputs

# Run on a connected Android device
flutter run

# Run static analysis
flutter analyze

# Run tests
flutter test
```

## Documentation

| Topic | File |
|---|---|
| Project overview | `docs/00-overview.md` |
| Product purpose | `docs/01-product-purpose.md` |
| Domain model | `docs/02-domain-model.md` |
| Architecture | `docs/03-architecture.md` |
| Project structure | `docs/04-project-structure.md` |
| Data models | `docs/05-data-models.md` |
| State and data flow | `docs/06-state-and-data-flow.md` |
| UI and screens | `docs/07-ui-and-screens.md` |
| Key workflows | `docs/08-key-workflows.md` |
| Validation rules | `docs/09-validation-rules.md` |
| Storage and offline behavior | `docs/10-storage-and-offline.md` |
| Harris Matrix | `docs/11-harris-matrix.md` |
| Known limitations | `docs/12-known-limitations.md` |
| Future improvements | `docs/13-future-improvements.md` |

## Roadmap

Possible future improvements include:

- CSV or JSON export
- PDF context sheet generation
- Cloud backup or optional sync
- iOS support
- Harris Matrix cycle detection
- Richer Harris Matrix editing
- Site-level dashboards
- Batch entry workflows
