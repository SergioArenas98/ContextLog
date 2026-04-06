# 10 — Storage and Offline

## Local database

**Technology**: Drift 2.28 (type-safe SQLite ORM for Flutter)

**File location**: `context_log.db` in the device's application documents directory
(`getApplicationDocumentsDirectory()` from `path_provider`)

**Database class**: `lib/core/database/app_database.dart`

**Tables** (7):
- `features`
- `contexts`
- `photos`
- `drawings`
- `finds`
- `samples`
- `harris_relations`

**Schema version**: 1 — defined in `AppConstants.databaseVersion`

**Foreign keys**: enabled at DB open time via `PRAGMA foreign_keys = ON`

**Cascade deletes**: all child tables reference `features.id` with `onDelete: KeyAction.cascade`. Deleting a feature removes all related records in one SQL operation.

---

## Offline-first design

ContextLog requires **no network connection for any operation**. There is:
- No HTTP client
- No cloud sync
- No authentication
- No remote API

All reads and writes go directly to the local SQLite database. The app is fully functional in airplane mode or in areas with no signal.

This is intentional: field archaeology sites are often in remote locations without reliable mobile data. The SQLite database is the single source of truth.

---

## Image (reference photo) storage

Photos taken on the device are stored differently from the SQLite database.

**Where images go**: copied into `<app_documents_dir>/reference_photos/<uuid>.<ext>`

**How it works**:
1. User taps "Take / Pick Photo" in `PhotoFormSheet`
2. `image_picker` opens device camera or gallery
3. The selected file is at a temporary path
4. `ImageStorage.copyToAppStorage(sourcePath)` copies it to the permanent `reference_photos/` directory with a UUID filename
5. The permanent path is stored in `PhotoModel.localImagePath`

**`ImageStorage` utility** (`lib/core/utils/image_storage.dart`):
```dart
static Future<String> copyToAppStorage(String sourcePath)
static Future<void> deleteIfExists(String? path)
```

**Image deletion**: when a photo record is deleted (or its image is replaced), `ImageStorage.deleteIfExists()` deletes the file. However, if a feature is deleted via cascade, the child photo DB records are deleted but **the image files are not deleted**. This is a known limitation.

---

## Database initialization

```dart
// app_database.dart
@DriftDatabase(tables: [...])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    onUpgrade: (m, from, to) async { /* future migrations */ },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
```

On first install, `onCreate` creates all 7 tables. On upgrade, `onUpgrade` is a no-op (no migrations defined yet).

---

## Enum persistence

All enum fields are stored as their Dart `.name` string (e.g., `ContextType.cut` → `"cut"`).

Each enum has a corresponding `TypeConverter<Enum, String>` in `lib/core/database/converters/enum_converters.dart`.

**Important**: renaming an enum variant is a **breaking change** for existing databases. Any row storing the old name will fail to deserialize on the next open. A migration would be required to `UPDATE` old string values.

---

## Drift provider

```dart
// lib/core/database/database_provider.dart
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
```

One `AppDatabase` instance lives for the full app session. It is closed when the `ProviderScope` is disposed (app shutdown).

---

## Offline risks and assumptions

| Risk | Status |
|---|---|
| Device runs out of storage | Not handled; SQLite writes will fail silently if disk is full |
| App reinstall / device change | `localImagePath` becomes invalid (absolute path); images are orphaned |
| DB file corruption | Not handled; no backup or recovery mechanism |
| Schema version mismatch (future upgrade) | `onUpgrade` is empty; would require manual migration code |
| Concurrent writes | Not applicable (single user, no background workers) |

---

## Code generation

Drift uses `build_runner` to generate `app_database.g.dart` from the table definitions and `@DriftDatabase` annotation. Freezed generates `*.freezed.dart` from model definitions.

**Re-generate after schema or model changes**:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files must not be edited manually and should be committed to version control.
