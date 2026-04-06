# ContextLog

**ContextLog** is an offline-first Android app for archaeological field recording. It replaces the handwritten notebook as the primary data capture tool during excavation.

## What it is

ContextLog gives archaeologists a structured, flexible way to record all the information associated with an archaeological feature — directly from a phone, without internet access, in whatever order the excavation actually happens.

A **feature** is the primary record unit. Each feature can contain photos, drawings, contexts (cuts and fills), finds, samples, and stratigraphic relationships visualized as a Harris Matrix.

## Why it exists

Field recording by notebook creates friction: notes get messy, information is recorded out of order, and later transcription loses detail. ContextLog eliminates double-entry and the risk of losing context numbers, photo numbers, sample numbers, or relationships between records.

## Who it is for

- Field archaeologists
- Site assistants and supervisors
- Excavation staff needing fast, structured, offline capture on site

## Core capabilities

- Create and manage archaeological features with full metadata
- Record cut and fill contexts with dimensions and soil descriptions
- Log photo numbers (manual camera) and optionally attach phone reference images
- Record drawing numbers and board numbers
- Record finds (by material type and provenance fill)
- Record sediment samples (by type, storage, volume, provenance fill)
- Visualize stratigraphic relationships as an interactive Harris Matrix
- Search features by site, trench, area, feature number, or excavator
- Duplicate-number protection with user-confirmable warnings
- Fully offline — no network required

## Tech stack

| Concern | Solution |
|---|---|
| UI | Flutter (Material 3, dark-first) |
| Platform | Android (v1) |
| State management | Riverpod 2 (providers + AsyncNotifier) |
| Local database | Drift + SQLite (`context_log.db`) |
| Navigation | GoRouter |
| Immutable models | Freezed |
| Typography | Google Fonts — Barlow Condensed (headings) + Inter (body) |
| Image storage | `image_picker` + local file copy via `ImageStorage` |
| Code generation | `build_runner` (Drift + Freezed) |

## Current status

Version 1.0 — fully functional single-device Android app. All core recording workflows are implemented and tested.

## How to run

```bash
# Install dependencies
flutter pub get

# Regenerate code (only needed after schema/model changes)
dart run build_runner build --delete-conflicting-outputs

# Run on connected Android device
flutter run

# Run analysis
flutter analyze

# Run tests
flutter test
```

## Architecture and domain quick-start

| If you want to understand... | Read... |
|---|---|
| What the app is and why | `docs/00-overview.md` |
| The archaeology domain concepts | `docs/02-domain-model.md` |
| How the code is organized | `docs/03-architecture.md` + `docs/04-project-structure.md` |
| The data models in detail | `docs/05-data-models.md` |
| How state and data flow work | `docs/06-state-and-data-flow.md` |
| The screens and UI | `docs/07-ui-and-screens.md` |
| The Harris Matrix feature | `docs/11-harris-matrix.md` |
| Validation rules | `docs/09-validation-rules.md` |
| AI agent context loading | `docs/AI_CONTEXT.md` ← start here |
