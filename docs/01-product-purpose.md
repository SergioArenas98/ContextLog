# 01 — Product Purpose

## The real-world problem

Archaeological excavation produces a large volume of structured data in a short time under imperfect conditions: outdoor weather, muddy hands, noise, rushing, and imperfect mobile signal. The dominant recording method is still the handwritten notebook.

Notebook recording has predictable failure modes:
- Notes are illegible or incomplete under time pressure
- Relationships between records (which fill belongs to which cut, which sample came from which fill) are easy to get wrong or omit
- Numbers — context numbers, sample numbers, photo numbers, drawing numbers — come from external sequences and are prone to accidental reuse
- Notebook entries get transcribed later into formal recording sheets, creating a double-entry cost and an opportunity for transcription errors
- Notebooks cannot enforce any structure or validation

ContextLog exists to replace the notebook for primary feature data capture.

## Why offline mobile capture matters

Excavation sites are often in remote locations with no mobile signal. Any solution that depends on an internet connection is unreliable in the field. ContextLog stores all data locally in a SQLite database on the device and requires no network for any operation.

Additionally, field workers already carry Android phones. A dedicated phone app fits naturally into the workflow without requiring new hardware.

## Product goals

1. **Reduce data entry time** — Forms are fast, structured, and designed for one-handed use on a phone screen
2. **Prevent recording errors** — Validate relationships (fill needs a cut, find needs a fill) at entry time, not during post-processing
3. **Protect numbering sequences** — Warn before reusing context numbers, sample numbers, or other externally assigned numbers
4. **Capture the full feature lifecycle** — Pre-ex photos through post-ex photos, all in one record
5. **Support non-linear entry** — Accept data in whatever order the excavation actually happens
6. **Provide stratigraphic context** — A per-feature Harris Matrix helps archaeologists understand relationships without going back to paper
7. **Work reliably in the field** — Fast, stable, offline, battery-conscious

## Non-goals (v1)

- iOS or web versions
- Cloud sync or backup
- Team collaboration / multi-device shared data
- PDF or CSV export
- Formal context sheet output
- Project- or site-level dashboards
- Custom site presets or configuration
- Rich Harris Matrix editing (e.g. drag-and-drop repositioning)

## Target user profile

**Primary**: A field archaeologist on a UK-style excavation site. They are:
- Comfortable with standard UK excavation methodology (contexts, Harris Matrix, site numbering)
- Using an Android phone as their only personal device on site
- Often working quickly, under supervision, recording one feature at a time
- Familiar with the concepts of cuts, fills, finds, samples, drawings, and photographs as structured records

**Secondary**: A site supervisor who wants to review or verify records at end of day, or who captures their own features during excavation.

## Fieldwork constraints that shaped the app

- **One-handed use**: gloves, wet hands, or holding equipment means the UI must be large-target and operable with a thumb
- **Outdoor light**: screens must be readable in bright sunlight — high contrast, dark theme default
- **Interruptions**: forms must be safe to partially fill in and return to; no record should be lost if a form is dismissed
- **Speed**: each data entry interaction should be completable in seconds
- **Mud and dirt**: no precision tapping — 48dp minimum touch targets throughout
- **No assumptions about order**: archaeologists may discover a fill before recording the cut, or add a sample before the context number is finalized — the app allows this
- **Numbers matter**: in archaeology, context numbers, sample numbers, and photo numbers are permanent identifiers used in post-excavation. Getting them wrong has long-term consequences

## Cross-references

- Domain concepts → `docs/02-domain-model.md`
- Validation rules that enforce these constraints → `docs/09-validation-rules.md`
- UX decisions → `docs/07-ui-and-screens.md`
