# ContextLog

ContextLog is an Android field recording app for archaeologists. It is designed to replace notebook-based note taking during excavation and make it easier to record the full lifecycle of an archaeological feature directly from a mobile phone.

The app is built for real excavation work, where data rarely gets entered in a neat linear order. Instead of forcing the user through a rigid sequence, ContextLog allows feature data to be recorded in whatever order makes sense on site, while still preserving relationships between contexts, fills, finds, samples, drawings, and photographs.

## Why this app exists

In day-to-day excavation, a lot of essential information gets written quickly into a notebook and later transferred into formal recording sheets. That works, but it creates friction:

- notes can be messy or incomplete
- information may be recorded out of order
- relationships between cuts, fills, finds, and samples can get lost
- later transcription takes time
- small details, like a photo number or drawing board number, can be forgotten

ContextLog is intended to reduce that friction. It gives archaeologists a structured but flexible way to capture feature data in the field, offline, on Android, with archaeology-specific workflows in mind.

## Main goals

- Replace handwritten notebook capture for archaeological features
- Support real excavation workflows rather than idealized ones
- Work fully offline in the field
- Allow data entry in any order
- Preserve relationships between archaeological contexts
- Provide a visual Harris Matrix for each feature
- Keep data accessible later through a feature list and detail view
- Stay practical, fast, and reliable on a phone screen

## Target users

ContextLog is primarily intended for:

- field archaeologists
- site assistants
- supervisors recording features on site
- excavation staff who need quick, structured recording in the field

Version 1 is designed for single-user use on one device, but the concept is intended to be expandable later if wider team use becomes necessary.

## Platform and scope

### Included in v1

- Android app
- Offline-first local storage
- Feature creation and editing
- Archaeological contexts management
- Photo number recording
- Optional phone reference photos
- Drawings, finds, and samples
- Harris Matrix visualization
- Searchable feature list
- Validation and duplicate protection

### Not included in v1

- iPhone support
- web version
- cloud sync
- user accounts
- team collaboration
- PDF export
- CSV export
- JSON export

## Core concept: the feature

A feature is the main record unit in the app.

Each feature contains its own metadata and associated archaeological records such as:

- pre-excavation photos
- mid-excavation photos
- working shots
- post-excavation photos
- drawings
- cut contexts
- fill contexts
- finds
- samples
- Harris Matrix relationships
- notes

Each feature is stored as a complete, consultable record.

## Feature metadata

Each feature has a core identity, including:

- site
- trench
- area
- feature number
- excavator
- date
- optional general notes

A feature is typically treated as unique through a combination such as:

`site + trench + area + feature number`

This helps prevent accidental duplication and makes features easier to locate later.

## Field workflow supported by the app

The app is based on a common excavation workflow, but it does not force the user to follow that order.

A user might do some of these steps in sequence, skip others for a while, or come back later to fill in missing information.

### 1. Pre-ex photos

Before excavation, one or more pre-excavation photographs may be taken.

Each photo entry stores:

- photo stage: pre-ex
- manual camera photo number
- cardinal orientation
- optional note
- optional phone reference image

The manual camera photo number remains the official record. The optional phone image is only for reference.

### 2. Drawings

At some point during excavation, the section or profile of the feature may be drawn.

Each drawing entry stores:

- drawing number
- drawing board number
- optional notes

A feature can have multiple drawings.

### 3. Mid-ex photos

Once half the feature has been excavated, one or more mid-ex photos may be taken.

Each photo entry stores:

- photo stage: mid-ex
- manual camera photo number
- cardinal orientation
- optional note
- optional phone reference image

### 4. Working shots

During excavation, notable or unusual details may need to be photographed.

These are recorded as working shots and use the same structure as other photos:

- photo stage: working shot
- manual camera photo number
- cardinal orientation
- optional note
- optional phone reference image

### 5. Contexts

Contexts are central to the app.

A context can be either:

- a cut
- a fill

Context numbers are entered manually because they come from an external site numbering system.

#### Cut contexts

A cut stores:

