# 00 — Project Overview

> One-page summary of ContextLog. Read this before anything else.

## What it is

ContextLog is a Flutter Android app for recording archaeological excavation data in the field. It replaces handwritten notebooks with a structured, offline, mobile-first recording tool that understands the relationships between archaeological entities.

## The one-sentence pitch

> Record everything about an archaeological feature — photos, drawings, contexts, finds, samples, and stratigraphic relationships — on a phone, without internet, in whatever order excavation actually happens.

## Main entities

| Entity | What it is |
|---|---|
| **Project** | A site-level container — stores name, site code (Rubicon), and licence number; shared across multiple features |
| **Feature** | The primary record unit — a pit, ditch, posthole, or other archaeological feature identified on site |
| **Cut** | A negative feature — the hole or cut made into the ground |
| **Fill** | The sediment that fills a cut; always belongs to a cut |
| **Photo** | A photo record — stores the manual camera number and shooting stage (pre-ex, mid-ex, working shot, post-ex); may optionally have a reference phone image |
| **Drawing** | A drawing record — stores drawing number, board number, type, facing direction, and an optional reference image |
| **Find** | An archaeological object recovered from a fill (flint, ceramic, bone, etc.) |
| **Sample** | A sediment sample taken from a fill (soil, charcoal, pollen, bulk) |
| **Harris Relation** | A directed stratigraphic relationship between two contexts (above, below, cuts, cutBy, equal to, contemporary with) |

## Main workflows

1. Create a project (site name, Rubicon code, licence number)
2. Create a feature (select project, area optional — number is auto-assigned)
3. Add pre-excavation photos
4. Add drawings (with optional reference image)
5. Add mid-excavation photos
6. Add cut contexts (with type and optional dimensions)
7. Add fill contexts (linked to a cut, with soil description)
8. Add finds (linked to a fill)
9. Add samples (linked to a fill and its parent cut)
10. Add post-excavation photos
11. Build the Harris Matrix by adding stratigraphic relations between contexts

All steps are optional and can be done in any order.

## Key architectural choices

| Decision | Choice | Rationale |
|---|---|---|
| Local database | Drift + SQLite | Relational data model, FK cascade, type-safe queries |
| State management | Riverpod 2 | Provider graph, async data, testable |
| Navigation | GoRouter | Declarative, URL-based, nested routes |
| Models | Freezed | Immutable, sealed types, pattern matching |
| Feature isolation | Feature-first folders | Each domain entity is self-contained |
| Offline first | No network dependency | Field use; no signal assumed |

## Navigation structure

```
/                               ← Splash screen
/features                       ← Feature list (home)
/features/new                   ← Create feature form
/features/:id                   ← Feature detail
/features/:id/edit              ← Edit feature form
/features/:id/matrix            ← Full-screen Harris Matrix
/features/:id/contexts/:cid     ← Context focus screen
/features/:id/evidence/photos   ← Photo list (full-page)
/features/:id/evidence/drawings ← Drawing list (full-page)
/features/:id/evidence/finds    ← Finds list (full-page)
/features/:id/evidence/samples  ← Samples list (full-page)
/projects                       ← Project list
/projects/new                   ← Create project
/projects/:id/edit              ← Edit project
/settings                       ← Settings
/settings/changelog             ← Changelog
```

Context/find/sample/photo/drawing form sheets open as **modal bottom sheets** — they are not separate routes.

## Tech stack (brief)

- Flutter 3 / Dart 3 — Android target
- Riverpod 2 — state management
- Drift 2 — SQLite ORM
- GoRouter 14 — navigation
- Freezed — immutable models
- Google Fonts (JetBrains Mono + Space Grotesk) — typography
- image_picker — device camera integration
- uuid — ID generation

## Cross-references

- Domain concepts in detail → `docs/02-domain-model.md`
- Architecture in detail → `docs/03-architecture.md`
- Folder structure → `docs/04-project-structure.md`
- Data models → `docs/05-data-models.md`
- Screen descriptions → `docs/07-ui-and-screens.md`
