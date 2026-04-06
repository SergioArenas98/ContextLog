# 02 — Domain Model

This document explains the archaeological concepts used by ContextLog and how they map to the application's data model.

---

## Feature

In UK excavation methodology, a **feature** is a discrete archaeological entity: a pit, a ditch, a posthole, a hearth. It is the primary unit of recording. On a real site, feature numbers are assigned by a site supervisor from a running list.

In the app, a `FeatureModel` is the top-level container. All other records belong to a feature.

**Key fields**: `site`, `trench`, `area`, `featureNumber`, `excavator`, `date`, `notes`

**Uniqueness rule**: the combination of (site + trench + area + featureNumber) must be unique. This reflects the site convention that no two features in the same area can share a number.

---

## Context

A **context** is a distinct stratigraphic unit within a feature. Every feature produces one or more contexts as it is excavated.

Contexts in ContextLog are a **sealed type** with two subtypes:

### Cut

A **cut** is the physical hole or truncation made into the ground. It defines the shape and edges of the feature. A cut is what you see before you excavate.

- Has a `cutType` (stakehole, posthole, pit, kiln, ditch, linear feature, hearth, other)
- May have optional dimensions: `height`, `width`, `depth` (in whatever units the site uses)
- Has a `contextNumber` (assigned from the site's running context list)

### Fill

A **fill** is the material that fills a cut — the sediment, artifacts, and debris that accumulated or were deposited inside it.

- Must belong to a cut via `parentCutId`
- Has sediment description fields: `composition`, `color`, `compaction`, `inclusions`
- Has a `contextNumber` (its own, from the same site sequence)

**Key constraint**: a fill cannot exist without a parent cut. In the app, the form will refuse to open if no cuts exist in the feature yet.

**Context numbers**: assigned from an external site-wide sequence. The app stores them as integers. Duplicate context numbers within a feature produce a warning (not a hard block) because sites sometimes intentionally reuse context numbers for related deposits.

---

## Photo

A **photo record** captures the metadata of a photograph taken of a feature during excavation. The important distinction: the app records the **photo number from the site camera**, not just a phone image.

Most professional excavations use a dedicated camera and maintain a photo register with running numbers. The app stores that number in `manualCameraPhotoNumber`. A phone reference image (`localImagePath`) is optional and secondary.

**Photo stages**:
- `preEx` — taken before excavation begins
- `midEx` — taken with half the feature excavated (section visible)
- `workingShot` — any notable detail or observation during excavation
- `postEx` — taken after full excavation

**Cardinal orientation**: every photo records which direction it faces (N, NE, E, SE, S, SW, W, NW, or unknown). This is standard practice on UK excavations.

---

## Drawing

A **drawing record** logs a physical plan or section drawing made of the feature. Like photos, the important data is the **drawing number** (from a site-wide sequence) and optionally the drawing board number.

Fields: `drawingNumber`, `boardNumber`, `notes`

---

## Find

A **find** is a recovered artifact or material culture object. Finds are always recovered from a fill — the provenance matters.

- Must be linked to a fill via `fillId`
- `findNumber` is assigned per-feature (the app suggests the next available number)
- `materialType`: flint, stone, ceramic, metal, bone, shell, glass, other
- `quantity`: how many items (default 1)
- `description`: optional text

**Note**: find numbers are suggested (max + 1 within the feature) but not globally unique — unlike sample numbers. The app does not currently warn on duplicate find numbers.

---

## Sample

A **sample** is a sediment sample taken from a fill for scientific analysis (radiocarbon, pollen, micromorphology, etc.).

- Must be linked to a fill via `fillId`
- `cutId` is denormalized (copied from `fill.parentCutId`) for convenience
- `sampleNumber` is **globally unique across all features** — site sample registers are project-wide
- `sampleType`: soil, soil+charcoal, bulk, pollen, other
- `storageType`: bucket, bag, jar, other
- `liters`: optional volume

**Uniqueness**: duplicate sample number produces a warning (user can confirm and override).

---

## Harris Matrix

The **Harris Matrix** is a standard tool in stratigraphic archaeology. It is a directed acyclic graph that represents the sequence of stratigraphic events — which context is earlier or later than another, or which cut truncates which fill.

In ContextLog, a `HarrisRelationModel` represents one directed edge between two contexts.

**Relation types**:
| Type | Meaning |
|---|---|
| `above` | `from` is stratigraphically later (higher) than `to` |
| `below` | `from` is stratigraphically earlier (lower) than `to` |
| `cuts` | `from` (a cut) cuts into `to` |
| `cutBy` | `from` is cut by `to` |
| `equalTo` | Both contexts represent the same deposit |
| `contemporaryWith` | Both contexts are broadly contemporary |

The `above`/`below` and `cuts`/`cutBy` pairs are inverses of each other. In the layout algorithm, `above` and `cuts` create downward edges (earlier contexts are drawn lower), while `below` and `cutBy` reverse the direction. `equalTo` and `contemporaryWith` are drawn as dashed lines and don't affect the topological layout.

See `docs/11-harris-matrix.md` for implementation details.

---

## Entity relationships (summary)

```
Feature (1) ──── (many) Photo
Feature (1) ──── (many) Drawing
Feature (1) ──── (many) Context [Cut or Fill]
                          Fill (many) ──── (1) Cut [parentCutId]
Feature (1) ──── (many) Find
                          Find (many) ──── (1) Fill [fillId]
Feature (1) ──── (many) Sample
                          Sample (many) ──── (1) Fill [fillId]
                          Sample (many) ──── (1) Cut  [cutId, denormalized]
Feature (1) ──── (many) HarrisRelation
                          Relation ──── fromContext (any Context)
                          Relation ──── toContext   (any Context)
```

---

## Domain rules in plain English

1. A fill must belong to a cut in the same feature.
2. A find must be assigned to a fill in the same feature.
3. A sample must be assigned to a fill in the same feature; its cut is derived from that fill.
4. Context numbers must be positive integers. Duplicates within a feature are warned, not blocked.
5. Sample numbers are globally unique. Duplicates anywhere produce a warning.
6. Feature identity = site + trench + area + featureNumber. Duplicates are hard-blocked.
7. A Harris relation cannot connect a context to itself.
8. All records belong to exactly one feature. Deleting a feature deletes all its children.