- context number
- context type: cut
- cut type
- custom cut type if needed
- dimensions:
  - height
  - width
  - depth
- notes

Preset cut types include examples such as:

- stakehole
- posthole
- pit
- kiln
- ditch
- linear feature
- hearth
- other

If "other" is selected, the user can enter a custom value.

#### Fill contexts

A fill stores:

- context number
- context type: fill
- parent cut
- composition
- color
- compaction
- inclusions
- notes

Each fill must belong to a cut.

### 6. Finds

Finds are recorded against a fill.

Each find stores:

- find number
- material or type
- custom material/type if needed
- quantity
- description
- source fill

Preset material/type options include:

- flint
- stone
- ceramic
- metal
- other

The app can suggest the next available find number within a feature, but the user can still enter the number manually.

### 7. Samples

Samples are recorded from fills.

Each sample stores:

- sample number
- fill
- cut
- sample type
- custom sample type if needed
- storage type
- liters

Preset sample types include:

- soil
- soil+charcoal
- other

Storage types include:

- bucket
- bag

The app validates that:

- the referenced fill already exists
- the selected cut matches the parent cut of that fill

This helps reduce recording errors on site.

### 8. Post-ex photos

Once excavation is complete, one or more post-ex photos may be recorded.

Each photo entry stores:

- photo stage: post-ex
- manual camera photo number
- cardinal orientation
- optional note
- optional phone reference image

## Flexible data entry

One of the main design principles of ContextLog is that excavation data must be enterable in any order.

Real site work is messy. Sometimes you get the context number first. Sometimes you record a photo number before you enter the cut. Sometimes you only add the sample later in the day. That is normal.

Because of this, the app:

- does not force a strict chronological workflow
- allows quick entry into any section
- supports editing later
- validates relationships where necessary
- warns about problems instead of assuming all data is entered in ideal order

## Harris Matrix

ContextLog includes a visual Harris Matrix for each feature.

The goal is to make stratigraphic relationships easier to understand at a glance, not just list them as text.

The matrix is intended to:

- show cuts and fills as labeled nodes
- show relationships between them as edges
- automatically create obvious cut-fill containment links
- allow the user to adjust or add relationships where needed
- support zooming and panning on a phone screen
- remain readable in real field conditions

Version 1 focuses on practical usefulness rather than academic perfection. The aim is to give archaeologists a genuinely usable matrix in the field, not a decorative placeholder.

## Photos and orientation

For all feature photo types, the app supports recording orientation using cardinal directions:

- N
- NE
- E
- SE
- S
- SW
- W
- NW
- unknown

This provides a consistent way to describe photo direction across the record.

The app can also optionally store a phone photo for quick visual reference, but that image is secondary to the typed photo number from the site camera workflow.

## Duplicate protection

Several record types use numbers obtained from external lists, such as:

- context numbers
- sample numbers
- drawing numbers
- camera photo numbers

These numbers matter. Reusing them by accident can create confusion.

To reduce this risk, the app should:

- warn when a number already exists locally
- prevent accidental duplicates by default
- allow an explicit override only when the user confirms it

This is especially important because fieldwork is fast, repetitive, and easy to get wrong when tired or rushed.

## User experience goals

ContextLog is designed as a field tool first.

That means the UI should prioritize:

- speed
- clarity
- editability
- large touch targets
- good offline behavior
- low-friction entry
- readable screens in outdoor conditions
- practical forms rather than flashy design

The app should feel calm and dependable. Not cluttered. Not over-designed.

## Main screens

### Feature list

The feature list is the main entry point.

It should provide:

- all saved features
- most recent items first
- summary information
- search
- filtering
- quick access to create a new feature

Typical visible information includes:

- site
- trench
- area
- feature number
- date
- excavator

### Feature detail

Each feature has a detail view with sections or tabs such as:

- Summary
- Photos
- Drawings
- Contexts
- Finds
- Samples
- Matrix

This keeps the feature record organized while still allowing quick navigation between parts.

### Quick add actions

