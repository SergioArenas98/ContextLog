# 03 — Architecture

## Overview

ContextLog uses a layered feature-first architecture:

```
lib/
├── app/               ← App bootstrap, theme, router
├── core/              ← Shared infrastructure (DB, design, utils, widgets)
└── features/          ← One folder per domain entity
    └── <entity>/
        ├── data/      ← DB table definition + repository
        ├── domain/    ← Immutable model + validator
        └── presentation/ ← Riverpod providers + widgets/screens
```

Each feature module is self-contained. Cross-feature dependencies are declared explicitly via imports (e.g., a `FindFormSheet` imports `context_providers.dart` to load fills for a feature).

---

## Layers

### `app/`

Entry point infrastructure:
- `main.dart` — creates `ProviderScope`, runs `ContextLogApp`
- `app.dart` — `MaterialApp.router` with theme and router config; theme mode controlled by `ThemeNotifier` (persisted via `shared_preferences`)
- `router.dart` — GoRouter with 16 named routes
- `theme.dart` — full `ThemeData` (light + dark) using the custom design system

### `core/`

Shared code that features depend on:

- `core/constants/` — `AppConstants` (DB filename, version, validation messages), `enums.dart` (all domain enums), `changelog.dart` (app changelog entries)
- `core/database/` — `AppDatabase` (Drift database class), `database_provider.dart` (Riverpod provider), `converters/` (enum ↔ string type converters)
- `core/design/` — `AppColors` (adaptive palette via `AppColors.of(context)`), `AppTokens` (spacing, radius, elevation), `AppTypography` (JetBrains Mono for identifiers/numbers, Space Grotesk for UI text), `AppThemeExtension`, `AppAnimations`
- `core/preferences/` — `ThemePreferences` (reads/writes `shared_preferences`), `ThemeNotifier` (Riverpod notifier for persisted theme mode)
- `core/utils/` — `ValidationResult` sealed type, `ImageStorage` utility
- `core/widgets/` — shared UI components: `SurfaceCard`, `SectionHeader`, `StatusBadge`, `MetadataRow`, `AppSheetHeader`, `EmptyStateWidget`, `ConfirmDeleteDialog`, `DuplicateWarningDialog`

### `data/` (per feature module)

- **Table**: a Drift `Table` subclass declaring column definitions and constraints
- **Repository**: a plain Dart class with CRUD methods; takes `AppDatabase`; maps `TableData` rows → domain models; no Riverpod dependency

### `domain/` (per feature module)

- **Model**: a `@freezed` immutable class; no DB or UI dependencies
- **Validator**: a plain Dart class that runs async business-rule checks and returns `ValidationResult`

### `presentation/` (per feature module)

- **Providers**: Riverpod `Provider`, `FutureProvider.family`, `AsyncNotifierProvider`; wires repositories and validators into the provider graph
- **Widgets / Screens**: Flutter `StatelessWidget`, `ConsumerWidget`, `ConsumerStatefulWidget`; read providers via `ref.watch` / `ref.read`; call repository methods; call `ref.invalidate()` after mutations

---

## State management

**Riverpod 2** is used throughout.

| Provider type | Used for |
|---|---|
| `Provider<T>` | Synchronous singletons (repositories, validators) |
| `FutureProvider.family<T, P>` | Async data keyed by a parameter (e.g., contexts for a feature) |
| `AsyncNotifierProvider<N, T>` | Feature list (supports `refresh()`) |
| `StateProvider<T>` | Simple UI state (search query string) |

**Cache invalidation**: after any mutation (create/update/delete), the form widget calls `ref.invalidate(relevantProvider)` to force a re-fetch. There is no reactive DB stream — all providers are one-shot `Future`s that are manually invalidated.

---

## Persistence

**Drift 2** on SQLite. One database instance per app lifetime, provided via `databaseProvider`.

- Database file: `context_log.db` in `getApplicationDocumentsDirectory()`
- Foreign keys: enabled via `PRAGMA foreign_keys = ON` in `beforeOpen`
- Cascade delete: all child tables reference `FeaturesTable.id` with `onDelete: KeyAction.cascade`
- Enums: stored as strings using `TypeConverter` subclasses
- Schema version: 4; migrations defined for v1→v2, v2→v3, and v3→v4

