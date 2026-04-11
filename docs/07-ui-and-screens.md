# 07 — UI and Screens

## Navigation structure

```
SplashScreen                 /
FeatureListScreen            /features
  └── FeatureFormScreen      /features/new               (create)
  └── FeatureDetailScreen    /features/:id               (station-based hub)
        └── FeatureFormScreen /features/:id/edit         (edit)
        └── MatrixFullScreen  /features/:id/matrix       (full-screen matrix)
        └── ContextFocusScreen /features/:id/contexts/:cid
        └── EvidenceShell     /features/:id/evidence/{photos,drawings,finds,samples}
ProjectListScreen            /projects
  └── ProjectFormScreen      /projects/new               (create)
  └── ProjectFormScreen      /projects/:id/edit          (edit)
SettingsScreen               /settings
  └── ChangelogScreen        /settings/changelog
```

---

## Screens

### FeatureListScreen (`/features`)

The app home. Shows all features sorted by most-recently-updated. Displays a searchable list of `FeatureCard` widgets.

**Key elements**:
- AppBar with "ContextLog" title and feature count subtitle
- `SearchBar` for live filtering (watches `featureSearchQueryProvider`)
- `ListView` of `FeatureCard` widgets
- `FloatingActionButton` → `/features/new`
- Shimmer loading placeholders while data loads
- `EmptyStateWidget` when no features exist yet

**File**: `lib/features/feature/presentation/screens/feature_list_screen.dart`

---

### FeatureCard

Summary card for a single feature shown in the list.

**Displays**: feature number badge, project name, area (shown as "Area X" if set), date
**Actions**: tap → navigate to detail; more-menu → edit or delete (with confirmation)
**Animation**: `AnimatedScale` on press (0.97 scale)

**File**: `lib/features/feature/presentation/widgets/feature_card.dart`

---

### FeatureFormScreen (`/features/new`, `/features/:id/edit`)

Full-page form for creating or editing a feature.

**Fields**: project (dropdown, required), area (optional; displayed with "Area " visual prefix — stored raw), date (date picker, defaults today)
**Note**: feature number is auto-assigned by the repository; users do not enter it
**Validation**: runs on save via `FeatureValidator` (currently always returns Valid — all fields are optional or auto-assigned)
**Save button**: in AppBar actions; shows loading spinner

**File**: `lib/features/feature/presentation/screens/feature_form_screen.dart`

---

### FeatureDetailScreen (`/features/:id`)

Hub screen for all data associated with a feature. Uses a station-panel layout rather than a classic tab controller.

**Key panels**:
- `ContextStationPanel` — overlay panel showing cut/fill contexts; accessed via long-press or dedicated button
- Evidence links — tappable cards navigating to `/features/:id/evidence/{photos,drawings,finds,samples}`
- Matrix link — navigates to `/features/:id/matrix`

**AppBar**: feature number + project/area eyebrow

**File**: `lib/features/feature/presentation/screens/feature_detail_screen.dart`

---

### ProjectListScreen (`/projects`)

Lists all projects. Each row shows project name and optional Rubicon code. Tap → project detail/features filtered by project.

**FAB**: "Add Project" → `ProjectFormScreen`

**File**: `lib/features/project/presentation/screens/project_list_screen.dart`

---

### ProjectFormScreen (`/projects/new`, `/projects/:id/edit`)

Full-page form for creating or editing a project.

**Fields**: name (required), Rubicon code (optional), licence number (optional)

**File**: `lib/features/project/presentation/screens/project_form_screen.dart`

---

### SettingsScreen (`/settings`)

App settings. Currently exposes the **theme toggle** (light / dark / system) powered by `ThemeNotifier` + `shared_preferences`.

**File**: `lib/features/settings/presentation/screens/settings_screen.dart`

---

### MatrixFullScreen (`/features/:id/matrix`)

Full-screen interactive Harris Matrix for a feature. Uses `HarrisInteractiveMatrix` (`InteractiveViewer` + `HarrisMatrixPainter`). Supports pinch-zoom, pan, and fullscreen expand/close.

**File**: `lib/features/harris_matrix/presentation/screens/matrix_full_screen.dart`

---

### ContextFocusScreen (`/features/:id/contexts/:cid`)

Dedicated detail/edit screen for a single context (cut or fill). Reached by tapping "expand" from the `ContextStationPanel` overlay, not via the matrix or roster directly.

**File**: `lib/features/context/presentation/screens/context_focus_screen.dart`

---

### SplashScreen (`/`)

App loading screen — shown at launch while the database initializes. Navigates to `/features` once ready.

**File**: `lib/features/splash/splash_screen.dart`

---

## Feature detail tabs / evidence screens



### PhotoListTab

Lists all photo records for the feature. Each `_PhotoTile` shows:
- Stage badge (pre-ex, mid-ex, etc.)
- Photo number (or "no number")
- Orientation badge
- Thumbnail (if reference image exists)
- Inline edit / delete buttons

**FAB**: "Add Photo" → `PhotoFormSheet`

