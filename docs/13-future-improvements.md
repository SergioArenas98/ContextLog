# 13 — Future Improvements

Practical next-step improvements, ordered roughly by value and effort. Separated into short-term (minimal effort, high impact), medium-term, and long-term.

---

## Short-term

### Fix unused dependency
Remove `graphview: ^1.2.0` from `pubspec.yaml`. It is not used — the Harris Matrix is implemented with a custom `CustomPainter`. No functional change required.

### Fix orphaned image files on feature delete
When a feature is deleted, delete the corresponding image files from `reference_photos/` for all its photos and drawings. This requires iterating `localImagePath`/`referenceImagePath` values before the DB cascade runs. (Single-record deletion already works correctly.)

### Add find number duplicate warning
Apply the same `ValidationWarning` pattern used for context and sample numbers to find numbers. Prevents accidental duplication without blocking the user.

### Add drawing/photo number duplicate warning
Same pattern for drawing numbers and manual camera photo numbers.

---

## Medium-term

### Test coverage
Current coverage is low. Priority areas:
- Unit tests for `FindValidator`, `SampleValidator`, `HarrisRelationValidator`
- Repository tests for `FindRepository`, `SampleRepository`, `PhotoRepository` (feature, drawing, project, and context repos already have tests)
- Widget tests for `ContextFormSheet`, `FindFormSheet`, `SampleFormSheet`
- Integration test: create project → create feature → add contexts → add finds → verify data persistence

### CSV / JSON export
Allow exporting a feature's complete record as CSV or JSON. This is essential for handing data to a lab or archive. The relational structure maps naturally to a nested JSON document.

### Harris Matrix: cycle detection
Add a cycle check in `HarrisRelationValidator` before creating a relation. Detect if adding an edge would create a cycle using DFS from the destination node. Return `ValidationInvalid` with a clear message.

### Reactive DB streams
Replace one-shot `FutureProvider` queries with Drift's `watchSingleOrNull`/`watch` stream-based queries. This would remove the need for manual `ref.invalidate()` calls and make data updates automatic.

### Context search / filter
Add a search or filter bar to `ContextListTab` for features with many contexts (e.g., large features with 20+ contexts).

### Custom site presets
Allow users to save frequently used values (site name, trench name, excavator name) as defaults so they don't have to re-type them for every feature.

---

## Long-term

### Cloud backup / sync
A simple one-way backup to Google Drive or a personal server. Not multi-user sync — just data safety. The SQLite file could be copied as-is.

### PDF export
Generate a formal context sheet PDF from the app, matching a site's recording format. This would require a template system and probably a server-side PDF generator or a Flutter PDF library.

### Team / multi-device use
Shared context number sequences across devices on the same site. This is architecturally complex because it requires either a central server or peer-to-peer sync with conflict resolution.

### iOS support
Flutter supports iOS — the main work is adapting the Android-specific setup (`sqlite3_flutter_libs`, `path_provider` configuration, camera permissions) and testing on device.

### Richer Harris Matrix editing
- Drag-and-drop node repositioning with persisted manual layout
- Auto-layout switch (topological vs. manual)
- Visual representation of cut-fill containment (separate lane or visual grouping)
- Export Harris Matrix as image

### Feature dashboards
A site-level summary view aggregating finds by material type, sample counts, context counts across features.

### Direct output to formal context sheets
Map the app's data model to a standard context sheet format (e.g., MoLAS, Museum of London) and generate pre-filled PDFs. This would make the app directly usable in professional archives.

### Offline-first with optional sync
Add optional Supabase or similar backend for teams willing to have a server. Keep offline-first as the primary mode; sync happens when convenient.
