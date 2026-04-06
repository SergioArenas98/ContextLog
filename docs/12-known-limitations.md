# 12 — Known Limitations

## Product limitations

### Platform
- **Android only**. No iOS, web, or desktop version. Flutter's multi-platform capability is available but not activated.

### Single-device, single-user
- No cloud sync, no multi-device data sharing, no team collaboration
- All data lives on one device; if the device is lost or reset, data is lost

### No export
- No PDF, CSV, or JSON export of any record
- Data is only accessible within the app; there is no way to hand it to a lab report or a site archive without manual transcription

### No site-level features
- No project or trench dashboards
- No cross-feature querying (e.g., "find all ceramics across all features on site X")
- No feature statistics or summary reports

---

## Data integrity limitations

### Image files not cleaned up on cascade delete
When a feature is deleted, its child photo DB records are removed via cascade, but the image files stored under `reference_photos/` are **not deleted**. This means orphaned images accumulate on the device indefinitely. There is no cleanup mechanism.

### `parentCutId` FK not enforced at DB level
The `parentCutId` column in the `contexts` table has no Drift FK declaration (intentionally — to avoid a self-referential FK issue). If a cut is deleted directly, any fills referencing it via `parentCutId` will have a dangling ID. The app layer validates this on creation but not on deletion.

### `localImagePath` is an absolute path
Photo file paths are stored as absolute device paths. These become invalid after:
- App reinstall (documents directory may change)
- Device change / data migration
- Moving data between devices

There is no path-resolution or repair logic.

### No schema migration
The database schema is at version 1 with an empty `onUpgrade` handler. Any future schema change (new column, new table) will require writing migration SQL. Until then, existing installs cannot be upgraded without a data loss or manual workaround.

---

## Architecture limitations

### No reactive streams
Providers use one-shot `Future`s, not reactive Drift streams. If two screens are open simultaneously watching the same data and one mutates it, the other won't automatically update. In practice this doesn't matter for a single-user app, but it means the app has no real-time reactivity.

### `graphview` dependency is unused
`graphview: ^1.2.0` is declared in `pubspec.yaml` but is not imported or used anywhere. The Harris Matrix uses a custom `CustomPainter` instead. This adds unnecessary package resolution overhead and should be removed.

### No Harris cycle detection
The topological layout algorithm doesn't detect or report cycles. A circular dependency (A above B, B above A) silently produces incorrect layout with those nodes stuck at layer 0.

### No automatic cut-fill edge in Harris Matrix
The parent-cut relationship stored on `FillModel.parentCutId` is not automatically translated into a Harris relation. Users must manually add stratigraphic relations to reflect containment on the matrix.

---

## UX limitations

### No find number duplicate warning
Context numbers and sample numbers have duplicate warnings. Find numbers do not — only auto-suggestion. A user can create two finds with the same number in the same feature without any warning.

### No drawing number duplicate warning
Drawing numbers and photo numbers are free-text fields with no duplicate detection.

### No batch add
All sub-entities must be added one at a time via a form. There is no bulk-import or rapid-add mode.

### No undo
There is no undo for any action. Deletes are permanent (with one confirm dialog).

### No data backup / export from the device
Users have no in-app way to back up their data. Device backup (e.g., Google Drive) may capture the SQLite file, but this is not tested or documented.

---

## Testing gaps

- No widget tests beyond `widget_test.dart` (smoke test only)
- No integration tests
- No tests for photo/drawing/find/sample/harris validators or repositories
- No E2E tests for any workflow
