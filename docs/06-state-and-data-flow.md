# 06 — State and Data Flow

## Overview

Data flows in one direction: UI → Provider → Repository → Database.
Reads flow back via `AsyncValue` from `FutureProvider`. After mutations, providers are manually invalidated to trigger re-fetch.

```
Widget
  │ ref.watch(provider)
  ▼
FutureProvider / AsyncNotifier
  │ calls
  ▼
Repository (plain Dart class)
  │ uses
  ▼
AppDatabase (Drift)
  │ reads/writes
  ▼
SQLite (context_log.db)
```

---

## Provider structure

### Database provider

```dart
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
```

Single instance per app lifetime. All repositories depend on this.

### Repository providers

```dart
final featureRepositoryProvider = Provider<FeatureRepository>((ref) {
  return FeatureRepository(ref.watch(databaseProvider));
});
```

Plain `Provider<T>` — synchronous, stable, singleton-like.

### Data providers

**Feature list** (special — uses `AsyncNotifier` for refresh support):
```dart
final featureListProvider = AsyncNotifierProvider<FeatureListNotifier, List<FeatureModel>>(
  FeatureListNotifier.new,
);
```

**Filtered feature list** (search-aware):
```dart
final filteredFeatureListProvider = FutureProvider<List<FeatureModel>>((ref) async {
  final query = ref.watch(featureSearchQueryProvider);
  ...
});
```

**Per-feature data** (`FutureProvider.family`):
```dart
final contextsByFeatureProvider = FutureProvider.family<List<ContextModel>, String>(
  (ref, featureId) async => ref.watch(contextRepositoryProvider).getByFeatureId(featureId),
);
```

The same pattern applies to `findsByFeatureProvider`, `harrisByFeatureProvider`, etc.

---

## How a read works

1. Widget calls `ref.watch(contextsByFeatureProvider(featureId))`
2. Provider calls `ContextRepository.getByFeatureId(featureId)`
3. Repository executes a Drift `select` query
4. Rows are mapped to `ContextModel` instances
5. Provider returns `AsyncValue<List<ContextModel>>`
6. Widget pattern-matches on `.when(loading:, error:, data:)`

---

## How a mutation works

Example: creating a context from `ContextFormSheet`.

1. User fills the form and taps "Save"
2. `_save()` runs:
   - Calls `ContextValidator.validateContextNumber(...)` → returns `ValidationResult`
   - If `ValidationInvalid`: show SnackBar, stop
   - If `ValidationWarning`: show `showDuplicateWarningDialog`, wait for user confirmation
   - If confirmed (or `ValidationValid`): call `ContextRepository.createCut(...)` or `createFill(...)`
3. Repository inserts the row and returns the new model
4. Form calls `widget.onSaved()` → parent calls `ref.invalidate(contextsByFeatureProvider(featureId))`
5. `Navigator.pop()` closes the sheet
6. The list tab rebuilds because its provider was invalidated

**Important**: mutations are not reactive. Providers are plain `Future`s, not streams. Invalidation is the only mechanism to refresh after a write.

---

## How validation is triggered

Validation runs **synchronously before any repository call**. The flow:

```
_save()
  → validator.validate(...)  // async, reads from repository for uniqueness checks
  → switch (result) {
      ValidationInvalid → show error, stop
      ValidationWarning → show dialog, await confirmation
      ValidationValid   → proceed
    }
  → repository.create/update(...)
```

Validators are accessed via `ref.read(validatorProvider)` — not `ref.watch` — because we only need them once per save action.

---

## How the feature list search works

1. `featureSearchQueryProvider` is a `StateProvider<String>` holding the current search string
2. `filteredFeatureListProvider` watches `featureSearchQueryProvider`
3. When the user types in the search bar, the widget calls `ref.read(featureSearchQueryProvider.notifier).state = query`
4. This invalidates `filteredFeatureListProvider`, which re-runs the query
5. If query is empty, `FeatureRepository.getAll()` is called; otherwise `FeatureRepository.search(query)`

---

## Cache invalidation reference

After each mutation, the relevant provider(s) must be invalidated:

| Action | Invalidate |
|---|---|
| Create/update/delete feature | `filteredFeatureListProvider`, `featureListProvider` |
| Create/update/delete context | `contextsByFeatureProvider(featureId)` |
| Create/update/delete find | `findsByFeatureProvider(featureId)` |
| Create/update/delete sample | `samplesByFeatureProvider(featureId)` |
| Create/update/delete photo | `photosByFeatureProvider(featureId)` |
| Create/update/delete drawing | `drawingsByFeatureProvider(featureId)` |
| Create/delete Harris relation | `harrisByFeatureProvider(featureId)` |

---

## Delete flows

Delete operations follow the same pattern as mutations, but with an added confirmation step:

1. User taps delete icon
2. `showConfirmDeleteDialog(context, title:, message:)` is shown
3. If confirmed: call `repository.delete(id)`
4. Call `ref.invalidate(relevantProvider)`
5. For photo with a local image: `ImageStorage.deleteIfExists(photo.localImagePath)` before DB delete

---

## How edits propagate back to the feature detail

The feature detail screen watches `featureDetailProvider(featureId)`. After editing the feature, `FeatureFormScreen` calls `ref.invalidate(featureDetailProvider(featureId))` and navigates back. The detail screen rebuilds automatically with the updated data.