The app should support quick-add actions to reduce friction, for example:

- add photo
- add drawing
- add cut
- add fill
- add find
- add sample

### Edit and delete flows

All stored records should be editable.

Deletion should always require confirmation to avoid accidental data loss.

## Validation rules

The app is expected to enforce helpful domain-aware validation, including cases such as:

- feature uniqueness
- duplicate context number warnings
- duplicate sample number warnings
- fill must belong to a cut
- find must belong to a fill
- sample must refer to an existing fill
- sample cut must match the selected fill's parent cut
- custom text required when "other" is selected
- numeric fields should only accept valid numeric input
- liters must be positive
- dimensions should be non-negative

Validation should guide the user without becoming overly obstructive.

## Offline-first design

ContextLog is designed to work without mobile coverage.

That means:

- local storage is the source of truth
- no network is required for normal use
- all forms and records work offline
- phone reference images are stored locally
- the app remains usable on site in remote locations

This is essential for archaeology, where trenches are not always anywhere near a strong signal.

## Suggested technical architecture

The intended stack for the project is:

- Flutter
- Android only
- Material 3 UI
- Riverpod for state management
- Drift + SQLite for local persistence
- feature-first folder structure
- repository pattern
- immutable models
- strong linting and strict analysis

This architecture is a good fit because it supports:

- maintainability
- relational data modeling
- offline persistence
- testability
- long-term growth

### Why Drift + SQLite

The domain has real relationships:

- a feature has many contexts
- a fill belongs to a cut
- a find belongs to a fill
- a sample belongs to a fill and cut
- photos and drawings belong to a feature

A relational database is a natural fit here.

### Why Flutter

Flutter is suitable because:

- it works well on Android
- it supports robust local apps
- it has good tooling
- it can produce fast mobile UIs
- it leaves open the possibility of future expansion

## Example data model

A simplified view of the domain might look like this:

- `Feature`
- `PhotoRecord`
- `DrawingRecord`
- `ContextRecord`
- `FindRecord`
- `SampleRecord`
- `StratigraphicRelation`

Where:

- a `Feature` owns photos, drawings, contexts, finds, and samples
- a `ContextRecord` may be a cut or fill
- a fill references a parent cut
- a find references a fill
- a sample references a fill and cut
- matrix relations connect contexts

## Testing expectations

Because this app is meant for real field use, testing matters.

Recommended coverage includes:

### Unit tests
- validation logic
- numbering logic
- relationship checks
- duplicate detection
- model conversions
- repository operations

### Widget tests
- feature creation flow
- add/edit context forms
- add/edit find forms
- add/edit sample forms
- photo entry flow
- validation feedback

### Integration tests
- create a feature offline
- add cuts and fills
- add finds and samples
- reopen and verify persistence
- view Harris Matrix

## Data safety and reliability

Field recording should not be fragile.

The app should protect the user through:

- autosave or draft preservation
- safe edit flows
- confirmation before destructive actions
- sensible defaults
- clear validation messages
- local data persistence
- predictable navigation

Even small details matter. For example, losing a sample number because a form was dismissed accidentally is not a minor inconvenience in the field.

## Future improvements

These are out of scope for v1, but sensible future directions include:

- PDF export for feature records
- CSV or JSON export
- cloud backup
- team sync
- shared numbering awareness across devices
- attachment of more image metadata
- custom site presets
- richer Harris Matrix editing
- direct output aligned to formal context sheets
- trench- or project-level dashboards

## Status

ContextLog is currently a defined project concept and product specification. It is intended to be implemented as a Flutter Android app using ECC-driven development workflows.

## Summary

ContextLog is a specialized archaeology field app built around one simple idea:

record feature data properly, in the field, without depending on a notebook, internet connection, or a rigid sequence of steps.

It is not a generic form app. It is meant to reflect how excavation actually works - with cuts, fills, finds, samples, drawings, photos, relationships, and the need to make sense of all of that later.

If built well, it should become the kind of tool that quietly saves time every day and reduces the chance of missing something important.