---

## Navigation

**GoRouter 14** with 16 addressable paths:

| Route | Widget | Purpose |
|---|---|---|
| `/` | `SplashScreen` | App entry / loading |
| `/features` | `FeatureListScreen` | Home — searchable list |
| `/features/new` | `FeatureFormScreen()` | Create new feature |
| `/features/:id` | `FeatureDetailScreen(featureId)` | Feature hub (station-based layout) |
| `/features/:id/edit` | `FeatureFormScreen(featureId)` | Edit existing feature |
| `/features/:id/matrix` | `MatrixFullScreen(featureId)` | Full-screen interactive Harris Matrix |
| `/features/:id/contexts/:cid` | `ContextFocusScreen` | Context detail / edit |
| `/features/:id/evidence/photos` | `_EvidenceShell → PhotoListTab` | Full-page photo list |
| `/features/:id/evidence/drawings` | `_EvidenceShell → DrawingListTab` | Full-page drawing list |
| `/features/:id/evidence/finds` | `_EvidenceShell → FindListTab` | Full-page finds list |
| `/features/:id/evidence/samples` | `_EvidenceShell → SampleListTab` | Full-page samples list |
| `/projects` | `ProjectListScreen` | Project list |
| `/projects/new` | `ProjectFormScreen()` | Create new project |
| `/projects/:id/edit` | `ProjectFormScreen(projectId)` | Edit existing project |
| `/settings` | `SettingsScreen` | App settings (theme toggle) |
| `/settings/changelog` | `ChangelogScreen` | App changelog |

Form sheets (add/edit context, find, sample, photo, drawing, Harris relation) use `showModalBottomSheet()` and are not separate routes.

---

## Design system

Custom Material 3 design system defined in `lib/core/design/`:
- `AppColors` — explicit color constants for dark and light themes (no `ColorScheme.fromSeed`)
- `AppTokens` — spacing (8-point grid), border radius, elevation shadow lists
- `AppTypography` — Google Fonts (JetBrains Mono for display/headline/label — identifiers, codes, numbers; Space Grotesk for title/body — UI text, forms)
- `AppThemeExtension` — `ThemeExtension` for custom semantic colors (cut node, fill node, badge colors)
- `AppAnimations` — duration and curve constants

---

## Key design decisions

### 1. Feature-first, not layer-first
Folders are organized by domain entity, not by layer type. All code for `find` lives under `lib/features/find/`. This makes it easy to work on one entity without touching others.

### 2. Repositories are not Riverpod-aware
Repositories are plain Dart classes. They take `AppDatabase` in their constructor and have no Riverpod imports. This keeps them testable without a provider context.

### 3. Validators are separate from repositories
Business rules (duplicate checks, relationship validation) live in validator classes, not in repositories. Repositories only do CRUD. This separation keeps each class small and focused.

### 4. No reactive streams
Drift supports reactive `Stream`-based queries, but ContextLog uses one-shot `Future` queries with manual `ref.invalidate()`. This is simpler and sufficient for the use case (single user, single device, no concurrent updates).

### 5. All sub-entity UX is bottom sheets
Creating or editing any sub-entity (context, find, sample, etc.) opens a bottom sheet modal, not a new route. This keeps the navigation stack simple and lets users stay on the feature detail screen throughout their workflow.

### 6. Sealed ContextModel
Cuts and fills share one DB table but have different domain fields and validation. A Dart `sealed class` provides exhaustive pattern matching in the UI and prevents treating a cut like a fill at compile time.

---

## Tradeoffs

| Decision | Benefit | Cost |
|---|---|---|
| Manual cache invalidation | Simple, predictable | UI may briefly show stale data after navigation edge cases |
| Single DB table for Cut+Fill | Fewer joins, simpler schema | Some nullable columns that shouldn't logically be null |
| No `parentCutId` FK in DB | Avoids self-referential Drift issue | App layer must validate; DB won't catch orphaned fills |
| No reactive streams | Less complexity | Manual `invalidate()` calls required after every mutation |
