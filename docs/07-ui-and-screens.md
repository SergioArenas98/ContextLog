# 07 — UI and Screens

## Navigation structure

```
FeatureListScreen       /features
  └── FeatureFormScreen /features/new          (create)
  └── FeatureDetailScreen /features/:id        (7 tabs)
        └── FeatureFormScreen /features/:id/edit (edit)
        └── [bottom sheets for all sub-entities]
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

**Displays**: feature number (StatusBadge), site/trench/area breadcrumb, excavator, date
**Actions**: tap → navigate to detail; long-press/more-menu → edit or delete (with confirmation)
**Animation**: `AnimatedScale` on press (0.97 scale)

**File**: `lib/features/feature/presentation/widgets/feature_card.dart`

---

### FeatureFormScreen (`/features/new`, `/features/:id/edit`)

Full-page form for creating or editing a feature.

**Fields**: site, trench, area, feature number, excavator, date (date picker), notes
**Validation**: runs on save via `FeatureValidator`
**Save button**: in AppBar actions; shows loading spinner

**File**: `lib/features/feature/presentation/screens/feature_form_screen.dart`

---

### FeatureDetailScreen (`/features/:id`)

Hub screen for all data associated with a feature. Contains a `DefaultTabController` with 7 tabs.

**Tab order**:
1. **Summary** — `FeatureSummaryTab`
2. **Photos** — `PhotoListTab`
3. **Drawings** — `DrawingListTab`
4. **Contexts** — `ContextListTab`
5. **Finds** — `FindListTab`
6. **Samples** — `SampleListTab`
7. **Matrix** — `MatrixTab`

**AppBar**: feature number headline + site/trench/area subtitle + scrollable tabs
**Shimmer loading** while feature loads

**File**: `lib/features/feature/presentation/screens/feature_detail_screen.dart`

---

## Feature detail tabs

### FeatureSummaryTab

Displays all feature metadata in a readable layout using `SectionHeader` and `MetadataRow` components. Shows site, trench, area, feature number, excavator, date, and notes.

**File**: `lib/features/feature/presentation/screens/feature_summary_tab.dart`

---

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

Lists all drawing records. Each tile shows drawing number, board number, and notes. Inline edit/delete.

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

### MatrixTab

Hosts the Harris Matrix visualization. Uses `InteractiveViewer` for zoom/pan.

**Components**:
- `_RelationInfoBar` — shows relation count; "Show list" button opens `_RelationsListSheet`
- `_HarrisMatrixView` — contains `CustomPaint` with `HarrisMatrixPainter`
- `_RelationsListSheet` — scrollable list of relations with delete buttons
- `EmptyStateWidget` — if no contexts (can't show matrix) or no relations yet

**FAB**: "Add Relation" → `RelationFormSheet`

**File**: `lib/features/harris_matrix/presentation/widgets/matrix_tab.dart`

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