**File**: `lib/features/photo/presentation/widgets/photo_list_tab.dart`

---

### DrawingListTab

Lists all drawing records. Each `_DrawingTile` shows: drawing number badge, drawing type + facing direction (if set), board number, notes, and a 100px reference image thumbnail (if one exists). Tapping the thumbnail or the image icon opens a full-screen `_ImagePreviewDialog` (`InteractiveViewer`, zoom up to 4×). Inline edit/delete.

**FAB**: "Add Drawing" → `DrawingFormSheet`

**File**: `lib/features/drawing/presentation/widgets/drawing_list_tab.dart`

---

### ContextListTab

Lists all contexts (cuts and fills) sorted by context number. Cuts are shown with an indented list of their associated fills. A vertical connector line visually links cut to fills.

- `StatusBadge` for context number
- Type label (Cut / Fill)
- Inline edit / delete buttons
- `EmptyStateWidget` if no contexts yet

**FAB**: "Add Cut" / "Add Fill" → `ContextFormSheet`

**File**: `lib/features/context/presentation/widgets/context_list_tab.dart`

---

### FindListTab

Lists all finds sorted by find number. Shows: find number badge (amber), material type, quantity, fill provenance, description. Inline edit/delete.

**FAB**: "Add Find" → `FindFormSheet`

**File**: `lib/features/find/presentation/widgets/find_list_tab.dart`

---

### SampleListTab

Lists all samples sorted by sample number. Shows: sample number badge (tertiary), sample type, storage type, volume. Inline edit/delete.

**FAB**: "Add Sample" → `SampleFormSheet`

**File**: `lib/features/sample/presentation/widgets/sample_list_tab.dart`

---

### MatrixTab (inline) / MatrixFullScreen (full-page)

The matrix is available both embedded in the feature detail screen and as a full-page view at `/features/:id/matrix`.

**Components**:
- `HarrisInteractiveMatrix` — `InteractiveViewer` wrapping `HarrisMatrixPainter` (`CustomPainter`)
- `_RelationInfoBar` — relation count; "Show list" button opens `_RelationsListSheet`
- `_RelationsListSheet` — scrollable list of relations with delete buttons
- `EmptyStateWidget` — if no contexts or no relations yet

**FAB**: "Add Relation" → `RelationFormSheet`

**Files**: `lib/features/harris_matrix/presentation/widgets/matrix_tab.dart`, `lib/features/harris_matrix/presentation/screens/matrix_full_screen.dart`

---

## Bottom sheets (forms)

All create/edit operations open as modal bottom sheets. They are not routes.

| Sheet | Opens from | Mode |
|---|---|---|
| `ContextFormSheet` | ContextListTab FAB | Create (cut or fill) / Edit |
| `PhotoFormSheet` | PhotoListTab FAB | Create / Edit |
| `DrawingFormSheet` | DrawingListTab FAB | Create / Edit |
| `FindFormSheet` | FindListTab FAB | Create / Edit |
| `SampleFormSheet` | SampleListTab FAB | Create / Edit |
| `RelationFormSheet` | MatrixTab FAB | Create only |

All sheets use:
- `AppSheetHeader` (title + close button)
- `MediaQuery.viewInsetsOf` for keyboard avoidance
- `FilledButton` at the bottom with `AnimatedSwitcher` loading state
- `SafeArea(top: false)` on the save button

---

## Shared UI components

| Component | File | Purpose |
|---|---|---|
| `SurfaceCard` | `core/widgets/surface_card.dart` | Card with ink splash, optional border |
| `SectionHeader` | `core/widgets/section_header.dart` | Accent-bar label, optional trailing widget |
| `StatusBadge` | `core/widgets/status_badge.dart` | Pill badge for identifiers |
| `MetadataRow` | `core/widgets/metadata_row.dart` | Fixed-width label + value row |
| `AppSheetHeader` | `core/widgets/app_sheet_header.dart` | Sheet title + close button |
| `EmptyStateWidget` | `core/widgets/empty_state_widget.dart` | Icon + title + message + optional action |
| `ConfirmDeleteDialog` | `core/widgets/confirm_delete_dialog.dart` | Destructive action confirmation |
| `DuplicateWarningDialog` | `core/widgets/duplicate_warning_dialog.dart` | Override confirmation for warnings |

---

## UX decisions relevant to fieldwork

- **Dark theme by default**: better outdoor readability; `ThemeMode.dark` in `app.dart`
- **48dp minimum touch targets**: all buttons, icons, and inputs comply with Material 3 spec
- **Large forms**: `minimumSize: Size(double.infinity, 52)` on save buttons
- **Inline edit/delete**: no pop-up menus on list items — delete and edit icons are always visible, reducing the number of taps required
- **Keyboard avoidance**: all sheets use `EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom)` to push content above the keyboard
- **Number suggestions**: `FindFormSheet` auto-suggests the next find number; user can override
- **+/- buttons on quantity**: reduces typo risk for integer fields
- **Shimmer loading**: shows structure while data loads, preventing layout shift surprises
