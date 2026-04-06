# 11 — Harris Matrix

## Archaeological background

The **Harris Matrix** (developed by Edward Harris in 1973) is the standard method for recording stratigraphic relationships in archaeology. It is a directed acyclic graph where:
- Each **node** represents one stratigraphic unit (context)
- Each **edge** represents a temporal/physical relationship between contexts
- Nodes are arranged vertically: later contexts at the top, earlier contexts at the bottom

It answers the question: *in what order did these deposits form?*

---

## How it is modeled in ContextLog

### Data model

**`HarrisRelationModel`** (`lib/features/harris_matrix/domain/models/harris_relation_model.dart`):
```
HarrisRelationModel {
  id: String (UUID)
  featureId: String
  fromContextId: String → contexts.id
  toContextId: String → contexts.id
  relationType: HarrisRelationType
  createdAt: DateTime
}
```

Relations are **feature-scoped** — a relation can only connect contexts within the same feature.

### Relation types

| Type | Meaning | Layout effect |
|---|---|---|
| `above` | `from` is later than `to` | Directed edge: from → to (down) |
| `below` | `from` is earlier than `to` | Reversed: to → from (down) |
| `cuts` | `from` (cut) physically cuts `to` | Directed edge: from → to (down) |
| `cutBy` | `from` is cut by `to` | Reversed: to → from (down) |
| `equalTo` | Same deposit | Dashed line; no layout effect |
| `contemporaryWith` | Broadly contemporary | Dashed line; no layout effect |

`above`/`below` and `cuts`/`cutBy` are semantic inverses. Both forms are stored as written by the user — there is no normalisation to a canonical direction.

---

## Layout algorithm

**File**: `lib/features/harris_matrix/presentation/widgets/harris_matrix_painter.dart`, method `_computeLayout()`

The algorithm is a custom implementation of **Kahn's BFS topological sort**:

1. **Build adjacency graph**: for each relation, determine the "forward" direction:
   - `above` or `cuts`: edge from `fromContextId` → `toContextId`
   - `below` or `cutBy`: edge from `toContextId` → `fromContextId` (reversed)
   - `equalTo` / `contemporaryWith`: ignored for layout purposes

2. **Compute in-degrees**: count incoming edges per node

3. **BFS from roots** (nodes with in-degree 0):
   - Start all root nodes at layer 0
   - Each neighbour is placed at `max(current_layer + 1, existing_layer_assignment)`
   - This ensures nodes appear below all their predecessors

4. **Assign positions**:
   - Nodes in the same layer are spread horizontally, centred on the canvas
   - Y position = `padding + layerIndex × layerSpacing`
   - X position = centred within the layer

5. **Unconnected nodes** (those not reachable from the relation graph) default to layer 0

**Constants**:
```dart
static const double _nodeWidth = 110;
static const double _nodeHeight = 52;
static const double _layerSpacing = 100;   // vertical gap between layers
static const double _nodeSpacing = 130;    // horizontal gap between nodes
static const double _padding = 48;
static const double _arrowSize = 12;
```

---

## Drawing (CustomPainter)

**File**: `lib/features/harris_matrix/presentation/widgets/harris_matrix_painter.dart`

Rendering order:
1. `_drawGrid()` — dot grid background (32dp spacing, 1.5dp radius dots, `outlineVariant` color at alpha 60)
2. `_drawEdges()` — all edges, using computed node center positions
3. `_drawNodes()` — nodes on top of edges

### Node rendering

- **Cuts**: sharp-corner `Rect` (no radius) with `primaryContainer` fill and `primary` border
- **Fills**: rounded `RRect` (radius 26) with `tertiaryContainer` fill and `tertiary` border
- Both: drop shadow offset +2dp, label "C{number} · {Cut|Fill}"
- Edge connects from bottom-center of `from` node to top-center of `to` node (not center-to-center)

### Edge rendering

- **Directed edges** (above/cuts/below/cutBy): solid line + filled arrowhead at destination. **Important**: `_drawEdges()` draws the arrow as-stored — from `fromContextId` bottom-center to `toContextId` top-center — regardless of relation type. The reversal for `below`/`cutBy` only affects layer assignment in `_computeLayout()`, not the visual arrow direction. So a `below` relation draws an arrow from `from` → `to` visually, even though semantically `to` is later.
- **Undirected edges** (equalTo/contemporaryWith): dashed line, no arrowhead

### Canvas interaction

`_HarrisMatrixView` wraps `CustomPaint` in `InteractiveViewer`:
```dart
InteractiveViewer(
  boundaryMargin: EdgeInsets.all(200),
  minScale: 0.3,
  maxScale: 4.0,
  child: RepaintBoundary(
    child: CustomPaint(
      painter: HarrisMatrixPainter(...),
      size: _computeCanvasSize(contexts),
    ),
  ),
)
```

Canvas size is computed from context count by `_computeCanvasSize()` in `matrix_tab.dart` (not in the painter): `4 nodes per row`, `(nodesPerRow × 150 + 120)` wide, `(rows × 130 + 120)` tall.

---

## Creating relations

**File**: `lib/features/harris_matrix/presentation/widgets/relation_form_sheet.dart`

The user selects:
1. **From context** — any context in the feature (dropdown)
2. **Relation type** — dropdown of all 6 types with a help text explaining the semantics
3. **To context** — any context in the feature (dropdown)

Validation via `HarrisRelationValidator`:
- Self-loop (from == to): hard block
- Duplicate (from, to) pair: warning (can override)

On save: `HarrisRelationRepository.create()` → `ref.invalidate(harrisByFeatureProvider(featureId))`

---

## Viewing and deleting relations

`_RelationsListSheet` (in `matrix_tab.dart`) shows all relations as a scrollable list. Each row displays:
- From context pill (primary color)
- Arrow icon
- To context pill (tertiary color)
- Relation type label
- Delete button

Deleting a relation: confirm dialog → `HarrisRelationRepository.delete(id)` → refresh

---

## Limitations and simplifications

1. **No cycle detection**: the app does not detect or prevent cycles in the graph. A cycle would cause infinite loops in the topological sort. Kahn's algorithm handles this gracefully by leaving cyclic nodes unvisited, but their positions default to layer 0 without warning.

2. **No node repositioning**: users cannot drag nodes. The layout is fully automatic.

3. **Implied cut-fill edges not drawn automatically**: the parent-cut relationship (a fill belongs to a cut) is stored in the context model, but it is **not** automatically added as a Harris relation. Users must manually add "cuts" / "above" relations to reflect this on the matrix.

4. **equalTo / contemporaryWith don't affect layout**: these symmetric relations are shown as dashed lines but have no effect on topological ordering.

5. **`graphview` package unused**: `graphview: ^1.2.0` is listed in `pubspec.yaml` but the Harris Matrix uses a fully custom `CustomPainter`. The package was either an early dependency that was replaced or a planned integration that hasn't been implemented yet.

6. **No relation editing**: relations can only be created or deleted, not edited. Changing a relation type requires delete + recreate.
